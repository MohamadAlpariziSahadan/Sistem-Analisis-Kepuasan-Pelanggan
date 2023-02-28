-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 25 Agu 2022 pada 16.54
-- Versi Server: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sistem-prediksi-kepuasan-pelanggan-2`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `atribut`
--

CREATE TABLE `atribut` (
  `id` int(11) NOT NULL,
  `atribut` varchar(30) NOT NULL,
  `nilai_atribut` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `atribut`
--

INSERT INTO `atribut` (`id`, `atribut`, `nilai_atribut`) VALUES
(1, 'total', 'total'),
(2, 'Pelayanan', 'Sangat Memuaskan'),
(3, 'Pelayanan', 'Memuaskan'),
(4, 'Pelayanan', 'Cukup Memuaskan'),
(5, 'Pelayanan', 'Tidak Memuaskan'),
(6, 'Biaya', 'Ada'),
(7, 'Biaya', 'Tidak Ada'),
(8, 'Kemampuan', 'Sangat Mampu'),
(9, 'Kemampuan', 'Mampu'),
(10, 'Kemampuan', 'Kurang Mampu'),
(11, 'Kemampuan', 'Tidak Mampu'),
(12, 'Sikap', 'Sangat Baik'),
(13, 'Sikap', 'Baik'),
(14, 'Sikap', 'Cukup Baik'),
(15, 'Sikap', 'Tidak Baik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil_prediksi`
--

