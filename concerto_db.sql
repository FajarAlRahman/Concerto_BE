-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2024 at 01:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `concerto_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`) VALUES
(292, 'Sheila on 7'),
(293, 'Tulus'),
(294, 'Nidji'),
(295, 'Coldic'),
(296, 'Westlife'),
(297, 'Kaisar'),
(298, 'Roland Band'),
(299, 'Adromeda'),
(300, 'Rumah Sakit'),
(301, 'Reality Club'),
(302, 'Folklore'),
(303, 'Homefolks'),
(304, 'Jimmy and The Mistery'),
(305, 'SUM 41'),
(306, 'Raisa'),
(307, 'Vierratale'),
(308, 'Ndarboy'),
(309, 'Giyon Waton'),
(310, 'Langit Sore'),
(311, 'Afgan'),
(312, 'Lyodra'),
(313, 'Letto'),
(314, 'Shaggydog'),
(315, 'Ndarboy Genk'),
(316, 'Hindia'),
(317, 'Defrag'),
(318, 'Mr. Jono & Joni'),
(319, 'Aftershine'),
(320, 'Setia'),
(321, 'Morfen'),
(322, 'Iwan Fals'),
(323, 'Prisa'),
(324, 'Rebellion Rose'),
(325, 'Bravesboy'),
(326, 'Tiara Andini');

-- --------------------------------------------------------

--
-- Table structure for table `cartitems`
--

CREATE TABLE `cartitems` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`) VALUES
(3, 20, '2024-06-23 10:49:19'),
(4, 21, '2024-06-23 11:11:34');

-- --------------------------------------------------------

--
-- Table structure for table `chatmessages`
--

CREATE TABLE `chatmessages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatmessages`
--

INSERT INTO `chatmessages` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`) VALUES
(8, 20, 21, 'halo', '2024-06-23 05:34:55'),
(9, 21, 20, 'apa kabar', '2024-06-23 05:35:30'),
(10, 20, 21, 'baik baik saja', '2024-06-23 05:35:51'),
(11, 20, 21, 'hai hai', '2024-06-23 06:04:51'),
(12, 20, 21, 'tes 1', '2024-06-24 12:57:46'),
(13, 21, 20, 'tes 2', '2024-06-24 12:58:05'),
(14, 20, 21, 'halo', '2024-06-25 08:48:45');

-- --------------------------------------------------------

--
-- Table structure for table `concerts`
--

CREATE TABLE `concerts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `venue` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concerts`
--

