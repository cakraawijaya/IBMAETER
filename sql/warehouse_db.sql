-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2021 at 06:44 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id_absen` int(7) NOT NULL,
  `uid_absen` int(7) NOT NULL,
  `email_absen` varchar(99) NOT NULL,
  `absen` varchar(99) NOT NULL,
  `waktu_absen` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id_absen`, `uid_absen`, `email_absen`, `absen`, `waktu_absen`) VALUES
(1, 4, 'billy@gantx.com', 'Attendance', '2021-05-16 07:00:00'),
(2, 3, 'erwin@gmail.com', 'Attendance', '2021-05-16 07:33:00');

-- --------------------------------------------------------

--
-- Table structure for table `alur_barang`
--

CREATE TABLE `alur_barang` (
  `no_log` int(11) NOT NULL,
  `nama_pekerja` varchar(50) NOT NULL,
  `tgl` datetime NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `request` enum('Masuk','Keluar') NOT NULL COMMENT 'Awas dengan trigger!',
  `status` enum('Pending','Diterima','Ditolak') NOT NULL,
  `ubah_stok` int(11) NOT NULL,
  `ket` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alur_barang`
--

INSERT INTO `alur_barang` (`no_log`, `nama_pekerja`, `tgl`, `nama_barang`, `request`, `status`, `ubah_stok`, `ket`) VALUES
(26, 'Billy Gate', '2021-05-15 21:38:00', 'Antangin JRG', 'Masuk', 'Diterima', 14, 'PPP'),
(27, 'Billy Gate', '2021-05-16 06:29:43', 'Mentari SimCard', 'Keluar', 'Diterima', 20, 'Why'),
(28, 'Billy Gate', '2021-05-16 07:09:09', 'Antangin JRG', 'Masuk', 'Diterima', 40, '-'),
(31, 'Billy Gate', '2021-05-16 06:25:42', 'Soda Gembira 210ml', 'Masuk', 'Diterima', 6, 'Save Palestina'),
(32, 'Billy Gate', '2021-05-16 06:52:42', 'Dodo Mainanmu', 'Masuk', 'Ditolak', 13, 'Admin : Billy Gate\r\nBensin Abis'),
(36, 'Billy Gate', '2021-05-16 07:11:35', 'Mixin 210ml', 'Masuk', 'Diterima', 46, 'We Stand With Palestine!'),
(38, 'Billy Gate', '2021-05-16 07:33:23', 'Minyak Pijat 210ml', 'Keluar', 'Diterima', 20, '-'),
(39, 'Billy Gate', '2021-05-17 02:24:50', 'So Clean 320ml', 'Masuk', 'Diterima', 100, 'Tes Count Notifs Berhasil\r\n'),
(42, 'Billy Gate', '2021-05-17 02:35:01', 'Betadine 60ml', 'Masuk', 'Diterima', 100, 'Cek'),
(43, 'Billy Gate', '2021-05-17 02:38:13', 'So Clean 320ml', 'Keluar', 'Ditolak', 21, '-'),
(44, 'Billy Gate', '2021-05-17 02:39:07', 'Betadine 60ml', 'Keluar', 'Ditolak', 22, '-'),
(46, 'Billy Gate', '2021-05-17 02:56:35', 'Adem Sari 10gr', 'Masuk', 'Diterima', 500, 'cek trigger acc=&gt;masuk'),
(47, 'Billy Gate', '2021-05-17 02:57:25', 'Mentari SimCard 20GB/Bulan', 'Masuk', 'Ditolak', 500, 'cek trigger dec=&gt;masuk\r\n'),
(48, 'Billy Gate', '2021-05-17 14:53:00', 'Sabun Mandieh', 'Masuk', 'Pending', 98, 'cek cek'),
(49, 'Billy Gate', '2021-05-17 04:48:53', 'Baterai ABC 80gr', 'Masuk', 'Diterima', 98, '-'),
(50, 'Billy Gate', '2021-05-17 03:08:27', 'Mentari SimCard 20GB/Bulan', 'Masuk', 'Diterima', 500, 'cek trigger acc=&gt;masuk'),
(51, 'Billy Gate', '2021-05-17 03:06:29', 'Adem Sari 10gr', 'Keluar', 'Diterima', 30, 'cek trigger acc=&gt;keluar'),
(52, 'Billy Gate', '2021-05-17 03:07:21', 'Minyak Pijat 210ml', 'Keluar', 'Ditolak', 30, 'cek trigger dec=&gt;keluar'),
(53, 'Billy Gate', '2021-05-17 15:51:00', 'Antangin JRG', 'Keluar', 'Pending', 22, '-');

--
-- Triggers `alur_barang`
--
DELIMITER $$
CREATE TRIGGER `stok_dinamis` AFTER UPDATE ON `alur_barang` FOR EACH ROW BEGIN
IF(new.`status`="Diterima") THEN
IF (new.`request`="Masuk") THEN
	UPDATE `item` SET `item`.`stok` = `item`.`stok` + new.`ubah_stok`
	WHERE `item`.`nama_item` = new.`nama_barang`;
ELSEIF(new.`request`="Keluar") THEN
UPDATE `item` SET `item`.`stok` = `item`.`stok` - new.`ubah_stok`
	WHERE `item`.`nama_item` = new.`nama_barang`;
    END IF;
    END IF;
    END
$$
DELIMITER ;

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
('K-020521-003-194', 3, 'erwin@gmail.com', 'Lembur bagai quda', 'permaslahan pada alur data dari manejer ke pegawai dan sebaliknya. bla bla bla.', '-', '2021-05-02 11:32:14', 'accepted', 'ss', '2021-05-06 07:18:33'),
('K-060521-003-285', 3, 'erwin@gmail.com', 'tes arsip komplain 2', 'pengujian fitur arsip komplain nomor 2 dengan akun karyawan erwing.', '-', '2021-05-06 04:02:15', 'rejected', 'komplain ditolak. mohon ikuti tata cara penggunaan fitur agar fungsi bisa berjalan dengan benar', '2021-05-06 04:18:55'),
('K-060521-004-186', 4, 'billy@gantx.com', 'tes arsip komplain 1', 'pengujian fitur arsip komplain dari akun admin billy the kid.', '1620291388_6e1c76cd5a9168729744.png', '2021-05-06 03:56:28', 'accepted', 'komplain diterima. kami sedang memproses permasalahannya', '2021-05-06 04:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id_item` int(4) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `kode_barang` text NOT NULL COMMENT '[1]~ = alfabet tempat penyimpanan \r\n[2]~[3] = no Kategori\r\n[4]~[8] = no produksi',
  `nama_item` varchar(99) NOT NULL,
  `stok` int(4) NOT NULL,
  `jenis` varchar(50) NOT NULL,
  `penyimpanan` varchar(50) NOT NULL,
  `harga` int(11) NOT NULL COMMENT 'IDR only',
  `berat` float NOT NULL COMMENT 'gr/item'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id_item`, `id_supplier`, `kode_barang`, `nama_item`, `stok`, `jenis`, `penyimpanan`, `harga`, `berat`) VALUES
(1, 1, 'B034343', 'Sabun Mandieh', 34, 'Cair', 'B', 8000, 320),
(2, 2, 'A044344', 'Antangin JRG', 105, 'Minyak', 'A', 4500, 200),
(3, 4, 'D014345', 'Sikat WC ARG Medium', 44, 'Padat', 'D', 15000, 500),
(4, 1, 'A034346', 'Pepsodent 220gr', 44, 'Cair', 'A', 12000, 220),
(5, 2, 'C014347', 'Dodo Mainanmu', 48, 'Padat', 'C', 32000, 300),
(8, 3, 'A014348', 'Mentari SimCard 20GB/Bulan', 280, 'Padat', 'A', 80000, 100),
(9, 2, 'C034349', 'Solonensi Ajaib Herbal', 33, 'Cair', 'C', 4000, 120),
(10, 2, 'B034350', 'Bearbrando 210ml', 22, 'Cair', 'B', 7500, 220),
(15, 4, 'C034351', 'So Clean 320ml', 70, 'Cair', 'C', 14000, 370),
(16, 4, 'B034352', 'Betadine 60ml', 81, 'Cair', 'B', 8000, 120),
(17, 3, 'B014353', 'Baterai ABC 80gr', 110, 'Padat', 'B', 12000, 40),
(21, 1, 'F024354', 'Sikat Gigi B', 44, 'Mudah Terbakar', 'F', 8000, 135),
(22, 3, 'D014355', 'Coklat Atlantis S', 44, 'Padat', 'D', 5000, 158),
(23, 5, 'C034356', 'Mixin 210ml', 58, 'Cair', 'C', 65000, 197),
(24, 5, 'C024357', 'Madu Kuat 210ml', 15, 'Mudah Terbakar', 'C', 25000, 400),
(26, 5, 'D034358', 'Soda Gembira 210ml', 39, 'Cair', 'D', 10000, 550),
(27, 5, 'D044359', 'Minyak Pijat 210ml', 60, 'Minyak', 'D', 7800, 250),
(28, 6, 'A014360', 'El Perfume de cologne 150ml', 22, 'Padat', 'A', 89000, 300),
(30, 1, 'E014361', 'Adem Sari 10gr', 269, 'Padat', 'E', 2500, 24);

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
('K-020521-004-229', 4, 'billy@gantx.com', 'Fotonya menjadi blur', 'asda;sldkals aksdnalkdnal askdk', '-', '2021-05-02 10:56:34'),
('K-060521-029-780', 29, 'billy@gantx.com', 'Jam ku hilang', 'Woy !', '1620303698_f811c1c18114110d8994.jpg', '2021-05-06 07:21:38');

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
(1, 'Jadwal Supplier Masuk Mei 2025', '1. pt indah\r\n2. pt makmur\r\n3. pt sentosa\r\n4. EAST\r\n\r\n', 'image.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` char(20) NOT NULL,
  `alamat` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `no_telp`, `alamat`) VALUES
