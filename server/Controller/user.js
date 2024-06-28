const { query } = require("../Database/db");
const bcrypt = require('bcrypt');

const Register = async (req, res) => {
    const { full_name, email, phone_number, password, konfirmasi_password } = req.body;
    if (password !== konfirmasi_password) {
        return res.status(400).json({ msg: "Password dan Konfirmasi Password tidak cocok" });
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
        const userResult = await query("INSERT INTO users (full_name, email, phone_number, password, role_id) VALUES (?, ?, ?, ?, ?)", [full_name, email, phone_number, hashedPassword, 1]); // role_id 1 untuk buyer
        const userId = userResult.insertId;
        //console.log(`User registered: ${full_name} with ID: ${userId}`);
        res.json({ msg: "Registrasi Berhasil", userId });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Registrasi Gagal" });
    }
};

const RegisterSeller = async (req, res) => {
    const { full_name, email, phone_number, password, konfirmasi_password } = req.body;
    if (password !== konfirmasi_password) {
        return res.status(400).json({ msg: "Password dan Konfirmasi Password tidak cocok" });
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
        const userResult = await query("INSERT INTO users (full_name, email, phone_number, password, role_id) VALUES (?, ?, ?, ?, ?)", [full_name, email, phone_number, hashedPassword, 2]); // role_id 2 untuk seller
        const userId = userResult.insertId;
        res.json({ msg: "Registrasi Berhasil", userId });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Registrasi Gagal" });
    }
};

const SavePreferences = async (req, res) => {
    const { userId, genres, artists } = req.body;
    //console.log(`Saving preferences for User ID: ${userId}`);
    try {
        if (genres.length > 0) {
            for (const genre of genres) {
                const genreResult = await query("SELECT id FROM genres WHERE name = ?", [genre]);
                const genreId = genreResult[0]?.id;
                if (genreId) {
                    await query("INSERT INTO userpreferences (user_id, genre_id) VALUES (?, ?)", [userId, genreId]);
                    //console.log(`Genre preference saved: User ID: ${userId}, Genre ID: ${genreId}`);
                }
            }
        }

        if (artists.length > 0) {
            for (const artist of artists) {
                const artistResult = await query("SELECT id FROM artists WHERE name = ?", [artist]);
                const artistId = artistResult[0]?.id;
                if (artistId) {
                    await query("INSERT INTO userpreferences (user_id, artist_id) VALUES (?, ?)", [userId, artistId]);
                }
            }
        }

        res.json({ msg: "Preferensi Berhasil Disimpan" });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Gagal Menyimpan Preferensi" });
    }
};

const Login = async (req, res) => {
    const { email, password } = req.body;
    try {
        const userResult = await query("SELECT * FROM users WHERE email = ?", [email]);
        if (userResult.length === 0) {
            return res.status(400).json({ msg: "Email tidak ditemukan" });
        }

        const user = userResult[0];
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Password salah" });
        }

        req.session.userId = user.id; 

        res.json({ 
            userId: user.id, 
            full_name: user.full_name, 
            email: user.email, 
            role: user.role_id,  // Tambahkan role ke response
            msg: "Login Berhasil" 
        });
        console.log(req.session.userId);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Login Gagal" });
    }
};

const getProfile = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    try {
        const user = await query("SELECT * FROM users WHERE id = ?", [userId]);
        const userDetails = await query("SELECT * FROM user_details WHERE user_id = ?", [userId]);
        const userPreferences = await query("SELECT genre_id, artist_id FROM userpreferences WHERE user_id = ?", [userId]);

        let favorites = [];
        for (let pref of userPreferences) {
            if (pref.genre_id) {
                const genre = await query("SELECT name FROM genres WHERE id = ?", [pref.genre_id]);
                if (genre.length) {
                    favorites.push({ id: pref.genre_id, name: genre[0].name, type: 'genre' });
                }
            }
            if (pref.artist_id) {
                const artist = await query("SELECT name FROM artists WHERE id = ?", [pref.artist_id]);
                if (artist.length) {
                    favorites.push({ id: pref.artist_id, name: artist[0].name, type: 'artist' });
                }
            }
        }

        if (user.length && userDetails.length) {
            res.json({ ...user[0], ...userDetails[0], favorites });
        } else if (user.length) {
            res.json({ ...user[0], favorites });
        } else {
            res.status(404).json({ error: "User not found" });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to fetch user profile" });
    }
};


const updateProfile = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    const { full_name, bio, favorite, birthdate, province, city, gender, phone_number } = req.body;

    try {
        await query("UPDATE users SET full_name = ?, phone_number = ? WHERE id = ?", [full_name, phone_number, userId]);
        const existingUserDetails = await query("SELECT * FROM user_details WHERE user_id = ?", [userId]);

        if (existingUserDetails.length > 0) {
            await query(`
                UPDATE user_details SET bio = ?, favorite = ?, birthdate = ?, province = ?, city = ?, gender = ?
                WHERE user_id = ?
            `, [bio, favorite, birthdate, province, city, gender, userId]);
        } else {
            await query(`
                INSERT INTO user_details (user_id, bio, favorite, birthdate, province, city, gender) 
                VALUES (?, ?, ?, ?, ?, ?, ?)
            `, [userId, bio, favorite, birthdate, province, city, gender]);
        }

        res.json({ message: "Profile updated successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to update profile" });
    }
};

const getFavorites = async (req, res) => {
    try {
        const genres = await query("SELECT id, name FROM genres");
        const artists = await query("SELECT id, name FROM artists");
        res.json({ genres, artists });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to fetch favorites" });
    }
};

const changePassword = async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "User not authenticated" });
    }

    const { currentPassword, newPassword, confirmNewPassword } = req.body;

    if (newPassword !== confirmNewPassword) {
        return res.status(400).json({ error: "New password and confirm password do not match" });
    }

    try {
        const user = await query("SELECT * FROM users WHERE id = ?", [userId]);

        if (user.length === 0) {
            return res.status(404).json({ error: "User not found" });
        }

        const validPassword = await bcrypt.compare(currentPassword, user[0].password);

        if (!validPassword) {
            return res.status(400).json({ error: "Current password is incorrect" });
        }

        const hashedPassword = await bcrypt.hash(newPassword, 10);

        await query("UPDATE users SET password = ? WHERE id = ?", [hashedPassword, userId]);

        res.json({ message: "Password updated successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to update password" });
    }
};


module.exports = {
    Register,
    SavePreferences,
    Login,
    RegisterSeller,
    updateProfile,
    getProfile,
    getFavorites,
    changePassword,
};
