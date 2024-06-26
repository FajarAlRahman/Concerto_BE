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

        // Validasi apakah semua ticket_id ada di database
        const ticketIds = items.map(item => item.ticketId);
        console.log("Ticket IDs received:", ticketIds);
        const tickets = await query(`SELECT id FROM tickets WHERE id IN (?)`, [ticketIds]);
        console.log("Valid ticket IDs:", tickets);
        if (tickets.length !== items.length) {
            console.error("Invalid ticket IDs");
            return res.status(400).json({ error: "Invalid ticket IDs" });
        }

        // Insert transaksi
        console.log("Inserting transaction");
        const transaction = await query(`
            INSERT INTO transactions (user_id, total_amount, payment_method, status, created_at)
            VALUES (?, ?, ?, 'pending', NOW())`, [userId, totalAmount, 'Bank Transfer']);
        
        const transactionId = transaction.insertId;
        console.log("Transaction created with ID:", transactionId);

        // Insert item transaksi
        console.log("Inserting transaction items");
        const promises = items.map(item => {
            return query(`
                INSERT INTO transactionitems (transaction_id, ticket_id, quantity)
                VALUES (?, ?, ?)`, [transactionId, item.ticketId, item.quantity]);
        });

        await Promise.all(promises);
        console.log("Transaction items inserted");

        const [user] = await query('SELECT email FROM users WHERE id = ?', [userId]);

        // Send email logic for each item in the cart
        console.log("Sending emails");
        await Promise.all(items.map(async item => {
            const [ticket] = await query('SELECT type, price FROM tickets WHERE id = ?', [item.ticketId]);
            const [concert] = await query('SELECT name FROM concerts WHERE id = (SELECT concert_id FROM tickets WHERE id = ?)', [item.ticketId]);
            await sendEmail(user.email, concert.name, ticket.type, ticket.price);
        }));
        console.log("Emails sent");

        // Delete items from cart after transaction if the transaction is from cart
        if (!isDirectPurchase) {
            const cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);
            if (cart.length > 0) {
                const cartId = cart[0].id;
                await query("DELETE FROM cartitems WHERE cart_id = ?", [cartId]);
            }
        }
        console.log("Cart items deleted if necessary");

        // Hapus item dari sessionStorage setelah transaksi berhasil
        res.json({ transactionId });
    } catch (error) {
        console.error("Error saving transaction:", error);
        res.status(500).json({ error: "Gagal menyimpan transaksi" });
    }
};

module.exports = {
    getUserById,
    saveTransaction
};