(1, 'Pt. Unileper', '081222320000', 'Jl. Kemayoran Baru kec. Salatiga Jakarta Barat'),
(2, 'Pt. Snakku', '0822222222', 'Jl. Selamat Jalan kec. Barong Kota Air'),
(3, 'Pt. Entahlah ', '081222320001', 'jl. dummy master22, kec. fake, kota Mastah2'),
(4, 'Pt. NgAB tbk', '081222320002', 'jl. dummy master33, kec. fake, kota Mastah3'),
(5, 'Pt. Biasakanlah tbk', '081222320003', 'jl. dummy master44, kec. fake, kota Mastah4'),
(6, 'Pt. Membagongkan', '081222320004', 'jl. dummy master55, kec. fake, kota Mastah5');

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
  `picture` varchar(256) NOT NULL,
  `department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `nama`, `email`, `password`, `role`, `picture`, `department`) VALUES
(1, 'Admin Zero', 'saber.genshin@gmail.com', '$2y$10$QXi1weaBbKVPYI4/0pyAiuFpv9cB7dFOhHAhjU4HLCdOHSpyG/ZP.', 0, 'venti.jpg', 'Information Technology'),
(8, 'Nikola Tesla', 'tesla@gmail.com', '$2y$10$WGSFqmKE91Tj5J9XD9zWl.a66QuWLozOrXJdE80gFrQxjwfXlG2q6', 0, 'keqing.jpg', 'Dokumentasi Aset'),
(22, 'Daemon Yukata', 'yukatadae@gmail.com', '$2y$10$XNRdXAxp7x8XXSGZWMs8Se9kvQPNnI63FVu3zQMO2mDo0fNbqa/gG', 0, 'default.jpg', 'Warehouse'),
(29, 'Billy Gate', 'billy@gantx.com', '$2y$10$ffptJql9WmysGHENlyUile/blayl4iLAvyvMRZd.9g2TaySULlfIG', 0, '1618827218_5cf23f7330b26292409a.jpg', 'Human Resource'),
(30, 'Erwin Edit', 'erwin1@gmail.com', '$2y$10$ejFPqAjB/GTlLSjqA323NO5bBYk/SlyUswJOAPh6Ojp16zSiEXtdO', 1, 'erwin.jpg', 'Inventarisasi Aset'),
(41, 'Makinami', 'makinami@gmail.com', '$2y$10$z7jEnwBvnj4/DBS.gU3f3.zgEiWXTfXZgU2Rs9/8dSiP6jX8q5IEe', 1, 'default.jpg', 'Spesifikasi Aset'),
(47, 'Einstein', 'einstein@gmail.com', '$2y$10$qkWqu1ODqi.744EeV3Re3OqBtLYnH8wxD4csHrJEylRU1jp.Ppgqi', 1, '1621160514_e284552c0c826a53b21a.jpg', 'Dokumentasi Aset'),
(53, '1234567', 'xcc@gmail.com', '$2y$10$RAe.OW6IAoNnIWBkXvMbAeHTbX8rHGCPIUl5esD2OZclnlT8DSMwu', 1, 'default.jpg', 'Information Technology'),
(69, 'Alfha Fierly Firdaus', 'alfhaff@invenbar.ac.id', '$2y$10$eNqNZPl9poDdVMwN2c1XFeCWN2PeCTnFS8GoYQTO8YJnd6YlVvQhe', 0, 'default.jpg', 'Founder');

-- --------------------------------------------------------

--
-- Table structure for table `user_activity`
--

CREATE TABLE `user_activity` (
  `id_aktivitas` int(7) NOT NULL,
  `uid_aktivitas` int(7) NOT NULL,
  `aktivitas` varchar(256) NOT NULL,
  `waktu_aktivitas` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id_absen`);

--
-- Indexes for table `alur_barang`
--
ALTER TABLE `alur_barang`
  ADD PRIMARY KEY (`no_log`);

--
-- Indexes for table `arsip_komplain`
--
ALTER TABLE `arsip_komplain`
  ADD PRIMARY KEY (`no_arsipKomp`);

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
-- Indexes for table `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`id_aktivitas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id_absen` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `alur_barang`
--
ALTER TABLE `alur_barang`
  MODIFY `no_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id_item` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `id_aktivitas` int(7) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
