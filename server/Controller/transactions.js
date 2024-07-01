const { query } = require("../Database/db");
const { sendEmail } = require("./sendEmail");

const getUserById = async (req, res) => {
    const userId = req.session.userId;
    try {
        const user = await query(`SELECT * FROM users WHERE id = ?`, [userId]);
        res.json(user[0]);
    } catch (error) {
        console.error("Error fetching user data:", error);
        res.status(500).json({ error: "Gagal mengambil data pengguna" });
    }
};

const saveTransaction = async (req, res) => {
    const { userId, totalAmount, items, isDirectPurchase } = req.body;
    try {
        console.log("Start saving transaction");

        const ticketIds = items.map(item => item.ticketId);
        console.log("Ticket IDs received:", ticketIds);
        const tickets = await query(`SELECT id FROM tickets WHERE id IN (?)`, [ticketIds]);
        console.log("Valid ticket IDs:", tickets);
        if (tickets.length !== items.length) {
            console.error("Invalid ticket IDs");
            return res.status(400).json({ error: "Invalid ticket IDs" });
        }

        const transaction = await query(`
            INSERT INTO transactions (user_id, total_amount, payment_method, status, created_at)
            VALUES (?, ?, ?, 'pending', NOW())`, [userId, totalAmount, 'Bank Transfer']);
        
        const transactionId = transaction.insertId;
        console.log("Transaction created with ID:", transactionId);

        const promises = items.map(item => {
            return query(`
                INSERT INTO transactionitems (transaction_id, ticket_id, quantity)
                VALUES (?, ?, ?)`, [transactionId, item.ticketId, item.quantity]);
        });

        await Promise.all(promises);
        console.log("Transaction items inserted");

        const [user] = await query('SELECT email FROM users WHERE id = ?', [userId]);

        console.log("Sending emails");
        await Promise.all(items.map(async item => {
            const [ticket] = await query('SELECT type, price FROM tickets WHERE id = ?', [item.ticketId]);
            const [concert] = await query('SELECT name FROM concerts WHERE id = (SELECT concert_id FROM tickets WHERE id = ?)', [item.ticketId]);
            await sendEmail(user.email, concert.name, ticket.type, ticket.price);
        }));
        console.log("Emails sent");

        if (!isDirectPurchase) {
            const cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);
            if (cart.length > 0) {
                const cartId = cart[0].id;
                await query("DELETE FROM cartitems WHERE cart_id = ?", [cartId]);
            }
        }
        console.log("Cart items deleted if necessary");

        res.json({ transactionId });
    } catch (error) {
        console.error("Error saving transaction:", error);
        res.status(500).json({ error: "Gagal menyimpan transaksi" });
    }
};

const getRevenueData = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const concerts = await query("SELECT * FROM concerts WHERE seller_id = ?", [userId]);
        const concertCount = concerts.length;

        const transactions = await query(`
            SELECT t.id, t.total_amount, t.created_at 
            FROM transactions t 
            JOIN transactionitems ti ON t.id = ti.transaction_id 
            JOIN tickets tk ON ti.ticket_id = tk.id 
            JOIN concerts c ON tk.concert_id = c.id 
            WHERE c.seller_id = ?
        `, [userId]);

        // Pastikan total_amount diambil sebagai angka dengan parseFloat
        const totalRevenue = transactions.reduce((acc, curr) => acc + parseFloat(curr.total_amount), 0);
        console.log(totalRevenue);

        // Format totalRevenue sebagai string dengan pemisah ribuan
        const formattedTotalRevenue = totalRevenue.toLocaleString('id-ID', { style: 'currency', currency: 'IDR' });

        const salesData = transactions.map(transaction => ({
            date: transaction.created_at.toISOString().split('T')[0],
            dailyRevenue: parseFloat(transaction.total_amount)
        }));

        res.json({ concertCount, totalRevenue: formattedTotalRevenue, salesData });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to fetch revenue data" });
    }
};

const getSalesReport = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const salesData = await query(`
            SELECT 
                t.id AS transaction_id, 
                t.created_at AS sale_date, 
                c.name AS concert_name, 
                tk.type AS ticket_type, 
                tk.price AS ticket_price, 
                ti.quantity, 
                t.total_amount 
            FROM transactions t
            JOIN transactionitems ti ON t.id = ti.transaction_id
            JOIN tickets tk ON ti.ticket_id = tk.id
            JOIN concerts c ON tk.concert_id = c.id
            WHERE c.seller_id = ?
            ORDER BY t.created_at
        `, [userId]);

        res.json(salesData);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to fetch sales data" });
    }
};

module.exports = {
    getUserById,
    saveTransaction,
    getRevenueData,
    getSalesReport,
};
