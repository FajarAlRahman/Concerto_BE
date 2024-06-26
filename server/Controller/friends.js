// server/Controller/friends.js
const { query } = require("../Database/db");

const getAllData = async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from session
    try {
        const users = await query("SELECT * FROM users WHERE id != ?", [userId]); // Exclude the logged-in user
        const concerts = await query("SELECT * FROM concerts");
        const transactions = await query(`
            SELECT t.*, c.name as concert_name, c.id as concert_id 
            FROM transactions t 
            JOIN transactionitems ti ON t.id = ti.transaction_id 
            JOIN tickets tk ON ti.ticket_id = tk.id 
            JOIN concerts c ON tk.concert_id = c.id 
        `);
        //console.log(users);
        // console.log(concerts);
        // console.log(transactions);

        res.json({ users, concerts, transactions });
    } catch (error) {
        console.error("Error fetching data:", error);
        res.status(500).json({ error: "Failed to fetch data" });
    }
};

const getFriends = async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from session
    try {
        const friends = await query(`
            SELECT DISTINCT u.id, u.full_name 
            FROM users u
            JOIN chatmessages cm ON (u.id = cm.sender_id OR u.id = cm.receiver_id)
            WHERE (cm.sender_id = ? OR cm.receiver_id = ?) AND u.id != ?
        `, [userId, userId, userId]);

        res.json(friends);
    } catch (error) {
        console.error("Error fetching friends:", error);
        res.status(500).json({ error: "Failed to fetch friends" });
    }
};

module.exports = {
    getAllData,
    getFriends
};