INSERT INTO `concerts` (`id`, `name`, `date`, `venue`, `description`, `image_url`, `seller_id`) VALUES
(80, 'Sheila on 7', '2024-09-04', 'Sahid Raya Hotel & Convention Yogyakarta', 'Highlight\nSHEILA ON 7 LIVE IN CONCERT\n4 SEPTEMBER \'24', 'sheilaon7_13.png', 22),
(81, 'Bersua', '2024-04-27', 'Stadion Kridosono Yogyakarta', 'Di tengah keindahan Yogyakarta yang kaya akan budaya. BERSUA hadir sebagai panggung kebersamaan di mana musik menyatukan orang-orang dari berbagai latar belakang. Suatu acara di mana keluarga, sahabat, dan komunitas bisa bersatu dalam keindahan musik, merayakan keberagaman, dan menciptakan kenangan yang tak terlupakan.', 'bersua2.png', 22),
(82, 'WESTLIFE', '2024-06-07', 'Candi Prambanan', 'Bersiaplah untuk tenggelam dalam suasana nostalgia dalam konser Westlife: The Hits Tour 2024! Saksikan Shane Filan, Mark Feehily, Kian Egan, dan Nicky Byrne menyanyikan lagu-lagu hits mereka di atas panggung. Ini akan menjadi malam istimewa saat mereka memberikan penampilan terbaiknya dengan latar belakang megah Candi Prambanan.\r\n\r\nJangan lewatkan konser ini pada tanggal 7 Juni 2024 dan beli tiketnya sekarang juga! Kembali ke masa lalu dan nikmati suasana nostalgia di konser Westlife: The Hits Tour 2024. Bergabunglah dalam malam tak terlupakan ini, di mana Shane Filan, Mark Feehily, Kian Egan, dan Nicky Byrne akan menghibur kamu dengan lagu-lagu terbaik mereka secara langsung di atas panggung.\r\n\r\nDengan latar belakang Candi Prambanan yang menakjubkan, konser ini menjanjikan malam yang tak terlupakan bagi semua penggemar band asal Irlandia ini. Catat tanggalnya, 7 Juni 2024, dan amankan tiketmu sebelum kehabisan!', 'westlife16.png', 22),
(83, 'Jogjarockarta Festival', '2024-01-27', 'Stadium Kridosono Yogyakarta', 'Bersiaplah untuk malam yang luar biasa di Stadion Kridosono dengan JogjaROCKarta Festival 2024 pada 27 Januari 2024! Nikmati pertunjukan spektakuler dari Andromedha, Kaisar, dan Rolland yang akan membuat akhir pekan Anda tak terlupakan. Ajak teman-teman metalhead Anda untuk menambah keseruan dan bergabunglah dalam pesta rock terbesar di Yogyakarta ini. Jangan lewatkan perayaan epik ini, di mana panggung telah disiapkan, kerumunan yang liar, dan musik yang dijamin akan membuat jiwa Anda berteriak lebih banyak!', 'jogjarockarta8.png', 22),
(84, 'E-UPHONIA', '2024-05-11', 'Stadion Mandala Krida', 'E-Uphonia hadir membawakan pengalaman baru untukmu, dikemas dalam sebuah acara musik dengan melodi-melodi yang akan dibawakan oleh para perfomers yang akan membawa kita semua ke dalam pengalaman konser yang fantastis!\n\nSAVE THE DATE\n🗓11 Mei 2024\n📍Stadion Mandala Krida Yogyakarta\n\nSPECIAL PERFORMANCE by Reality Club, Rumah Sakit, and many more to be announced! 🎸✨\n\nTersedia juga tenant-tenant menarik yang turut hadir meramaikan E-Uphonia 2024 di Stadion Mandala Krida besok loh!! ', 'e-uphonia5.png', 22),
(85, 'SUM 41', '2024-03-01', 'Uptown Park, Summarecon Mall Serpong', 'Konser perdana dan pemungkas SUM 41 di Yogyakarta sebelum bubar! “Tour Of The Setting Sum - Final Tour”', 'sum 41_15.png', 22),
(86, 'Jogja Mix Music', '2024-06-04', 'Stadion Mandala Krida', 'Jogja Mix Music merupakan sebuah pertunjukan musik yang dikemas seperti mini carnival, dimana kegiatan ini tidak hanya menyajikan pertunjukan musik saja namun juga menyajikan spesial talk show, game show, serta food truck festival. Jogja Mix Music akan dilaksanakan pada tanggal 4 juni 2023 di parkiran stadion mandala krida Yogyakarta.', 'Jogja Mix Music7.png', 22),
(87, 'Cimphoria #7 Rumah Sakit', '2024-06-08', 'Stadion Mandala Krida', 'CIMPHORIA #7 merupakan acara penutup dari rangkaian acara CED 2024. Mengusung tema Wandering in Cimphoria Going Through the Atmosphere, kembali berkelana merasakan suasana di Cimphoria #7 yang akan menghadirkan UKM dari UAJY, Talent yang menarik, dan Guest Star yang terkenal dan pastinya asik.\r\n\r\nSo, let\'s grab yours!!!', 'cimporia3.png', 22),
(88, 'Rhapsody Nusantara', '2024-05-11', 'Candi Prambanan', 'angan berhenti Yang kau takutkan takkan terjadi. Buang rasa sunyi bareng Kunto Aji di Rhapsody Nusantara!\nTak hanya Kunto Aji, Rhapsody Nusantara juga menghadirkan penampilan spesial dari para musisi Tanah Air lainnya seperti Afgan, Lyodra, Letto, Shaggydog, Ndarboy Genk, dan masih banyak lagi!', 'Rhapsody Nusantara11.png', 22),
(89, 'Berdansalah - Karir ini tidak ada artinya', '2024-04-21', 'GOR Universitas Negeri Yogyakarta', 'Special Show Hindia Live in Yogyakarta: “Berdansalah, Karir Ini Tak Ada Artinya”', 'berdansalah1.png', 22),
(90, 'DEFRAG', '2024-06-04', 'GOR UNY Jogjakarta', 'Tahun 2020 menjadi penanda kolaborasi antara Hectic Creative dengan Hindia dalam acara Revel Gigs, yang dilaksanakan pada tanggal 31 Januari 2020 di PKKH Universitas Gadjah Mada, Yogyakarta. Momentum ini merupakan kedua kalinya Hindia menyapa Team Hindia, nama penggemar Baskara, di Kota Istimewa. Daniel Baskara Putra (dikenal dengan nama Hindia) memulai solo karir sejak tahun 2018 dengan merilis single \"No One Will Find Me\". Hingga kini, Hindia telah merilis berbagai karya, termasuk album kedua berjudul \"Lagipula Hidup Akan Berakhir\" pada tahun 2023, yang berisikan 24 track yang dibagi dalam dua bagian, termasuk \"Cincin\", \"Berdansalah, Karir Ini Tak Ada Artinya\", dan \"Kita Ke Sana\".', 'defrag4.png', 22),
(91, 'Joget-In Fest', '2024-06-22', 'Stadium Kridosono Yogyakarta', 'Joget-in Fest adalah sebuah pertunjukan kreasi putra dan putri bangsa, yang menghadirkan berbagai karya musik lintas genre, seni, dan budaya kepada masyarakat Indonesia. Pentas ini di selenggarakan oleh ekeskutif produser film “Jakarta vs Everybody”, mempersembahkan tur festival di negeri ini, dari satu kota ke kota lainnya. Bersiaplah untuk mereguk irama dan suasana beragam rasa, dan ikuti perjalanannya!', 'jogetin fest6.png', 22),
(92, 'Sahid Live Intimate Concert with Iwan Fals & Band', '2024-06-22', 'Sahid Raya Hotel & Convention Yogyakarta', 'Mengusung konsep tema \'Sahid Intimate Live in Concert with Iwan Fals\', konser ini bertujuan untuk membawa para penonton bernostalgia dan menikmati lagu-lagu legendaris Iwan Fals. Dilengkapi dengan fasilitas Grand Ballroom berkapasitas 1.500 penonton yang nyaman dengan kualitas standar fasilitas hotel bintang 4, konser ini akan menampilkan panggung megah yang memungkinkan penonton menikmati pertunjukan dengan mudah.', 'Iwan Fals12.png', 22),
(93, 'SMAVENSARY', '2024-06-29', 'Asha Akasa, Yogyakarta', 'Smavensary merupakan event tahunan SMAN 7 Yogyakarta untuk memperingati ulang tahun sekolah. Dalam rangka merayakan Lustrum ke-8, Smavensary tahun ini dibuka untuk umum. Dengan konsep “Diversity in Unity”, Smavensary 2024 bertujuan membawa keberagaman yang ada untuk menumbuhkan rasa persatuan di sekitar kita. Acara ini akan menampilkan pertunjukan dari penampil internal SMAN 7 Yogyakarta dan bintang tamu.', 'SMAVENSARY14.png', 22),
(94, 'Jurasik Fest 2024', '2024-09-08', 'Stadion Mandala Krida', 'Jurasik Fest kembali merayakan tahun ke-3 dengan penuh semangat pada tahun 2024! Setelah dua tahun sukses menyelenggarakan acara, festival ini kembali dengan format yang lebih menarik dan beragam. Tahun ini, pengunjung akan dimanjakan dengan berbagai pengalaman tak terlupakan, mulai dari penampilan panggung yang spektakuler hingga kegiatan interaktif yang menghibur.\n\nSetelah sukses menghadirkan Tulus dan Kunto Aji pada tahun 2022, serta Maliq & D’Essentials, Nadin Amizah, Sal Priadi, dan Coldiac pada tahun 2023, Jurasik Fest 2024 akan mempersembahkan deretan artis nasional yang akan menghibur dan memukau penonton. Tahun ini, Jurasik Fest kembali menggembirakan dengan mengundang bintang tamu yang tak kalah menarik dari sebelumnya.', 'Jurasik Fest9.jpeg', 22),
(95, 'Ndeso Run & Fun', '2024-08-25', 'Candi Banyunibo, Yogyakarta', 'Halo Runners, Ndeso Run & Fun akan hadir untuk mewarnai hari-hari di kehidupan kamu! Yuk, persiapkan dirimu untuk mengikuti Ndeso Run & Fun 2024 dengan keluarga maupun teman-teman kamu! Detail kegiatan akan kami umumkan segera, jadi jangan lupa untuk nyalakan notifikasi kamu biar nggak ketinggalan informasi terbaru dari kami. Jangan lupa untuk rajin latihan dan jaga kesehatan selalu! Ndeso Run & Fun 2024 \"Hidup sehat bersama kalian.\" \nPERIODE PENDAFTARAN:\n27 April 2024 - 23 Juni 2024. \nHARI & TANGGAL PELAKSANAAN: \nMinggu, 23 Juni 2024.', 'Ndeso Run Fun10.jpeg', 22),
(100, 'anjay gacor', '2024-06-30', 'jember', 'gacor kang', '', 24);

