const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const { testConnection } = require('./Database/db.js');
const router = require('./Router/routes.js');
const session = require('express-session');

dotenv.config();

const app = express();
const PORT = process.env.APP_PORT || 3000;

app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true
}));
app.use(express.json());

app.use(session({
    secret: process.env.SESSION_SECRET || 'your_secret_key',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
}));

app.use((req, res, next) => {
    //console.log("Session Middleware:", req.session);
    next();
});

app.use(router);

app.get('/', (req, res) => {
    res.send('Server is running');
});

app.listen(PORT, async () => {
    await testConnection();
    console.log(`Server is running on http://localhost:${PORT}`);
});
