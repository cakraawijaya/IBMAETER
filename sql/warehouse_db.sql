-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2021 at 12:49 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `warehouse_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `arsip_komplain`
--

CREATE TABLE `arsip_komplain` (
  `no_arsipKomp` varchar(20) NOT NULL,
  `uid_arsipKomp` int(7) NOT NULL,
  `email_arsipKomp` varchar(99) NOT NULL,
  `judul_arsipKomp` varchar(100) NOT NULL,
  `isi_arsipKomp` varchar(256) NOT NULL,
  `foto_arsipKomp` varchar(256) NOT NULL,
  `waktu_arsipKomp` datetime NOT NULL,
  `status_arsipKomp` varchar(10) NOT NULL,
  `comment_arsipKomp` varchar(256) DEFAULT NULL,
  `commented_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `arsip_komplain`
--

INSERT INTO `arsip_komplain` (`no_arsipKomp`, `uid_arsipKomp`, `email_arsipKomp`, `judul_arsipKomp`, `isi_arsipKomp`, `foto_arsipKomp`, `waktu_arsipKomp`, `status_arsipKomp`, `comment_arsipKomp`, `commented_at`) VALUES
('K-060521-003-285', 3, 'erwin@gmail.com', 'tes arsip komplain 2', 'pengujian fitur arsip komplain nomor 2 dengan akun karyawan erwing.', '-', '2021-05-06 04:02:15', 'rejected', 'komplain ditolak. mohon ikuti tata cara penggunaan fitur agar fungsi bisa berjalan dengan benar', '2021-05-06 04:18:55'),
('K-060521-004-186', 4, 'billy@gantx.com', 'tes arsip komplain 1', 'pengujian fitur arsip komplain dari akun admin billy the kid.', '1620291388_6e1c76cd5a9168729744.png', '2021-05-06 03:56:28', 'accepted', 'komplain diterima. kami sedang memproses permasalahannya', '2021-05-06 04:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `detail_in`
--

CREATE TABLE `detail_in` (
  `no_in` int(5) NOT NULL,
  `no_log` varchar(99) NOT NULL,
  `id_item` int(4) NOT NULL,
  `jumlah_in` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_in`
--

INSERT INTO `detail_in` (`no_in`, `no_log`, `id_item`, `jumlah_in`) VALUES
(1, '', 0, 80),
(2, '', 0, 75),
(3, '', 3, 24),
(4, '', 13, 20),
(5, '', 9, 78),
(6, '', 2, 70),
(7, '', 1, 63),
(8, '', 4, 63),
(9, '', 1, 40),
(10, '', 9, 91),
(11, '', 8, 91),
(12, '', 9, 27),
(13, '', 8, 82),
(14, '', 9, 11),
(15, '', 4, 20),
(16, '', 8, 10),
(17, '', 3, 22),
(18, '', 1, 83),
(19, '', 4, 20),
(20, '', 4, 23);

-- --------------------------------------------------------

--
-- Table structure for table `detail_out`
--

CREATE TABLE `detail_out` (
  `no_out` int(5) NOT NULL,
  `no_log` varchar(99) NOT NULL,
  `id_item` int(4) NOT NULL,
  `jumlah_out` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_out`
--

INSERT INTO `detail_out` (`no_out`, `no_log`, `id_item`, `jumlah_out`) VALUES
(1, '', 3, 10),
(2, '', 1, 12),
(3, '', 15, 20);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id_item` int(4) NOT NULL,
  `nama_item` varchar(99) NOT NULL,
  `stok` int(4) NOT NULL,
  `jenis` varchar(25) NOT NULL,
  `penyimpanan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id_item`, `nama_item`, `stok`, `jenis`, `penyimpanan`) VALUES
(1, 'Sabun Mandieh', 33, 'Cair', 'B'),
(2, 'Antangin JRG', 11, 'Minyak', 'A'),
(3, 'Sikat Gigih', 44, 'Mudah Terbakar', 'D'),
(4, 'Pepsodent 102gr', 44, 'Cair', 'A'),
(5, 'Dodo Mainanmu', 22, 'Padat', 'C'),
(8, 'Mentari SimCard', 100, 'Padat', 'A'),
(9, 'Solonensi Ajaib', 33, 'Cair', 'C'),
(10, 'Bearbrando 210ml', 22, 'Cair', 'B'),
(15, 'So Clean 320ml', 12, 'Cair', 'C'),
(16, 'Betadine', 22, 'Cair', 'B'),
(17, 'Barang', 33, 'Cair', 'D'),
(20, 'Antangin Ngelu', 33, 'Padat', 'A'),
(21, 'Sikat Gigih', 44, 'Mudah Terbakar', 'F'),
(22, 'Dodo Sakti', 44, 'Minyak', 'D'),
(23, 'Mixin 210ml', 12, 'Cair', 'C'),
(24, 'Madu Kuat 210ml', 15, 'Mudah Terbakar', 'C'),
(25, 'Mayoness', 24, 'Minyak', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `komplain`
--

CREATE TABLE `komplain` (
  `no_komplain` varchar(22) NOT NULL,
  `uid_komplain` int(7) NOT NULL,
  `email_komplain` varchar(99) NOT NULL,
  `judul_komplain` varchar(100) NOT NULL,
  `isi_komplain` varchar(256) NOT NULL,
  `foto_komplain` varchar(256) NOT NULL,
  `waktu_komplain` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `komplain`
--

INSERT INTO `komplain` (`no_komplain`, `uid_komplain`, `email_komplain`, `judul_komplain`, `isi_komplain`, `foto_komplain`, `waktu_komplain`) VALUES
('K-020521-001-435', 1, 'saber.genshin@gmail.com', 'tes ke 3', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ad cupiditate at cum, recusandae maiores enim debitis similique et sapiente soluta, minus dolor. Temporibus, tempore. Id mollitia ex voluptate vero sunt.', '1619973275_831f9e7fe4ad87c90ade.png', '2021-05-02 11:34:35'),
('K-020521-003-194', 3, 'erwin@gmail.com', 'Lembur bagai quda', 'permaslahan pada alur data dari manejer ke pegawai dan sebaliknya. bla bla bla.', '-', '2021-05-02 11:32:14'),
('K-020521-004-229', 4, 'billy@gantx.com', 'Fotonya menjadi blur', 'pada saat upload foto saya di side bar menjadi blur. padahal foto saya sudah beresolusi tinggi', '-', '2021-05-02 10:56:34');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `no_log` varchar(99) NOT NULL,
  `uid` int(7) NOT NULL,
  `tgl` datetime NOT NULL,
  `status` varchar(50) NOT NULL,
  `ket` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`no_log`, `uid`, `tgl`, `status`, `ket`) VALUES
('1', 0, '2021-04-23 13:44:00', 'Masuk', 'lorem ipsum dolar amit amit jabang bayi'),
('10', 1, '2021-04-02 15:57:00', 'Masuk', 'test'),
('11', 1, '2021-04-03 15:57:00', 'Keluar', 'sesat'),
('2', 0, '2021-04-29 13:45:00', 'Masuk', 'lorem ipsum dolar amit amit jabang bayi'),
('3', 0, '2021-04-10 13:45:00', 'Masuk', 'lorem ipsum dolar amit amit jabang bayi'),
('4', 1, '2021-04-25 14:16:00', 'Masuk', ''),
('6', 1, '2021-04-23 14:40:00', 'Masuk', 'hay'),
('7', 1, '2021-04-04 16:40:00', 'Masuk', 'nunggak 1 bulan'),
('8', 1, '2021-04-02 15:50:00', 'Masuk', 'butuh 10 dari toko wkwk'),
('9', 1, '2010-01-21 14:02:00', 'Keluar', 'wkwkwk');

-- --------------------------------------------------------

--
-- Table structure for table `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `isi` varchar(256) NOT NULL,
  `foto` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pengumuman`
--

INSERT INTO `pengumuman` (`id`, `judul`, `isi`, `foto`) VALUES
(1, 'Jadwal Supplier Masuk Mei 2025', '1. pt indah\r\n2. pt makmur\r\n3. pt sentosa\r\n4. pt awokawok\r\n5. pt entahlah\r\n', 'gambar.jpeg'),
(2, 'Employee of The Month April 2021', 'Beidou', 'lol.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` int(7) NOT NULL,
  `nama` varchar(99) NOT NULL,
  `email` varchar(99) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(1) NOT NULL,
  `picture` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `nama`, `email`, `password`, `role`, `picture`) VALUES
(1, 'Jean', 'saber.genshin@gmail.com', '$2y$10$LHZUsw3/Spyma54o8ydNiO0CGisJuYkGeEtzB7LmX8iDgvrSC5ASC', 0, '1620096456_33597a2991cdf418daf9.jpg'),
(2, 'Faisal', 'electro.chuuni@gmail.com', '$2y$10$q3BbIRyeSUpLixJVilJx3OvRAZoFNCx4m2rjWzcUkenJfcxMVYKnm', 1, 'default.jpg'),
(3, 'Keqing', 'erwin@gmail.com', '$2y$10$V/J2qy22xUZQEWkzVFbvAORqyDszdR8J3q/ky9fezAyb2WA.4AaGC', 1, '1618761348_0d6cfd8bfdb4c0d5d4d9.png'),
(4, 'Billy The Kid', 'billy@gantx.com', '$2y$10$tmoYOn9VURgpCYO1.ixjmeXa73UH5n04Q.VgbEFiukbIvl6BGGsDO', 0, '1619230730_6d92a3eb08a00cef7a9d.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `arsip_komplain`
--
ALTER TABLE `arsip_komplain`
  ADD PRIMARY KEY (`no_arsipKomp`);

--
-- Indexes for table `detail_in`
--
ALTER TABLE `detail_in`
  ADD PRIMARY KEY (`no_in`);

--
-- Indexes for table `detail_out`
--
ALTER TABLE `detail_out`
  ADD PRIMARY KEY (`no_out`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id_item`);

--
-- Indexes for table `komplain`
--
ALTER TABLE `komplain`
  ADD PRIMARY KEY (`no_komplain`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`no_log`);

--
-- Indexes for table `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_in`
--
ALTER TABLE `detail_in`
  MODIFY `no_in` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `detail_out`
--
ALTER TABLE `detail_out`
  MODIFY `no_out` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id_item` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;