-- --------------------------------------------------------

--
-- Table structure for table `concert_artists`
--

CREATE TABLE `concert_artists` (
  `concert_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concert_artists`
--

INSERT INTO `concert_artists` (`concert_id`, `artist_id`) VALUES
(80, 292),
(81, 293),
(81, 294),
(81, 295),
(82, 296),
(83, 297),
(83, 298),
(83, 299),
(84, 300),
(84, 301),
(84, 302),
(84, 303),
(84, 304),
(85, 305),
(86, 306),
(86, 307),
(86, 308),
(86, 309),
(86, 310),
(87, 300),
(88, 311),
(88, 312),
(88, 313),
(88, 314),
(88, 315),
(89, 316),
(90, 316),
(90, 317),
(91, 314),
(91, 318),
(91, 319),
(91, 320),
(91, 321),
(92, 322),
(93, 323),
(93, 324),
(93, 325),
(94, 301),
(95, 326),
(100, 293);

-- --------------------------------------------------------

--
-- Table structure for table `concert_genres`
--

CREATE TABLE `concert_genres` (
  `concert_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concert_genres`
--

INSERT INTO `concert_genres` (`concert_id`, `genre_id`) VALUES
(80, 66),
(81, 66),
(81, 67),
(82, 66),
(83, 67),
(84, 66),
(84, 67),
(85, 67),
(85, 68),
(86, 66),
(86, 69),
(86, 70),
(86, 71),
(87, 66),
(88, 66),
(88, 72),
(89, 66),
(90, 66),
(91, 66),
(91, 67),
(91, 69),
(91, 73),
(92, 66),
(93, 66),
(94, 66),
(95, 66),
(100, 66);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`) VALUES
(66, 'Pop'),
(67, 'Rock'),
(68, 'Metal'),
(69, 'Dangdut'),
(70, 'Raggae'),
(71, 'Hip Hop'),
(72, 'Koplo'),
(73, 'Reggae');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'buyer'),
(2, 'seller');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `concert_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `concert_id`, `type`, `price`) VALUES
(80, 80, 'VVIP', 750000),
(81, 81, 'Festival', 150000),
(82, 82, 'VVIP', 3500000),
(83, 83, 'Presale 1', 450000),
(84, 84, 'Presale', 110000),
(85, 85, 'Festival A', 858000),
(86, 86, 'Early Entri', 159000),
(87, 87, 'Reguler - Festival', 95000),
(88, 88, 'Early Bird', 249000),
(89, 89, 'Tribun', 175000),
(90, 90, 'OTS: Tribun', 225000),
(91, 91, 'BE27OGET Festival (1 Person)', 100000),
(92, 92, 'Bronze', 350000),
(93, 93, 'Early Bird', 40000),
(94, 94, 'Early Bird', 115000),
(95, 95, 'Festival', 85000),
(96, 80, 'VIP', 500000),
(97, 80, 'Reguler', 250000),
(98, 81, 'Premium', 210000),
(99, 82, 'Diamond', 2900000),
(100, 82, 'Gold', 2400000),
(101, 82, 'Silver', 1900000),
(102, 82, 'Bronze', 1400000),
(103, 82, 'Festival', 700000),
(104, 85, 'Festival B', 658000),
(105, 86, 'Reguler', 179000),
(106, 86, 'VIP', 239000),
(107, 86, 'Reguler : Group Package 4 person', 650000),
(108, 86, 'Reguler : Group Package 6 Person', 950000),
(109, 86, 'Early Bird', 75000),
(110, 86, 'Reguler Flash Sale 5.5', 55000),
(111, 86, 'Presale 1', 110000),
(112, 86, 'Presale 2', 145000),
(113, 87, 'Reguler - Bestie 2 Person', 170000),
(114, 87, 'Reguler - Party 4 Person', 300000),
(115, 87, 'Early Bird - Festival', 35000),
(116, 87, 'Presale 1 - Festival', 65000),
(117, 87, 'Presale 2 - Festival', 85000),
(118, 88, 'Special Deals', 165000),
(119, 89, 'Festival ', 250000),
(120, 89, 'VIP', 350000),
(121, 90, 'OTS : DEFRAG X THXFSLT', 250000),
(122, 91, 'Presale 2 Festival (1 Person)', 100000),
(123, 91, 'Normal : Festival (1 Person)', 150000),
(124, 91, 'BE270GET VIP (1 Person)', 160000),
(125, 91, 'Presale 2 VIP ( 1 Person)', 230000),
(126, 92, 'Gold', 500000),
(127, 92, 'Platinum', 750000),
(128, 92, 'VIP', 1200000),
(129, 93, 'Batch 1', 50000),
(130, 93, 'Batch 2', 60000),
(131, 94, 'Presale 1', 145000),
(140, 100, 'vvvvvip', 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `transactionitems`
--

CREATE TABLE `transactionitems` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactionitems`
--

INSERT INTO `transactionitems` (`id`, `transaction_id`, `ticket_id`, `quantity`) VALUES
(13, 13, 81, 1),
(14, 14, 88, 1),
(15, 15, 113, 1),
(16, 15, 124, 1),
(17, 15, 126, 1),
(18, 16, 104, 1),
(19, 17, 113, 1),
(20, 17, 124, 1),
(21, 17, 126, 1),
(22, 18, 118, 1),
(23, 19, 81, 1),
(30, 22, 120, 1),
(31, 23, 81, 1),
(36, 26, 119, 1),
(39, 28, 120, 1),
(40, 29, 81, 1),
(41, 30, 119, 1),
(44, 34, 95, 1),
(45, 35, 90, 1),
(46, 36, 98, 1),
(47, 37, 98, 1),
(48, 37, 121, 1),
(49, 38, 119, 1),
(50, 39, 81, 1),
(51, 39, 121, 1),
(52, 40, 121, 1),
(53, 40, 84, 1),
(54, 41, 90, 1),
(55, 42, 113, 1),
(56, 43, 84, 1),
(57, 43, 123, 1),
(58, 44, 82, 1),
(59, 45, 98, 1),
(60, 46, 81, 1),
(61, 47, 121, 1),
(62, 48, 90, 1),
(63, 48, 95, 1),
(64, 49, 114, 1),
(65, 50, 114, 1),
(66, 51, 84, 1),
(67, 52, 121, 1),
(68, 52, 106, 1);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `status` enum('SUCCESS','FAILURE') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `total_amount`, `payment_method`, `status`, `created_at`) VALUES
(13, 20, 155000.00, 'Bank Transfer', '', '2024-06-23 05:12:28'),
(14, 21, 254000.00, 'Bank Transfer', '', '2024-06-23 05:14:09'),
(15, 20, 835000.00, 'Bank Transfer', '', '2024-06-23 10:00:14'),
(16, 21, 663000.00, 'Bank Transfer', '', '2024-06-23 10:04:56'),
(17, 20, 835000.00, 'Bank Transfer', '', '2024-06-23 10:05:49'),
(18, 21, 170000.00, 'Bank Transfer', '', '2024-06-23 10:13:02'),
(19, 21, 155000.00, 'Bank Transfer', '', '2024-06-23 10:25:04'),
(20, 21, 1173000.00, 'Bank Transfer', '', '2024-06-23 10:25:21'),
(21, 21, 1173000.00, 'Bank Transfer', '', '2024-06-23 10:25:36'),
(22, 20, 355000.00, 'Bank Transfer', '', '2024-06-23 10:27:23'),
(23, 20, 155000.00, 'Bank Transfer', '', '2024-06-23 10:27:54'),
(24, 20, 215000.00, 'Bank Transfer', '', '2024-06-23 10:28:22'),
(25, 20, 215000.00, 'Bank Transfer', '', '2024-06-23 10:37:25'),
(26, 20, 255000.00, 'Bank Transfer', '', '2024-06-23 10:39:05'),
(27, 20, 215000.00, 'Bank Transfer', '', '2024-06-23 10:39:30'),
(28, 20, 355000.00, 'Bank Transfer', '', '2024-06-23 10:48:51'),
(29, 20, 155000.00, 'Bank Transfer', '', '2024-06-23 10:49:06'),
(30, 20, 255000.00, 'Bank Transfer', '', '2024-06-23 10:56:26'),
(31, 20, 240000.00, 'Bank Transfer', '', '2024-06-23 10:57:19'),
(32, 21, 165000.00, 'Bank Transfer', '', '2024-06-23 11:10:08'),
(33, 21, 863000.00, 'Bank Transfer', '', '2024-06-23 11:11:19'),
(34, 20, 90000.00, 'Bank Transfer', '', '2024-06-23 11:31:58'),
(35, 20, 230000.00, 'Bank Transfer', '', '2024-06-23 11:32:29'),
(36, 20, 215000.00, 'Bank Transfer', '', '2024-06-23 11:53:14'),
(37, 20, 465000.00, 'Bank Transfer', '', '2024-06-23 11:54:10'),
(38, 20, 255000.00, 'Bank Transfer', '', '2024-06-23 11:58:01'),
(39, 20, 405000.00, 'Bank Transfer', '', '2024-06-23 12:15:23'),
(40, 20, 365000.00, 'Bank Transfer', '', '2024-06-23 12:16:17'),
(41, 20, 230000.00, 'Bank Transfer', '', '2024-06-23 12:21:23'),
(42, 20, 175000.00, 'Bank Transfer', '', '2024-06-23 12:21:49'),
(43, 20, 265000.00, 'Bank Transfer', '', '2024-06-23 12:22:14'),
(44, 20, 3505000.00, 'Bank Transfer', '', '2024-06-23 12:56:45'),
(45, 20, 215000.00, 'Bank Transfer', '', '2024-06-24 12:48:58'),
(46, 20, 155000.00, 'Bank Transfer', '', '2024-06-24 12:52:11'),
(47, 20, 255000.00, 'Bank Transfer', '', '2024-06-24 12:54:45'),
(48, 20, 315000.00, 'Bank Transfer', '', '2024-06-24 12:57:20'),
(49, 20, 305000.00, 'Bank Transfer', '', '2024-06-25 08:47:34'),
(50, 20, 305000.00, 'Bank Transfer', '', '2024-06-25 08:47:36'),
(51, 20, 115000.00, 'Bank Transfer', '', '2024-06-25 08:48:04'),
(52, 20, 494000.00, 'Bank Transfer', '', '2024-06-25 08:48:32');

-- --------------------------------------------------------

--
-- Table structure for table `userpreferences`
--

CREATE TABLE `userpreferences` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `artist_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userpreferences`
--

INSERT INTO `userpreferences` (`id`, `user_id`, `genre_id`, `artist_id`) VALUES
(11, 20, 66, NULL),
(12, 20, NULL, 317),
(13, 21, 67, NULL),
(14, 21, NULL, 311);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone_number`, `password`, `role_id`, `created_at`, `updated_at`) VALUES
(20, 'Kimi Dandy Yudanarko', 'akun1@gmail.com', '085210035577', '$2b$10$wyAROrrGWH874dA3uuRv9OkghFeaCIQs1Mw..T.cMwJZoGHUpoOa.', 1, '2024-06-23 05:11:48', '2024-06-28 09:51:22'),
(21, 'Lina Liliana', 'akun2@gmail.com', '085210035578', '$2b$10$pWH0X3HGRfOvMTguQQQC5uoZT2qTnaB6idDhgeQLHniO08BOCtm6e', 1, '2024-06-23 05:13:43', '2024-06-25 11:05:05'),
(22, 'Kenzie Dandy Tanarko', 'akun3@gmail.com', '085210035579', '$2b$10$lE7rAPj4QDIEVZ1/0GePkeduPZb87mRxQBk0JjtAUZOcNwKw6KH9C', 2, '2024-06-25 09:22:36', '2024-06-25 11:05:13'),
(24, 'Kai Cenat', 'akun4@gmail.com', '085210035567', '$2b$10$VrgzdeZSb9SmIh5blsPcmuyFI5tTbDrqFosbDEFl3Rc.2IgnL.ky6', 2, '2024-06-28 10:50:00', '2024-06-28 10:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `favorite` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `user_id`, `bio`, `favorite`, `birthdate`, `province`, `city`, `gender`) VALUES
(7, 24, 'aku suka jkt49', NULL, NULL, 'Jawa Timur', 'Jember', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chatmessages`
--
ALTER TABLE `chatmessages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `concerts`
--
ALTER TABLE `concerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `concert_artists`
--
ALTER TABLE `concert_artists`
  ADD PRIMARY KEY (`concert_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `concert_genres`
--
ALTER TABLE `concert_genres`
  ADD PRIMARY KEY (`concert_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `concert_id` (`concert_id`);

--
-- Indexes for table `transactionitems`
--
ALTER TABLE `transactionitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `userpreferences`
--
ALTER TABLE `userpreferences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `genre_id` (`genre_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `cartitems`
--
ALTER TABLE `cartitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `chatmessages`
--
ALTER TABLE `chatmessages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `concerts`
--
ALTER TABLE `concerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `transactionitems`
--
ALTER TABLE `transactionitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `userpreferences`
--
ALTER TABLE `userpreferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD CONSTRAINT `cartitems_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cartitems_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chatmessages`
--
ALTER TABLE `chatmessages`
  ADD CONSTRAINT `chatmessages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chatmessages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `concert_artists`
--
ALTER TABLE `concert_artists`
  ADD CONSTRAINT `concert_artists_ibfk_1` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `concert_artists_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `concert_genres`
--
ALTER TABLE `concert_genres`
  ADD CONSTRAINT `concert_genres_ibfk_1` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `concert_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactionitems`
--
ALTER TABLE `transactionitems`
  ADD CONSTRAINT `transactionitems_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactionitems_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userpreferences`
--
ALTER TABLE `userpreferences`
  ADD CONSTRAINT `userpreferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userpreferences_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userpreferences_ibfk_3` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `user_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
