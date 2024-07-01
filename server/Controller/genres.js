const { query } = require("../Database/db");

const getGenres = async (req, res) => {
    try {
        const genres = await query("SELECT * FROM genres");
        res.json(genres);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch genres" });
    }
};

module.exports = {
    getGenres,
};
