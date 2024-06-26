const { query } = require("../Database/db");
const multer = require('multer');
const path = require('path');

const getAllConcerts = async (req, res) => {
    try {
        const concerts = await query(`
            SELECT concerts.*, MAX(tickets.price) as max_price 
            FROM concerts 
            LEFT JOIN tickets ON concerts.id = tickets.concert_id 
            GROUP BY concerts.id 
            ORDER BY concerts.name ASC
        `);
        res.json(concerts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Gagal mengambil data konser" });
    }
};

const getConcertById = async (req, res) => {
    const concertId = req.params.id;
    //console.log("Fetching details for concert ID:", concertId);
    try {
        const concert = await query(`
            SELECT c.id, c.name, c.date, c.venue, c.description, c.image_url, g.name AS genre, a.name AS artist
            FROM concerts c
            LEFT JOIN concert_genres cg ON c.id = cg.concert_id
            LEFT JOIN genres g ON cg.genre_id = g.id
            LEFT JOIN concert_artists ca ON c.id = ca.concert_id
            LEFT JOIN artists a ON ca.artist_id = a.id
            WHERE c.id = ?
        `, [concertId]);

        //console.log(concert);

        const tickets = await query(`
            SELECT id, type, price
            FROM tickets
            WHERE concert_id = ?
        `, [concertId]);

        if (concert.length > 0) {
            res.json({ ...concert[0], tickets });
        } else {
            res.status(404).json({ error: "Konser tidak ditemukan" });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Gagal mengambil detail konser" });
    }
};

const getRecommendedConcerts = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(400).json({ error: "User ID is required" });
    }

    try {
        const genres = await query("SELECT genre_id FROM userpreferences WHERE user_id = ? AND genre_id IS NOT NULL", [userId]);
        const artists = await query("SELECT artist_id FROM userpreferences WHERE user_id = ? AND artist_id IS NOT NULL", [userId]);

        const genreIds = genres.map(g => g.genre_id).filter(id => id !== null);
        const artistIds = artists.map(a => a.artist_id).filter(id => id !== null);

        let queryStr = `
            SELECT concerts.*, MAX(tickets.price) as max_price 
            FROM concerts 
            LEFT JOIN concert_genres ON concerts.id = concert_genres.concert_id 
            LEFT JOIN concert_artists ON concerts.id = concert_artists.concert_id 
            LEFT JOIN tickets ON concerts.id = tickets.concert_id 
            WHERE 1=1
        `;

        if (genreIds.length > 0 && artistIds.length > 0) {
            queryStr += ` AND (concert_genres.genre_id IN (${genreIds.join(",")}) OR concert_artists.artist_id IN (${artistIds.join(",")}))`;
        } else if (genreIds.length > 0) {
            queryStr += ` AND concert_genres.genre_id IN (${genreIds.join(",")})`;
        } else if (artistIds.length > 0) {
            queryStr += ` AND concert_artists.artist_id IN (${artistIds.join(",")})`;
        }

        queryStr += " GROUP BY concerts.id ORDER BY concerts.name ASC";

        const recommendedConcerts = await query(queryStr);
        res.json(recommendedConcerts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Gagal mengambil data rekomendasi konser" });
    }
};

const createConcert = async (req, res) => {
    const { name, venue, date, genre, artist, description, seller_id, categories } = req.body;

    try {
        // Debugging: Log received data
        console.log("Received Data:", req.body);

        let imageUrl = '';
        if (req.file) {
            imageUrl = req.file.filename; // Simpan nama file gambar ke imageUrl
            console.log("Image saved to:", imageUrl);
        } else {
            console.log("No image file received.");
        }

        // Insert concert
        const concertResult = await query("INSERT INTO concerts (name, venue, date, description, image_url, seller_id) VALUES (?, ?, ?, ?, ?, ?)", 
            [name, venue, date, description, imageUrl, seller_id]);
        const concertId = concertResult.insertId;
        console.log("Concert inserted with ID:", concertId);

        // Insert genres
        const genreResult = await query("SELECT id FROM genres WHERE name = ?", [genre]);
        const genreId = genreResult.length > 0 ? genreResult[0].id : null;
        if (genreId) {
            await query("INSERT INTO concert_genres (concert_id, genre_id) VALUES (?, ?)", [concertId, genreId]);
            console.log("Genre inserted with ID:", genreId);
        } else {
            console.log("Genre not found for name:", genre);
        }

        // Insert artists
        const artistResult = await query("SELECT id FROM artists WHERE name = ?", [artist]);
        const artistId = artistResult.length > 0 ? artistResult[0].id : null;
        if (artistId) {
            await query("INSERT INTO concert_artists (concert_id, artist_id) VALUES (?, ?)", [concertId, artistId]);
            console.log("Artist inserted with ID:", artistId);
        } else {
            console.log("Artist not found for name:", artist);
        }

        // Insert tickets
        const categoriesData = JSON.parse(categories);
        for (let category of categoriesData) {
            await query("INSERT INTO tickets (concert_id, type, price) VALUES (?, ?, ?)", [concertId, category.name, category.price]);
            console.log("Ticket category inserted:", category);
        }

        res.json({ msg: "Konser berhasil dibuat" });
        console.log("Concert creation successful");
    } catch (error) {
        console.error("Error during concert creation:", error);
        res.status(500).json({ error: "Gagal membuat konser" });
    }
};

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'client/public/assets/img');
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const upload = multer({ storage: storage });

module.exports = {
    getAllConcerts,
    getConcertById,
    getRecommendedConcerts,
    createConcert,
    upload,
};