CREATE TABLE `hasil_prediksi` (
  `tahap` int(1) NOT NULL,
  `jenis_layanan` varchar(30) NOT NULL,
  `jlh_training` int(3) NOT NULL,
  `jlh_uji` int(3) NOT NULL,
  `akurasi` int(3) NOT NULL,
  `recall_puas` int(3) NOT NULL,
  `recall_tdk_puas` int(3) NOT NULL,
  `precision_puas` int(3) NOT NULL,
  `precision_tdk_puas` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `hasil_prediksi`
--

INSERT INTO `hasil_prediksi` (`tahap`, `jenis_layanan`, `jlh_training`, `jlh_uji`, `akurasi`, `recall_puas`, `recall_tdk_puas`, `precision_puas`, `precision_tdk_puas`) VALUES
(1, 'Pelayanan Administrasi', 80, 20, 90, 100, 50, 88, 100),
(2, 'Pelayanan Administrasi', 90, 10, 90, 100, 50, 88, 100),
(1, 'Pelayanan Perkara', 80, 20, 90, 100, 33, 89, 100),
(2, 'Pelayanan Perkara', 90, 10, 90, 100, 50, 88, 100),
(1, 'Pelayanan Hukum', 80, 20, 90, 100, 0, 90, 0),
(2, 'Pelayanan Hukum', 90, 10, 90, 100, 0, 90, 0),
(1, 'Pelayanan Teknis', 80, 20, 95, 100, 66, 94, 100),
(2, 'Pelayanan Teknis', 90, 10, 90, 100, 50, 88, 100);

-- --------------------------------------------------------

--
-- Struktur dari tabel `iterasi_c45`
--

CREATE TABLE `iterasi_c45` (
  `id` int(11) NOT NULL,
  `iterasi` varchar(3) NOT NULL,
  `node` varchar(7) NOT NULL,
  `atribut_gain_ratio_max` varchar(255) NOT NULL,
  `nilai_att_max` varchar(100) NOT NULL,
  `atribut` varchar(100) NOT NULL,
  `nilai_atribut` varchar(100) NOT NULL,
  `jml_kasus_total` varchar(5) NOT NULL,
  `jml_puas` varchar(5) NOT NULL,
  `jml_tdk_puas` varchar(5) NOT NULL,
  `entropy` varchar(10) NOT NULL,
  `inf_gain` varchar(10) NOT NULL,
  `split_info` varchar(10) NOT NULL,
  `gain_ratio` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `iterasi_c45`
--

INSERT INTO `iterasi_c45` (`id`, `iterasi`, `node`, `atribut_gain_ratio_max`, `nilai_att_max`, `atribut`, `nilai_atribut`, `jml_kasus_total`, `jml_puas`, `jml_tdk_puas`, `entropy`, `inf_gain`, `split_info`, `gain_ratio`) VALUES
(1, '1', '1', 'Kemampuan', 'Total', 'Total', 'Total', '100', '83', '17', '0.6577', '', '', '0'),
(2, '2', '', 'Kemampuan', 'Sangat Memuaskan', 'Pelayanan', 'Sangat Memuaskan', '36', '36', '0', '0', '0.4532', '1.8219', '0.2488'),
(3, '3', '', 'Kemampuan', 'Memuaskan', 'Pelayanan', 'Memuaskan', '38', '37', '1', '0.1756', '0.4532', '1.8219', '0.2488'),
(4, '4', '', 'Kemampuan', 'Cukup Memuaskan', 'Pelayanan', 'Cukup Memuaskan', '15', '10', '5', '0.9183', '0.4532', '1.8219', '0.2488'),
(5, '5', '', 'Kemampuan', 'Tidak Memuaskan', 'Pelayanan', 'Tidak Memuaskan', '11', '0', '11', '0', '0.4532', '1.8219', '0.2488'),
(6, '6', '', 'Kemampuan', 'Ada', 'Biaya', 'Ada', '8', '0', '8', '0', '0.2326', '0.4022', '0.5783'),
(7, '7', '', 'Kemampuan', 'Tidak Ada', 'Biaya', 'Tidak Ada', '92', '83', '9', '0.4621', '0.2326', '0.4022', '0.5783'),
(8, '8', '', 'Kemampuan', 'Sangat Mampu', 'Kemampuan', 'Sangat Mampu', '40', '40', '0', '0', '0.4539', '1.7887', '0.2538'),
(9, '9', '', 'Kemampuan', 'Mampu', 'Kemampuan', 'Mampu', '36', '35', '1', '0.1831', '0.4539', '1.7887', '0.2538'),
(10, '10', '', 'Kemampuan', 'Kurang Mampu', 'Kemampuan', 'Kurang Mampu', '14', '8', '6', '0.9852', '0.4539', '1.7887', '0.2538'),
(11, '11', '', 'Kemampuan', 'Tidak Mampu', 'Kemampuan', 'Tidak Mampu', '10', '0', '10', '0', '0.4539', '1.7887', '0.2538'),
(12, '12', '', 'Kemampuan', 'Sangat Baik', 'Sikap', 'Sangat Baik', '36', '36', '0', '0', '0.4523', '1.7887', '0.2529'),
(13, '13', '', 'Kemampuan', 'Baik', 'Sikap', 'Baik', '40', '39', '1', '0.1687', '0.4523', '1.7887', '0.2529'),
(14, '14', '', 'Kemampuan', 'Cukup Baik', 'Sikap', 'Cukup Baik', '14', '8', '6', '0.9852', '0.4523', '1.7887', '0.2529'),
(15, '15', '', 'Kemampuan', 'Tidak Baik', 'Sikap', 'Tidak Baik', '10', '0', '10', '0', '0.4523', '1.7887', '0.2529'),
(16, '1', '1.1', 'Pelayanan', ' Kemampuan  Mampu', 'Total', 'Total', '36', '35', '1', '0.1831', '', '', '0'),
(17, '2', '', 'Pelayanan', 'Sangat Memuaskan', 'Pelayanan', 'Sangat Memuaskan', '0', '0', '0', '0', '0.1831', '0.4903', '0.3734'),
(18, '3', '', 'Pelayanan', 'Memuaskan', 'Pelayanan', 'Memuaskan', '33', '33', '0', '0', '0.1831', '0.4903', '0.3734'),
(19, '4', '', 'Pelayanan', 'Cukup Memuaskan', 'Pelayanan', 'Cukup Memuaskan', '2', '2', '0', '0', '0.1831', '0.4903', '0.3734'),
(20, '5', '', 'Pelayanan', 'Tidak Memuaskan', 'Pelayanan', 'Tidak Memuaskan', '1', '0', '1', '0', '0.1831', '0.4903', '0.3734'),
(21, '6', '', 'Pelayanan', 'Ada', 'Biaya', 'Ada', '0', '0', '0', '0', '0', '0', '0'),
(22, '7', '', 'Pelayanan', 'Tidak Ada', 'Biaya', 'Tidak Ada', '36', '35', '1', '0.1831', '0', '0', '0'),
(23, '8', '', 'Pelayanan', 'Sangat Baik', 'Sikap', 'Sangat Baik', '0', '0', '0', '0', '0', '0', '0'),
(24, '9', '', 'Pelayanan', 'Baik', 'Sikap', 'Baik', '36', '35', '1', '0.1831', '0', '0', '0'),
(25, '10', '', 'Pelayanan', 'Cukup Baik', 'Sikap', 'Cukup Baik', '0', '0', '0', '0', '0', '0', '0'),
(26, '11', '', 'Pelayanan', 'Tidak Baik', 'Sikap', 'Tidak Baik', '0', '0', '0', '0', '0', '0', '0'),
(27, '1', '1.2', 'Biaya', ' Kemampuan  Kurang Mampu', 'Total', 'Total', '14', '8', '6', '0.9852', '', '', '0'),
(28, '2', '', 'Biaya', 'Sangat Memuaskan', 'Pelayanan', 'Sangat Memuaskan', '0', '0', '0', '0', '0.0927', '0.3712', '0.2497'),
(29, '3', '', 'Biaya', 'Memuaskan', 'Pelayanan', 'Memuaskan', '1', '0', '1', '0', '0.0927', '0.3712', '0.2497'),
(30, '4', '', 'Biaya', 'Cukup Memuaskan', 'Pelayanan', 'Cukup Memuaskan', '13', '8', '5', '0.9612', '0.0927', '0.3712', '0.2497'),
(31, '5', '', 'Biaya', 'Tidak Memuaskan', 'Pelayanan', 'Tidak Memuaskan', '0', '0', '0', '0', '0.0927', '0.3712', '0.2497'),
(32, '6', '', 'Biaya', 'Ada', 'Biaya', 'Ada', '6', '0', '6', '0', '0.9852', '0.9852', '1'),
(33, '7', '', 'Biaya', 'Tidak Ada', 'Biaya', 'Tidak Ada', '8', '8', '0', '0', '0.9852', '0.9852', '1'),
(34, '8', '', 'Biaya', 'Sangat Baik', 'Sikap', 'Sangat Baik', '0', '0', '0', '0', '0', '0', '0'),
(35, '9', '', 'Biaya', 'Baik', 'Sikap', 'Baik', '0', '0', '0', '0', '0', '0', '0'),
(36, '10', '', 'Biaya', 'Cukup Baik', 'Sikap', 'Cukup Baik', '14', '8', '6', '0.9852', '0', '0', '0'),
(37, '11', '', 'Biaya', 'Tidak Baik', 'Sikap', 'Tidak Baik', '0', '0', '0', '0', '0', '0', '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mining_c45`
--

CREATE TABLE `mining_c45` (
  `id` int(11) NOT NULL,
  `atribut` varchar(100) NOT NULL,
  `nilai_atribut` varchar(100) NOT NULL,
  `jml_kasus_total` varchar(5) NOT NULL,
  `jml_puas` varchar(5) NOT NULL,
  `jml_tdk_puas` varchar(5) NOT NULL,
  `entropy` varchar(10) NOT NULL,
  `inf_gain` varchar(10) NOT NULL,
  `inf_gain_temp` varchar(10) NOT NULL,
  `split_info` varchar(10) NOT NULL,
  `split_info_temp` varchar(10) NOT NULL,
  `gain_ratio` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `mining_c45`
--

INSERT INTO `mining_c45` (`id`, `atribut`, `nilai_atribut`, `jml_kasus_total`, `jml_puas`, `jml_tdk_puas`, `entropy`, `inf_gain`, `inf_gain_temp`, `split_info`, `split_info_temp`, `gain_ratio`) VALUES
(1, 'Total', 'Total', '14', '8', '6', '0.9852', '', '', '', '', '0'),
(2, 'Pelayanan', 'Sangat Memuaskan', '0', '0', '0', '0', '0.0927', '0', '0.3712', '', '0.2497'),
(3, 'Pelayanan', 'Memuaskan', '1', '0', '1', '0', '0.0927', '0', '0.3712', '-0.2719539', '0.2497'),
(4, 'Pelayanan', 'Cukup Memuaskan', '13', '8', '5', '0.9612', '0.0927', '-0.8925428', '0.3712', '-0.0992784', '0.2497'),
(5, 'Pelayanan', 'Tidak Memuaskan', '0', '0', '0', '0', '0.0927', '0', '0.3712', '', '0.2497'),
(6, 'Biaya', 'Ada', '6', '0', '6', '0', '0.9852', '0', '0.9852', '-0.5238824', '1'),
(7, 'Biaya', 'Tidak Ada', '8', '8', '0', '0', '0.9852', '0', '0.9852', '-0.4613456', '1'),
(8, 'Sikap', 'Sangat Baik', '0', '0', '0', '0', '0', '0', '0', '', '0'),
(9, 'Sikap', 'Baik', '0', '0', '0', '0', '0', '0', '0', '', '0'),
(10, 'Sikap', 'Cukup Baik', '14', '8', '6', '0.9852', '0', '-0.9852', '0', '0', '0'),
(11, 'Sikap', 'Tidak Baik', '0', '0', '0', '0', '0', '0', '0', '', '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pohon_keputusan_c45`
--

CREATE TABLE `pohon_keputusan_c45` (
  `id` int(4) NOT NULL,
  `atribut` varchar(100) NOT NULL,
  `nilai_atribut` varchar(100) NOT NULL,
  `id_parent` char(3) DEFAULT NULL,
  `jml_puas` varchar(5) NOT NULL,
  `jml_tdk_puas` varchar(5) NOT NULL,
  `keputusan` varchar(100) NOT NULL,
  `diproses` varchar(10) NOT NULL,
  `kondisi_atribut` varchar(255) NOT NULL,
  `looping_kondisi` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pohon_keputusan_c45`
--

INSERT INTO `pohon_keputusan_c45` (`id`, `atribut`, `nilai_atribut`, `id_parent`, `jml_puas`, `jml_tdk_puas`, `keputusan`, `diproses`, `kondisi_atribut`, `looping_kondisi`) VALUES
(1, 'Kemampuan', 'Sangat Mampu', '0', '40', '0', 'Puas', 'Belum', 'AND Kemampuan = ~Sangat Mampu~', 'Belum'),
(2, 'Kemampuan', 'Mampu', '0', '35', '1', '?', 'Sudah', 'AND Kemampuan = ~Mampu~', 'Belum'),
(3, 'Kemampuan', 'Kurang Mampu', '0', '8', '6', '?', 'Sudah', 'AND Kemampuan = ~Kurang Mampu~', 'Belum'),
(4, 'Kemampuan', 'Tidak Mampu', '0', '0', '10', 'Tidak Puas', 'Belum', 'AND Kemampuan = ~Tidak Mampu~', 'Belum'),
(5, 'Pelayanan', 'Sangat Memuaskan', '2', '0', '0', 'Kosong', 'Belum', 'AND Kemampuan = ~Mampu~ AND Pelayanan = ~Sangat Memuaskan~', 'Sudah'),
(6, 'Pelayanan', 'Memuaskan', '2', '33', '0', 'Puas', 'Belum', 'AND Kemampuan = ~Mampu~ AND Pelayanan = ~Memuaskan~', 'Sudah'),
(7, 'Pelayanan', 'Cukup Memuaskan', '2', '2', '0', 'Puas', 'Belum', 'AND Kemampuan = ~Mampu~ AND Pelayanan = ~Cukup Memuaskan~', 'Sudah'),
(8, 'Pelayanan', 'Tidak Memuaskan', '2', '0', '1', 'Tidak Puas', 'Belum', 'AND Kemampuan = ~Mampu~ AND Pelayanan = ~Tidak Memuaskan~', 'Sudah'),
(9, 'Biaya', 'Ada', '3', '0', '6', 'Tidak Puas', 'Belum', 'AND Kemampuan = ~Kurang Mampu~ AND Biaya = ~Ada~', 'Sudah'),
(10, 'Biaya', 'Tidak Ada', '3', '8', '0', 'Puas', 'Belum', 'AND Kemampuan = ~Kurang Mampu~ AND Biaya = ~Tidak Ada~', 'Sudah');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pelayanan_administrasi`
--

CREATE TABLE `tb_pelayanan_administrasi` (
  `id` int(3) NOT NULL,
  `pelayanan` varchar(20) NOT NULL,
  `biaya` varchar(20) NOT NULL,
  `kemampuan` varchar(20) NOT NULL,
  `sikap` varchar(20) NOT NULL,
  `hasil` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_pelayanan_administrasi`
--

INSERT INTO `tb_pelayanan_administrasi` (`id`, `pelayanan`, `biaya`, `kemampuan`, `sikap`, `hasil`) VALUES
(1, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(2, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Tidak Baik', 'Tidak Puas'),
(3, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(4, 'Cukup Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(5, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(6, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(7, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(8, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(9, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(10, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Tidak Puas'),
(11, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(12, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(13, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(14, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(15, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(16, 'Tidak Memuaskan', 'Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(17, 'Tidak Memuaskan', 'Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(18, 'Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Baik', 'Puas'),
(19, 'Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Baik', 'Puas'),
(20, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(21, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(22, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(23, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(24, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Tidak Puas'),
(25, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(26, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(27, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(28, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(29, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(30, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(31, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(32, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(33, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(34, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(35, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(36, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(37, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(38, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(39, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(40, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(41, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(42, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(43, 'Cukup Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(44, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(45, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(46, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(47, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(48, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Cukup Baik', 'Tidak Puas'),
(49, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Cukup Baik', 'Tidak Puas'),
(50, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(51, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(52, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(53, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(54, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(55, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(56, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(57, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(58, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(59, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(60, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(61, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(62, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(63, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(64, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(65, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(66, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(67, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(68, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(69, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(70, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(71, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(72, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(73, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(74, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(75, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(76, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(77, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(78, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(79, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(80, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(81, 'Sangat Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(82, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(83, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(84, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(85, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(86, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(87, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(88, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(89, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(90, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(91, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(92, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(93, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(94, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(95, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(96, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(97, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(98, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(99, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(100, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pelayanan_hukum`
--

CREATE TABLE `tb_pelayanan_hukum` (
  `id` int(3) NOT NULL,
  `pelayanan` varchar(20) NOT NULL,
  `biaya` varchar(20) NOT NULL,
  `kemampuan` varchar(20) NOT NULL,
  `sikap` varchar(20) NOT NULL,
  `hasil` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_pelayanan_hukum`
--

INSERT INTO `tb_pelayanan_hukum` (`id`, `pelayanan`, `biaya`, `kemampuan`, `sikap`, `hasil`) VALUES
(1, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(2, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(3, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(4, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(5, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(6, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(7, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(8, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(9, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(10, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(11, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(12, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(13, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(14, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(15, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(16, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(17, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(18, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(19, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(20, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(21, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(22, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(23, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(24, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(25, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(26, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(27, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(28, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(29, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(30, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(31, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(32, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(33, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Tidak Baik', 'Tidak Puas'),
(34, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(35, 'Cukup Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(36, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(37, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(38, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(39, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(40, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(41, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(42, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(43, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(44, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(45, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(46, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(47, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(48, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(49, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Tidak Baik', 'Tidak Puas'),
(50, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(51, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(52, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(53, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(54, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(55, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(56, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(57, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(58, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(59, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(60, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(61, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(62, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(63, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(64, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(65, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(66, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(67, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(68, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(69, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(70, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(71, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(72, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(73, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(74, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(75, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(76, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(77, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(78, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(79, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(80, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(81, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(82, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(83, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(84, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(85, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(86, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(87, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(88, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(89, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(90, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(91, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(92, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(93, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(94, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(95, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(96, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(97, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(98, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(99, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(100, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pelayanan_perkara`
--

CREATE TABLE `tb_pelayanan_perkara` (
  `id` int(3) NOT NULL,
  `pelayanan` varchar(20) NOT NULL,
  `biaya` varchar(20) NOT NULL,
  `kemampuan` varchar(20) NOT NULL,
  `sikap` varchar(20) NOT NULL,
  `hasil` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_pelayanan_perkara`
--

INSERT INTO `tb_pelayanan_perkara` (`id`, `pelayanan`, `biaya`, `kemampuan`, `sikap`, `hasil`) VALUES
(1, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(2, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(3, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(4, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(5, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(6, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(7, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(8, 'Cukup Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(9, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(10, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(11, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(12, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(13, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(14, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(15, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(16, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(17, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(18, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(19, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(20, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(21, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(22, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(23, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(24, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(25, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(26, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(27, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(28, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(29, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(30, 'Tidak Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Tidak Puas'),
(31, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(32, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(33, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(34, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(35, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(36, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(37, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(38, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(39, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(40, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(41, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(42, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(43, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(44, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(45, 'Tidak Memuaskan', 'Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(46, 'Tidak Memuaskan', 'Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(47, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(48, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(49, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(50, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(51, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(52, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(53, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(54, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(55, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(56, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(57, 'Cukup Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(58, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(59, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(60, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(61, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(62, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(63, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(64, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(65, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(66, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(67, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(68, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(69, 'Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(70, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(71, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(72, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(73, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(74, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(75, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(76, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(77, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(78, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(79, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(80, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(81, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(82, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(83, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(84, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(85, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(86, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(87, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(88, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(89, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(90, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(91, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(92, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(93, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(94, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(95, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(96, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(97, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(98, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(99, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(100, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pelayanan_teknis`
--

CREATE TABLE `tb_pelayanan_teknis` (
  `id` int(3) NOT NULL,
  `pelayanan` varchar(20) NOT NULL,
  `biaya` varchar(20) NOT NULL,
  `kemampuan` varchar(20) NOT NULL,
  `sikap` varchar(20) NOT NULL,
  `hasil` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_pelayanan_teknis`
--

INSERT INTO `tb_pelayanan_teknis` (`id`, `pelayanan`, `biaya`, `kemampuan`, `sikap`, `hasil`) VALUES
(1, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(2, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(3, 'Sangat Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(4, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(5, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(6, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(7, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(8, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(9, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(10, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(11, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(12, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(13, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(14, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(15, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(16, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(17, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(18, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(19, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(20, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(21, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(22, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(23, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(24, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(25, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(26, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(27, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(28, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(29, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(30, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(31, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(32, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(33, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(34, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(35, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(36, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(37, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(38, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(39, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(40, 'Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Sangat Baik', 'Puas'),
(41, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Baik', 'Puas'),
(42, 'Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Sangat Baik', 'Puas'),
(43, 'Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(44, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(45, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(46, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(47, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(48, 'Tidak Memuaskan', 'Tidak Ada', 'Mampu', 'Tidak Baik', 'Tidak Puas'),
(49, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Baik', 'Tidak Puas'),
(50, 'Tidak Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Tidak Puas'),
(51, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(52, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(53, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(54, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(55, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Cukup Baik', 'Puas'),
(56, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(57, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(58, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(59, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(60, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(61, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(62, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(63, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(64, 'Cukup Memuaskan', 'Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(65, 'Cukup Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Puas'),
(66, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(67, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(68, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(69, 'Memuaskan', 'Tidak Ada', 'Kurang Mampu', 'Cukup Baik', 'Tidak Puas'),
(70, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(71, 'Sangat Memuaskan', 'Tidak Ada', 'Mampu', 'Sangat Baik', 'Puas'),
(72, 'Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(73, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(74, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(75, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(76, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(77, 'Tidak Memuaskan', 'Tidak Ada', 'Tidak Mampu', 'Tidak Baik', 'Tidak Puas'),
(78, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(79, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(80, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(81, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(82, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(83, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(84, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(85, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(86, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(87, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(88, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(89, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(90, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(91, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(92, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(93, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(94, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(95, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(96, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(97, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(98, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas'),
(99, 'Memuaskan', 'Tidak Ada', 'Mampu', 'Baik', 'Puas'),
(100, 'Sangat Memuaskan', 'Tidak Ada', 'Sangat Mampu', 'Sangat Baik', 'Puas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_users`
--

CREATE TABLE `tb_users` (
  `id` int(10) NOT NULL,
  `nama` varchar(120) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_users`
--

INSERT INTO `tb_users` (`id`, `nama`, `username`, `password`) VALUES
(1, 'Admin ptsp', 'admin', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `iterasi_c45`
--
ALTER TABLE `iterasi_c45`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mining_c45`
--
ALTER TABLE `mining_c45`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pohon_keputusan_c45`
--
ALTER TABLE `pohon_keputusan_c45`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_pelayanan_administrasi`
--
ALTER TABLE `tb_pelayanan_administrasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_pelayanan_hukum`
--
ALTER TABLE `tb_pelayanan_hukum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_pelayanan_perkara`
--
ALTER TABLE `tb_pelayanan_perkara`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_pelayanan_teknis`
--
ALTER TABLE `tb_pelayanan_teknis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `iterasi_c45`
--
ALTER TABLE `iterasi_c45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `mining_c45`
--
ALTER TABLE `mining_c45`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `pohon_keputusan_c45`
--
ALTER TABLE `pohon_keputusan_c45`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
