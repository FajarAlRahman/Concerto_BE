// server/Controller/chat.js
const { query } = require("../Database/db");
//halo
//halo1


// Get chat messages between two users
const getMessages = async (req, res) => {
    const { sender_id, receiver_id } = req.query;

    try {
        const messages = await query(`
            SELECT * FROM chatmessages 
            WHERE (sender_id = ? AND receiver_id = ?) 
               OR (sender_id = ? AND receiver_id = ?) 
            ORDER BY created_at
        `, [sender_id, receiver_id, receiver_id, sender_id]);

        res.json(messages);
    } catch (error) {
        console.error("Error fetching messages:", error);
        res.status(500).json({ error: "Failed to fetch messages" });
    }
};

// Send a new chat message
const sendMessage = async (req, res) => {
    const sender_id = req.session.userId; // Get sender_id from session
    const { receiver_id, message } = req.body;

    try {
        // Check if sender_id and receiver_id exist in the users table
        const [senderExists] = await query("SELECT id FROM users WHERE id = ?", [sender_id]);
        const [receiverExists] = await query("SELECT id FROM users WHERE id = ?", [receiver_id]);

        if (!senderExists || !receiverExists) {
            return res.status(400).json({ error: "Sender or receiver does not exist" });
        }

        await query(`
            INSERT INTO chatmessages (sender_id, receiver_id, message, created_at) 
            VALUES (?, ?, ?, NOW())
        `, [sender_id, receiver_id, message]);

        res.status(201).json({ message: "Message sent successfully" });
    } catch (error) {
        console.error("Error sending message:", error);
        res.status(500).json({ error: "Failed to send message" });
    }
};

// Get user details by ID
const getUserById = async (req, res) => {
    const { userId } = req.params;

    try {
        const [user] = await query("SELECT * FROM users WHERE id = ?", [userId]);
        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }
        res.json(user);
    } catch (error) {
        console.error("Error fetching user:", error);
        res.status(500).json({ error: "Failed to fetch user" });
    }
};

module.exports = {
    getMessages,
    sendMessage,
    getUserById
};
