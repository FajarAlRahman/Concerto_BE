const { query } = require("../Database/db");

const addToCart = async (req, res) => {
    const { concertId, ticketId, quantity } = req.body;
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        let cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);

        if (cart.length === 0) {
            const result = await query("INSERT INTO carts (user_id) VALUES (?)", [userId]);
            cart = { id: result.insertId };
        } else {
            cart = cart[0];
        }

        await query("INSERT INTO cartitems (cart_id, ticket_id, quantity) VALUES (?, ?, ?)", [cart.id, ticketId, quantity]);

        res.status(201).json({ message: "Item added to cart" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to add item to cart" });
    }
};

const getCartItems = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);

        if (cart.length === 0) {
            return res.status(200).json([]);
        }

        const cartId = cart[0].id;
        const items = await query(`
            SELECT ci.id, ci.ticket_id, ci.quantity, t.type AS ticket_type, t.price, t.concert_id, c.name AS concert_name, c.image_url 
            FROM cartitems ci 
            JOIN tickets t ON ci.ticket_id = t.id 
            JOIN concerts c ON t.concert_id = c.id 
            WHERE ci.cart_id = ?
        `, [cartId]);

        res.status(200).json(items);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to get cart items" });
    }
};

const deleteCartItem = async (req, res) => {
    const { id } = req.params;
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);

        if (cart.length === 0) {
            return res.status(400).json({ error: "Cart not found" });
        }

        await query("DELETE FROM cartitems WHERE id = ? AND cart_id = ?", [id, cart[0].id]);

        res.status(200).json({ message: "Item deleted from cart" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to delete item from cart" });
    }
};

const updateCartItemQuantity = async (req, res) => {
    const { id } = req.params;
    const { quantity } = req.body;
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const cart = await query("SELECT * FROM carts WHERE user_id = ?", [userId]);

        if (cart.length === 0) {
            return res.status(400).json({ error: "Cart not found" });
        }

        await query("UPDATE cartitems SET quantity = ? WHERE id = ? AND cart_id = ?", [quantity, id, cart[0].id]);

        res.status(200).json({ message: "Item quantity updated" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to update item quantity" });
    }
};

module.exports = { addToCart, getCartItems, deleteCartItem, updateCartItemQuantity };
