const nodemailer = require('nodemailer');
require('dotenv').config();

const sendEmail = async (userEmail, concertName, ticketType, ticketPrice) => {
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS
        }
    });

    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: userEmail,
        subject: 'Konfirmasi Pembelian Tiket',
        text: `Terima kasih telah membeli tiket konser. Berikut detail transaksi Anda:
        - Konser: ${concertName}
        - Jenis Tiket: ${ticketType}
        - Harga: Rp ${ticketPrice.toLocaleString()}
        `
    };

    try {
        await transporter.sendMail(mailOptions);
        console.log('Email sent successfully');
    } catch (error) {
        console.error('Error sending email:', error);
    }
};

module.exports = { sendEmail };
