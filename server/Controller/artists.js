const { query } = require("../Database/db");

const getArtists = async (req, res) => {
    try {
        const artists = await query("SELECT * FROM artists");
        res.json(artists);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch artists" });
    }
};

module.exports = {
    getArtists,
};
