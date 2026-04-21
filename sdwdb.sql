-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 20, 2026 at 04:34 AM
-- Server version: 8.4.5
-- PHP Version: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sdwdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `division`
--

CREATE TABLE `division` (
  `id` bigint UNSIGNED NOT NULL,
  `division_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkin_time` time NOT NULL,
  `checkout_time` time NOT NULL,
  `tolerance` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `division`
--

INSERT INTO `division` (`id`, `division_name`, `checkin_time`, `checkout_time`, `tolerance`, `created_at`, `updated_at`) VALUES
(1, 'Mobile Production', '09:00:00', '17:00:00', 30, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(2, 'WEB Devolopment', '08:00:00', '16:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(3, 'Mobile Devolopment', '08:00:00', '16:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(4, 'Network', '08:00:00', '16:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(5, 'Security Shift-1', '07:00:00', '16:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(6, 'Security Shift-2', '16:00:00', '23:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(7, 'Security Shift-3', '23:00:00', '07:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(8, 'Kebersihan', '07:00:00', '18:00:00', 45, '2026-03-11 22:09:54', '2026-03-11 22:09:54');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` bigint UNSIGNED NOT NULL,
  `company_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `division_id` bigint UNSIGNED NOT NULL,
  `phone_number` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `face_data` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logged_in` tinyint(1) NOT NULL DEFAULT '0',
  `logged_out` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `company_id`, `user_id`, `name`, `division_id`, `phone_number`, `face_data`, `profile_pic`, `logged_in`, `logged_out`, `created_at`, `updated_at`) VALUES
(1, 'KSS1001', 1, 'David', 1, '089635412765', '265868 - 6969696 - 6537', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(2, 'KKS4002', 37, 'Prof. Kathlyn Cole', 1, '089013690874', '555310', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(3, 'KKS49646', 51, 'Alison Feest', 3, '088060252433', '991', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(4, 'KKS34072', 35, 'Ronny Sanford', 4, '081832943098', '31714027', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(5, 'KKS54441', 17, 'Betsy Torp', 2, '088436650051', '67', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(6, 'KKS28523', 22, 'Aliya Bosco', 3, '088576524193', '44', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(7, 'KKS68127', 50, 'Danyka Swaniawski I', 5, '083792330505', '901834225', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(8, 'KKS18138', 40, 'Nathen Hamill', 3, '082456586512', '84482843', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(9, 'KKS85147', 20, 'Dr. Pearline O\'Kon', 5, '083384864446', '2109', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(10, 'KKS44638', 29, 'Dr. Lila Bogan Sr.', 6, '087464673986', '6078955', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(11, 'KKS29805', 47, 'Reyna Howell', 4, '085955514576', '6727', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(12, 'KKS46240', 30, 'Prof. Madisen Stark MD', 3, '089957178987', '53484641', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(13, 'KKS53259', 26, 'Malika Grant', 2, '089472345950', '413', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(14, 'KKS72922', 32, 'Mrs. Julia Pouros Jr.', 3, '087468942219', '586783', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(15, 'KKS75325', 11, 'Prof. Keshawn Ryan', 2, '088557484225', '79221', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(16, 'KKS11048', 9, 'Nathaniel Emard DVM', 6, '085473476816', '94876619', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(17, 'KKS26315', 25, 'Mrs. Marilyne Lubowitz IV', 5, '089416861136', '14910598', NULL, 0, 0, '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(18, 'KKS34912', 23, 'Mrs. Tina Durgan Sr.', 6, '085229746003', '32', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(19, 'KKS81633', 42, 'Prof. Will McKenzie', 1, '081870153335', '8703364', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(20, 'KKS17445', 6, 'Darren Fahey', 5, '083960033067', '26256001', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(21, 'KKS98504', 21, 'Ms. Maia Anderson PhD', 2, '086071878891', '795', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(22, 'KKS44587', 12, 'Oma Heidenreich', 5, '082534010294', '185474', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(23, 'KKS41546', 43, 'Kaleigh Hudson IV', 5, '088443338644', '6578805', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(24, 'KKS62675', 31, 'Selina Roberts', 3, '085828301387', '3560996', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(25, 'KKS75995', 45, 'Mozelle Brown', 5, '086112796824', '77', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(26, 'KKS81457', 4, 'Nicholaus Raynor', 7, '088363514812', '992', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(27, 'KKS60907', 36, 'Dr. Ilene Jacobs', 4, '082304412765', '185', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(28, 'KKS83865', 28, 'Vesta Koss II', 1, '085416655378', '359139792', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(29, 'KKS2703', 18, 'Ettie Gleason', 4, '083267912603', '2895231', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(30, 'KKS90413', 44, 'Demetrius Turcotte MD', 6, '083998667117', '9574915', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(31, 'KKS14383', 10, 'Isai Reinger', 1, '086929055270', '2308678', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(32, 'KKS81889', 48, 'Sydnie Towne MD', 4, '081846134427', '7', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(33, 'KKS74153', 52, 'Marco Nienow MD', 6, '081931922031', '4097104', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(34, 'KKS57742', 14, 'Sydni Breitenberg', 1, '087588030007', '19071', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(35, 'KKS78422', 27, 'Mrs. Delia Schoen PhD', 2, '088883811538', '32309503', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(36, 'KKS49906', 24, 'Winnifred Bergnaum', 4, '088735956836', '5367905', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(37, 'KKS28063', 39, 'Mr. Warren Gusikowski', 6, '089860147205', '1599', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(38, 'KKS19327', 34, 'Miss Raphaelle Runolfsdottir IV', 7, '089305575025', '71', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(39, 'KKS55304', 5, 'Dr. Ariel Farrell Sr.', 7, '087922009273', '109726700', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(40, 'KKS46011', 16, 'Alva Shields', 5, '087564161348', '969', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(41, 'KKS46330', 33, 'Dr. Joaquin Schroeder PhD', 7, '089870801158', '0', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(42, 'KKS91740', 15, 'Erwin Stanton', 3, '085781617905', '34805603', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(43, 'KKS74056', 8, 'Clotilde Corwin', 3, '087328361155', '43', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(44, 'KKS86304', 38, 'Olga Wunsch', 1, '089168492309', '390300', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(45, 'KKS97384', 3, 'Graciela Schowalter V', 1, '081428190414', '32', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(46, 'KKS44992', 19, 'Ms. Else Wuckert Sr.', 5, '085808725884', '329404917', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(47, 'KKS37902', 49, 'Mario Okuneva', 5, '087180277093', '1016349', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(48, 'KKS87681', 13, 'Marvin Dietrich III', 7, '089680108522', '273453601', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(49, 'KKS14603', 7, 'Prof. Kian O\'Connell DVM', 5, '083566215436', '6449539', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(50, 'KKS37849', 41, 'Randy Luettgen Sr.', 6, '089639201435', '237', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(51, 'KKS32036', 46, 'Elsa Bernier', 5, '081493957929', '22', NULL, 0, 0, '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(52, 'KKS01052', 53, 'Bambang Sutejo', 1, '089123456782', 'Arrive at seven, the place feels good\nNo time to call you today\nEncores \'til eleven, then Chinese food\nBack to the hotel again', '1aXhL3bGmQQxAIu1QB9HTZoociKLaQC0XV2ohcY2.png', 1, 1, '2026-03-11 22:44:37', '2026-04-19 21:31:18');

-- --------------------------------------------------------

--
-- Table structure for table `employee_log_in`
--

CREATE TABLE `employee_log_in` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `login_time` time NOT NULL,
  `status` enum('on_time','late') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_log_in`
--

INSERT INTO `employee_log_in` (`id`, `employee_id`, `login_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 5, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(2, 26, '07:15:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(3, 43, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(4, 28, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(5, 34, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(6, 6, '09:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(7, 42, '07:15:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(8, 12, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(9, 35, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(10, 25, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(11, 47, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(12, 19, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(13, 8, '09:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(14, 13, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(15, 36, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(16, 20, '07:15:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(17, 40, '07:15:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(18, 2, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(19, 39, '09:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(20, 16, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(21, 44, '07:45:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(22, 49, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(23, 9, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(24, 41, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(25, 32, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(26, 37, '07:45:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(27, 29, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(28, 22, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(29, 31, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(30, 11, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(31, 27, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(32, 1, '07:45:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(33, 7, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(34, 21, '07:45:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(35, 46, '07:15:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(36, 24, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(37, 17, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(38, 4, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(39, 10, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(40, 14, '09:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(41, 48, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(42, 30, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(43, 15, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(44, 23, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(45, 3, '08:00:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(46, 45, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(47, 38, '07:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(48, 33, '07:45:00', 'late', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(49, 18, '08:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(50, 50, '07:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(51, 52, '09:12:48', 'on_time', '2026-04-13 22:00:33', '2026-04-13 22:00:33'),
(52, 52, '09:14:48', 'on_time', '2026-04-17 21:50:16', '2026-04-17 21:50:16');

-- --------------------------------------------------------

--
-- Table structure for table `employee_log_out`
--

CREATE TABLE `employee_log_out` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `logout_time` time NOT NULL,
  `status` enum('on_time','early') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_log_out`
--

INSERT INTO `employee_log_out` (`id`, `employee_id`, `logout_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 28, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(2, 40, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(3, 3, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(4, 2, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(5, 46, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(6, 35, '15:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(7, 36, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(8, 4, '18:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(9, 29, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(10, 19, '15:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(11, 11, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(12, 27, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(13, 13, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(14, 25, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(15, 21, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(16, 5, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(17, 8, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(18, 32, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(19, 47, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(20, 7, '18:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(21, 42, '18:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(22, 22, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(23, 16, '16:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(24, 6, '17:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(25, 12, '17:15:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(26, 33, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(27, 9, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(28, 44, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(29, 48, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(30, 20, '15:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(31, 1, '15:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(32, 10, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(33, 49, '16:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(34, 39, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(35, 41, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(36, 34, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(37, 24, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(38, 23, '16:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(39, 15, '18:45:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(40, 14, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(41, 37, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(42, 30, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(43, 31, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(44, 50, '17:15:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(45, 26, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(46, 43, '16:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(47, 18, '18:45:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(48, 38, '15:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(49, 17, '15:00:00', 'on_time', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(50, 45, '16:00:00', 'early', '2026-03-11 22:09:55', '2026-03-11 22:09:55'),
(51, 52, '17:11:22', 'on_time', '2026-04-13 22:00:45', '2026-04-13 22:00:45'),
(52, 52, '17:04:22', 'on_time', '2026-04-17 21:50:41', '2026-04-17 21:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_03_042443_create_personal_access_tokens_table', 1),
(5, '2026_03_03_044232_create_division_table', 1),
(6, '2026_03_03_045203_create_employee_table', 1),
(7, '2026_03_03_045609_create_point_table', 1),
(8, '2026_03_03_045930_create_employee_log_in_table', 1),
(9, '2026_03_03_051531_create_employee_log_out_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 53, 'token', 'e3c592165d1f82d6ba6826da995a54f100df2b3fb0a7e47205f1bbeb35bc43a3', '[\"*\"]', '2026-04-19 21:32:15', NULL, '2026-03-11 22:43:42', '2026-04-19 21:32:15'),
(2, 'App\\Models\\User', 53, 'token', 'f4e375ab9c3c6ecb2e95e05f224343e6faf7399ecbc75b2790fb1a78c9478b39', '[\"*\"]', '2026-03-13 01:10:26', NULL, '2026-03-13 00:58:21', '2026-03-13 01:10:26'),
(3, 'App\\Models\\User', 53, 'token', '07832edf0fccddb7d7d7c007b498c03c0b6eb749c8220bc671f1ab44e3f2f476', '[\"*\"]', '2026-04-17 23:22:27', NULL, '2026-03-13 20:27:26', '2026-04-17 23:22:27'),
(4, 'App\\Models\\User', 53, 'token', 'a08cb4b3c88cc07a8ddb6eb7e608db1860b1c41980a2e4b31989de1c5cf00374', '[\"*\"]', NULL, NULL, '2026-04-12 19:33:12', '2026-04-12 19:33:12'),
(5, 'App\\Models\\User', 53, 'token', 'bd268740c28c18460281bf71ef27eae61a489b8a9cfaad9e378b72dd1816ec0a', '[\"*\"]', NULL, NULL, '2026-04-12 23:03:44', '2026-04-12 23:03:44'),
(6, 'App\\Models\\User', 53, 'token', 'be2a384e604bea63c7578d57579a314f1309536b3a4267898d5853fed0b9e08a', '[\"*\"]', NULL, NULL, '2026-04-13 02:10:15', '2026-04-13 02:10:15'),
(7, 'App\\Models\\User', 53, 'token', '7829241c5523e32e1dfb9aa7012cd31f171ca3709a9e1d1c1a6132194e5b7aaa', '[\"*\"]', NULL, NULL, '2026-04-13 02:12:52', '2026-04-13 02:12:52'),
(8, 'App\\Models\\User', 53, 'token', 'a7585c24e87f3706e815a58736fce543f38afdf40275cb57fe3df7fd6bef8812', '[\"*\"]', NULL, NULL, '2026-04-13 02:14:05', '2026-04-13 02:14:05'),
(9, 'App\\Models\\User', 53, 'token', 'f15ab33c9259d95c32b06affe14e89c582b7f635b90cc6dcf3905aeb67376d5b', '[\"*\"]', NULL, NULL, '2026-04-13 02:15:04', '2026-04-13 02:15:04'),
(10, 'App\\Models\\User', 53, 'token', '1d486d737385043a7723486dbc8056e7f7100cea2cd63934c2c4baf90e2ee604', '[\"*\"]', '2026-04-17 21:50:41', NULL, '2026-04-13 22:00:14', '2026-04-17 21:50:41'),
(11, 'App\\Models\\User', 53, 'token', '54c56643180399ece7cab0ccb09e6ab07c500bc73b9fbbad8fc383428d2cfda2', '[\"*\"]', NULL, NULL, '2026-04-14 01:22:37', '2026-04-14 01:22:37'),
(12, 'App\\Models\\User', 53, 'token', '9143b5e72085f8aa5d0534be314de8d3530edcc9275cdd56935073e1c63526a9', '[\"*\"]', NULL, NULL, '2026-04-14 01:22:46', '2026-04-14 01:22:46'),
(13, 'App\\Models\\User', 53, 'token', 'f4109c36925b0547e69f61ade33f220ea4d9fe98f77322f7693e3682b6a08282', '[\"*\"]', NULL, NULL, '2026-04-14 01:25:11', '2026-04-14 01:25:11'),
(14, 'App\\Models\\User', 53, 'token', '4ff78c63d8843254e09bc1bd692d98898ff88c4760093c3509a0d8d48a230357', '[\"*\"]', NULL, NULL, '2026-04-14 01:25:13', '2026-04-14 01:25:13'),
(15, 'App\\Models\\User', 53, 'token', '9bd8eae487555161c01d8e5c0b1281a111e83aec1dddb0ace35b40a69f0a6fa4', '[\"*\"]', NULL, NULL, '2026-04-14 01:26:31', '2026-04-14 01:26:31'),
(16, 'App\\Models\\User', 53, 'token', '7f785d077f62fa8eff8e6e725e62e27813451b0ca87e1ba22c05c764fa793457', '[\"*\"]', NULL, NULL, '2026-04-14 01:29:13', '2026-04-14 01:29:13'),
(17, 'App\\Models\\User', 53, 'token', '92cba0e782a1bfe7575d830a31d54408b7d544f48549ba9d09da4ff9108cf6e9', '[\"*\"]', NULL, NULL, '2026-04-14 01:29:19', '2026-04-14 01:29:19'),
(18, 'App\\Models\\User', 53, 'token', '22d9f96431b252c389fd2eb0ddadd2645d660112b26d344acb8093a7b29e0c7d', '[\"*\"]', NULL, NULL, '2026-04-14 01:30:07', '2026-04-14 01:30:07'),
(19, 'App\\Models\\User', 53, 'token', '3b3b299d0fcf4406d2320727e77f224027ae923a7359258f2c04cdf27fdbdcf2', '[\"*\"]', NULL, NULL, '2026-04-14 01:31:31', '2026-04-14 01:31:31'),
(20, 'App\\Models\\User', 53, 'token', 'f873ee9bc19e2e5ad0023cca3c2ff5fbc708d0425897402e23f72f3fd5425482', '[\"*\"]', NULL, NULL, '2026-04-15 00:40:50', '2026-04-15 00:40:50'),
(21, 'App\\Models\\User', 53, 'token', 'ba87139e388b74bc4a3993488f7dbba709943f490a2fccf161e84fca1be03b12', '[\"*\"]', NULL, NULL, '2026-04-15 00:41:29', '2026-04-15 00:41:29'),
(22, 'App\\Models\\User', 53, 'token', 'bb040a901228a9c7413ef524e209abad0316f487aa779bded3f756cd4e6a1b0e', '[\"*\"]', NULL, NULL, '2026-04-15 00:42:05', '2026-04-15 00:42:05'),
(23, 'App\\Models\\User', 53, 'token', '96faef6bf1b34d62b1d910bc6cd6ca4c17bce7760dfc8fc7c7c326d3aa8a30bc', '[\"*\"]', NULL, NULL, '2026-04-15 00:44:07', '2026-04-15 00:44:07'),
(24, 'App\\Models\\User', 53, 'token', '41cf58cca39911a362c7f9170eada3a6a402f4c8b26840087120ff1dc65bd531', '[\"*\"]', NULL, NULL, '2026-04-15 00:44:52', '2026-04-15 00:44:52'),
(25, 'App\\Models\\User', 53, 'token', 'd754afd20332a33e349c4c5dabd29c0bce1064dae5d8f4cbbe24a1c61c1d58de', '[\"*\"]', '2026-04-15 00:58:49', NULL, '2026-04-15 00:54:34', '2026-04-15 00:58:49'),
(26, 'App\\Models\\User', 53, 'token', '5357935008848c2e5bcc68a1e84e3ab0a7d58f936c8a6030520d3f9562327a5c', '[\"*\"]', '2026-04-15 00:59:52', NULL, '2026-04-15 00:58:48', '2026-04-15 00:59:52'),
(27, 'App\\Models\\User', 53, 'token', 'd03c658611d542976f81b6b42a3f4be775e624f1683c1dd49b2f5588d2c0ca94', '[\"*\"]', '2026-04-15 01:00:34', NULL, '2026-04-15 00:59:51', '2026-04-15 01:00:34'),
(28, 'App\\Models\\User', 53, 'token', '493c37f9cb28ac1ca4df12eda7316fac5101f0f6c678b00c7c646c3661523be0', '[\"*\"]', '2026-04-15 01:16:22', NULL, '2026-04-15 01:00:33', '2026-04-15 01:16:22'),
(29, 'App\\Models\\User', 53, 'token', 'a390ba7927749f9ae23d781a0f769dee1d96edbdeff45f82d62814ecbc3bd072', '[\"*\"]', '2026-04-15 01:17:31', NULL, '2026-04-15 01:01:52', '2026-04-15 01:17:31'),
(30, 'App\\Models\\User', 53, 'token', '112253f134b458bf870f4e6b257ea6237967440d79cc199bc2ced042d3e69383', '[\"*\"]', '2026-04-15 01:18:47', NULL, '2026-04-15 01:17:30', '2026-04-15 01:18:47'),
(31, 'App\\Models\\User', 53, 'token', '4c9ba56eeab30a0fac7e983eb9d21b7d8298f8e1a426343005034ce85610b88f', '[\"*\"]', '2026-04-15 01:21:21', NULL, '2026-04-15 01:18:46', '2026-04-15 01:21:21'),
(32, 'App\\Models\\User', 53, 'token', '8fcb050023bfe697d54900e62049e9b42a7a851b6b58af5f9520635b1c6f3a71', '[\"*\"]', '2026-04-15 01:22:37', NULL, '2026-04-15 01:21:20', '2026-04-15 01:22:37'),
(33, 'App\\Models\\User', 53, 'token', '731d19d17d6605be363aac9e13a608ac5685ace35f742174f670b93897d9ca75', '[\"*\"]', '2026-04-15 01:50:34', NULL, '2026-04-15 01:22:37', '2026-04-15 01:50:34'),
(34, 'App\\Models\\User', 53, 'token', '71976202261093064acea3b952379563b0ae72e995a0e73e0e51206c800013f7', '[\"*\"]', NULL, NULL, '2026-04-15 01:48:15', '2026-04-15 01:48:15'),
(35, 'App\\Models\\User', 53, 'token', 'dd8d83ee00c3d63165f9e953a12415cb6e7e3d5ea33e7b4e69849dbf70808c1e', '[\"*\"]', NULL, NULL, '2026-04-15 01:50:33', '2026-04-15 01:50:33'),
(36, 'App\\Models\\User', 53, 'token', '1723adfee07d579cfa3b812d326a57c34d98e874c1b1f93f75ddda5d4c66ae9c', '[\"*\"]', NULL, NULL, '2026-04-15 01:51:39', '2026-04-15 01:51:39'),
(37, 'App\\Models\\User', 53, 'token', '165880706917aa398b62f07b49be8e5c7c430dc592ebf7b095f2de71ecf59e3c', '[\"*\"]', NULL, NULL, '2026-04-15 01:53:03', '2026-04-15 01:53:03'),
(38, 'App\\Models\\User', 53, 'token', '4c232b728f710a1f99712537dbefcf78c4398550ae659cdcf58694113b6a0095', '[\"*\"]', NULL, NULL, '2026-04-15 02:07:28', '2026-04-15 02:07:28'),
(39, 'App\\Models\\User', 53, 'token', 'd194d03acb3f4a08800e58ae0642587b5e05dae812713c33f2d913aec0148d3e', '[\"*\"]', NULL, NULL, '2026-04-15 21:20:50', '2026-04-15 21:20:50'),
(40, 'App\\Models\\User', 53, 'token', '0ada750335405ff85e130ab4de8341f2860ca592f0cad88fc5bf9548781bea3b', '[\"*\"]', NULL, NULL, '2026-04-15 21:26:19', '2026-04-15 21:26:19'),
(41, 'App\\Models\\User', 53, 'token', '782b91e55d17e968fd19433b7e44cb75765b0414e62414fc89bbd76502df65e6', '[\"*\"]', NULL, NULL, '2026-04-15 21:32:38', '2026-04-15 21:32:38'),
(42, 'App\\Models\\User', 53, 'token', 'a52ae8ebef4f1552a64c3d3644257a0c21159e1a1990eefba422d90ca0fe15f9', '[\"*\"]', NULL, NULL, '2026-04-15 21:34:10', '2026-04-15 21:34:10'),
(43, 'App\\Models\\User', 53, 'token', '90c59af5d51a1a757edfdc85037b1f1cccc87b092513ce432c0af8015b49b068', '[\"*\"]', NULL, NULL, '2026-04-15 21:37:23', '2026-04-15 21:37:23'),
(44, 'App\\Models\\User', 53, 'token', '766f7aba9b4fdb21e3302bd1b7eb234d702f10a19bfdcc1f5ebc9728439b21cf', '[\"*\"]', NULL, NULL, '2026-04-15 21:38:43', '2026-04-15 21:38:43'),
(45, 'App\\Models\\User', 53, 'token', '6835cf85644193a420e817732e42724bccefa70d9ca5b0c00cb7d7952310e532', '[\"*\"]', NULL, NULL, '2026-04-15 21:47:23', '2026-04-15 21:47:23'),
(46, 'App\\Models\\User', 53, 'token', '6820f4d3ebe865e7b4647f2cc5e62fa61ee4960553023f4af81529af7309a2ee', '[\"*\"]', NULL, NULL, '2026-04-15 21:54:50', '2026-04-15 21:54:50'),
(47, 'App\\Models\\User', 53, 'token', 'cbbe52d7ab58871afe5a2532dd8342635ac9912fe04b4b34542603c255722e2c', '[\"*\"]', '2026-04-15 22:25:14', NULL, '2026-04-15 21:55:23', '2026-04-15 22:25:14'),
(48, 'App\\Models\\User', 53, 'token', 'fcdb03c5b5eb12d78ecabd5ef04691c28571c5ac5043c3551e25f8958193c177', '[\"*\"]', '2026-04-15 22:29:00', NULL, '2026-04-15 22:25:14', '2026-04-15 22:29:00'),
(49, 'App\\Models\\User', 53, 'token', 'ba728779234d51b123eadb9041fcb050fd57932426cb3ce51963cc2d0c4a54ad', '[\"*\"]', '2026-04-15 22:38:48', NULL, '2026-04-15 22:29:00', '2026-04-15 22:38:48'),
(50, 'App\\Models\\User', 53, 'token', 'efd89efc3f287f3dd2786087387ba32866038acbe28930f87da0d3aba51ac84a', '[\"*\"]', NULL, NULL, '2026-04-15 22:38:32', '2026-04-15 22:38:32'),
(51, 'App\\Models\\User', 53, 'token', 'b898a5eef293d89b78d152df9c92d5d2298a05509e38b9d2b2686baba14959d8', '[\"*\"]', NULL, NULL, '2026-04-15 22:38:41', '2026-04-15 22:38:41'),
(52, 'App\\Models\\User', 53, 'token', 'd113218c734a5415799a5789688509d1ebc5419a039ac32d55cce7ddf7965ec2', '[\"*\"]', NULL, NULL, '2026-04-15 22:38:42', '2026-04-15 22:38:42'),
(53, 'App\\Models\\User', 53, 'token', 'f2c851e1a3d12ee745ca7f7c0b0a9596030da1c208a8ea2e90b001f1fec789d8', '[\"*\"]', NULL, NULL, '2026-04-15 22:38:42', '2026-04-15 22:38:42'),
(54, 'App\\Models\\User', 53, 'token', '2213975f6afc7e17225f1864c536de4ac5542c812eb267c71885662db8d83f76', '[\"*\"]', NULL, NULL, '2026-04-15 22:38:43', '2026-04-15 22:38:43'),
(55, 'App\\Models\\User', 53, 'token', 'ac76facbf3aec9795e330983d29eebf9a1a9a6ed6d28aed15e01f133a8405899', '[\"*\"]', '2026-04-15 22:40:59', NULL, '2026-04-15 22:38:43', '2026-04-15 22:40:59'),
(56, 'App\\Models\\User', 53, 'token', 'f635882ff97be2d411a5746884e678acec921498fc6ddd6b88da0a820698ea22', '[\"*\"]', NULL, NULL, '2026-04-15 22:40:01', '2026-04-15 22:40:01'),
(57, 'App\\Models\\User', 53, 'token', '03c8d46b7e38cad640f35c5c1f14a79a2db903dc23b788094d9cc3de0fb5a924', '[\"*\"]', '2026-04-15 22:43:39', NULL, '2026-04-15 22:41:30', '2026-04-15 22:43:39'),
(58, 'App\\Models\\User', 53, 'token', '7f32a8994e975710790aaeb9d2c907732c5fa7cd48f20fa4a4d82aa2237ec762', '[\"*\"]', '2026-04-15 22:46:40', NULL, '2026-04-15 22:43:38', '2026-04-15 22:46:40'),
(59, 'App\\Models\\User', 53, 'token', 'd1f87e9631473687098384f04b1ae9eab7f67bc4e2093f27a97e0d5d784e2db0', '[\"*\"]', '2026-04-15 22:48:35', NULL, '2026-04-15 22:46:40', '2026-04-15 22:48:35'),
(60, 'App\\Models\\User', 53, 'token', '0878e5f541071dde1773ab4040dfc25c09859d1c358b98a83b2704855126c338', '[\"*\"]', '2026-04-15 22:49:01', NULL, '2026-04-15 22:48:34', '2026-04-15 22:49:01'),
(61, 'App\\Models\\User', 53, 'token', 'c0400d29799fbafaa531af2f9fa44d982770db2f7593d3c76bc48cb621cf5395', '[\"*\"]', '2026-04-15 22:50:14', NULL, '2026-04-15 22:49:00', '2026-04-15 22:50:14'),
(62, 'App\\Models\\User', 53, 'token', 'dd0518a1edf8dd52a1c92b8ee450e177bbc2461791f05c64d793b7480264ea48', '[\"*\"]', '2026-04-15 22:50:48', NULL, '2026-04-15 22:50:13', '2026-04-15 22:50:48'),
(63, 'App\\Models\\User', 53, 'token', '6f946895aa6152acdbecd85b0525edce782ac0f5a8dd27a4e57299f2387736f4', '[\"*\"]', '2026-04-15 22:51:45', NULL, '2026-04-15 22:50:48', '2026-04-15 22:51:45'),
(64, 'App\\Models\\User', 53, 'token', '548bb81c77364787642711c70d46194c6a7038e0fdcc270e2cb4242927488b83', '[\"*\"]', '2026-04-15 22:58:19', NULL, '2026-04-15 22:51:44', '2026-04-15 22:58:19'),
(65, 'App\\Models\\User', 53, 'token', '34525c66b76b43e0f8e72269f08c9667bc46ecf00bfcafdcc1f513fccb92c92e', '[\"*\"]', '2026-04-15 23:03:52', NULL, '2026-04-15 22:58:18', '2026-04-15 23:03:52'),
(66, 'App\\Models\\User', 53, 'token', 'd369bad1128eff55f967efddf849d585f844942a2e9c026ed5a5d8a3f7308601', '[\"*\"]', '2026-04-16 02:23:20', NULL, '2026-04-15 22:59:43', '2026-04-16 02:23:20'),
(67, 'App\\Models\\User', 53, 'token', '1b186f2a70f5eb7c543eacec85cf5dbca3f8b0e0962c745cded0aaa264475272', '[\"*\"]', '2026-04-16 20:52:54', NULL, '2026-04-15 23:11:11', '2026-04-16 20:52:54'),
(68, 'App\\Models\\User', 53, 'token', '14255b899c55b3e2710ef1ed9c1d9f7fb83cf350eb67b6fcab29b0ab96cdfdfa', '[\"*\"]', '2026-04-16 20:53:15', NULL, '2026-04-16 20:49:50', '2026-04-16 20:53:15'),
(69, 'App\\Models\\User', 53, 'token', '5dab18f7870581aacb72c6f2cfac0d944a57384534114411e4ef2e2ce1ea4f75', '[\"*\"]', '2026-04-16 20:57:59', NULL, '2026-04-16 20:53:15', '2026-04-16 20:57:59'),
(70, 'App\\Models\\User', 53, 'token', '36c04c77d133b5fb79b2eaac8def592217a4d850289b27276cfd0c742c3cf5f0', '[\"*\"]', '2026-04-16 21:30:58', NULL, '2026-04-16 20:57:51', '2026-04-16 21:30:58'),
(71, 'App\\Models\\User', 53, 'token', '04314af06599c4d2bc38e83aa5bc61d5f9937a7b8261876cca94fa4f575efcc6', '[\"*\"]', '2026-04-16 21:31:15', NULL, '2026-04-16 21:23:56', '2026-04-16 21:31:15'),
(72, 'App\\Models\\User', 53, 'token', '1e9d457abc7fe00c1930eb61f0f99f683322bd4b1e5ce0f35a643aeeddae5d98', '[\"*\"]', '2026-04-16 21:31:34', NULL, '2026-04-16 21:31:09', '2026-04-16 21:31:34'),
(73, 'App\\Models\\User', 53, 'token', 'aed7f8eaa41385528fa470445743995a63da4e54837c9edfe538f0c8042c11b1', '[\"*\"]', '2026-04-16 23:44:03', NULL, '2026-04-16 21:31:33', '2026-04-16 23:44:03'),
(74, 'App\\Models\\User', 53, 'token', '0b2bd96bb53dc39e0601f62c553d02d1ccaa5dfff95c256c3f4b7da45ac4a8c1', '[\"*\"]', '2026-04-16 23:53:46', NULL, '2026-04-16 21:31:50', '2026-04-16 23:53:46'),
(75, 'App\\Models\\User', 53, 'token', '55ca164f5dd5a37c35f37a269eb61415771066acc35348b9f13acd28afc7d764', '[\"*\"]', '2026-04-17 00:14:02', NULL, '2026-04-16 23:52:03', '2026-04-17 00:14:02'),
(76, 'App\\Models\\User', 53, 'token', '1e7857eac236fc14da558dc02d571ad1695c68fa3e7c669b57116fb2ebfafc18', '[\"*\"]', '2026-04-17 00:32:24', NULL, '2026-04-17 00:02:14', '2026-04-17 00:32:24'),
(77, 'App\\Models\\User', 53, 'token', '6c87569ef48ea2877711e89bab4796921f03f7f7281cc2f70ddc75f9311f1e54', '[\"*\"]', '2026-04-17 01:20:31', NULL, '2026-04-17 00:14:36', '2026-04-17 01:20:31'),
(78, 'App\\Models\\User', 53, 'token', 'b5f1814881f96b41e8cfce0b25233cd12ff998c57c92ed332fc6b02d914d7506', '[\"*\"]', '2026-04-17 02:15:02', NULL, '2026-04-17 00:34:35', '2026-04-17 02:15:02'),
(79, 'App\\Models\\User', 53, 'token', '5e8e702ab14ff501c26f2df24f0b54741ee474892daaac57e61751a2c2683669', '[\"*\"]', '2026-04-17 20:52:34', NULL, '2026-04-17 01:25:45', '2026-04-17 20:52:34'),
(80, 'App\\Models\\User', 53, 'token', '693c3da411519ba5c28c35001e16b7950f2401a43493aa5328fd67324be5bcf1', '[\"*\"]', '2026-04-17 20:53:18', NULL, '2026-04-17 20:52:33', '2026-04-17 20:53:18'),
(81, 'App\\Models\\User', 53, 'token', '925a8b7b179da1856bf07dae909566290ad26d43fc4d2a5e3242fe5a8af4f4b0', '[\"*\"]', '2026-04-17 21:00:35', NULL, '2026-04-17 20:53:17', '2026-04-17 21:00:35'),
(82, 'App\\Models\\User', 53, 'token', '7cacf5c0c19cbf50e48581cbe444ce5d423cc92af4f8ef37b6856f6ece34d0de', '[\"*\"]', '2026-04-17 21:14:37', NULL, '2026-04-17 20:54:37', '2026-04-17 21:14:37'),
(83, 'App\\Models\\User', 53, 'token', '09f6eafc915793606b0c0faf122045c8764276e6c7bc4ac297255d87f40c45e6', '[\"*\"]', '2026-04-17 21:18:58', NULL, '2026-04-17 21:13:44', '2026-04-17 21:18:58'),
(84, 'App\\Models\\User', 53, 'token', 'b6217e7933f82d9e1d1d7e44039f92520ba6327b64c4b8ca4408d13d1ebfa1e1', '[\"*\"]', '2026-04-17 21:19:13', NULL, '2026-04-17 21:17:20', '2026-04-17 21:19:13'),
(85, 'App\\Models\\User', 53, 'token', 'dfb5afa070ab7c49df241f2c200a8b394676aa94c1192293573db5e9b9fc740d', '[\"*\"]', '2026-04-17 21:51:34', NULL, '2026-04-17 21:19:13', '2026-04-17 21:51:34'),
(86, 'App\\Models\\User', 53, 'token', 'd90185e16ceff82efa6a26a0297c9998ff4d726bda6a5f3feecd73cb9180ed21', '[\"*\"]', '2026-04-17 22:18:39', NULL, '2026-04-17 21:47:27', '2026-04-17 22:18:39'),
(87, 'App\\Models\\User', 53, 'token', '7b7da6dd54f701886cbb1754b8d995296cccfbf8541828773803939dd6a81915', '[\"*\"]', '2026-04-19 21:12:56', NULL, '2026-04-17 22:18:38', '2026-04-19 21:12:56'),
(88, 'App\\Models\\User', 53, 'token', 'bb1bc0c95156607037244b69cfed6b666e6756aece8263e3f8ea301182cb848f', '[\"*\"]', NULL, NULL, '2026-04-19 19:40:58', '2026-04-19 19:40:58'),
(89, 'App\\Models\\User', 53, 'token', '7aaba6a46811a190e185b4646523943830218a403fadc6063fbc47d53b5c3dd6', '[\"*\"]', NULL, NULL, '2026-04-19 19:40:59', '2026-04-19 19:40:59'),
(90, 'App\\Models\\User', 53, 'token', '1a9eed8e6b1736cc1337e9ec7de8d929750680297edaae72cd45bf28ea171a71', '[\"*\"]', NULL, NULL, '2026-04-19 19:40:59', '2026-04-19 19:40:59'),
(91, 'App\\Models\\User', 53, 'token', '8e19bbeb81fe7ca3fbb7727ab0fc035883a3a6f827273133aa2844afda65d4da', '[\"*\"]', NULL, NULL, '2026-04-19 19:40:59', '2026-04-19 19:40:59'),
(92, 'App\\Models\\User', 53, 'token', '5444ac6b9ab829d2e947b6bc6cff3c4e6d601bf43769b5621361c42c40769c78', '[\"*\"]', NULL, NULL, '2026-04-19 19:41:00', '2026-04-19 19:41:00'),
(93, 'App\\Models\\User', 53, 'token', 'b5e2baa80cbb4ca5c15a5e6a536584dc113917b2a0d618a3db93646ac258784b', '[\"*\"]', NULL, NULL, '2026-04-19 19:41:00', '2026-04-19 19:41:00'),
(94, 'App\\Models\\User', 53, 'token', 'f89c058fd7fb64890606eed6517afcf97e8fb5a8c5fb4172a0211ef46075f289', '[\"*\"]', '2026-04-19 19:42:10', NULL, '2026-04-19 19:41:11', '2026-04-19 19:42:10'),
(95, 'App\\Models\\User', 53, 'token', 'ae034816e86d54b3368249908059b62c112adfc94fa72aedffd60349fe813d92', '[\"*\"]', NULL, NULL, '2026-04-19 19:42:09', '2026-04-19 19:42:09'),
(96, 'App\\Models\\User', 53, 'token', '95c962fff0df67b32851ff858e8bb4e430708d2597e1c7101291a4406d1a5ea8', '[\"*\"]', NULL, NULL, '2026-04-19 20:53:19', '2026-04-19 20:53:19'),
(97, 'App\\Models\\User', 53, 'token', '4136ccbb8cf7981b08e193ce2a1a157821ae15ec33c2c2508b490bed94f210e7', '[\"*\"]', NULL, NULL, '2026-04-19 21:12:53', '2026-04-19 21:12:53'),
(98, 'App\\Models\\User', 53, 'token', 'f88f2de650329e881ba3f193ad0c8df74a70fe8acf30c74f7d9664f16683966e', '[\"*\"]', NULL, NULL, '2026-04-19 21:12:53', '2026-04-19 21:12:53'),
(99, 'App\\Models\\User', 53, 'token', 'd0c0b316fd2932aa7420588f041e04a30ba820c76e7c8eae851368c71b76f58d', '[\"*\"]', NULL, NULL, '2026-04-19 21:12:54', '2026-04-19 21:12:54'),
(100, 'App\\Models\\User', 53, 'token', 'd77658b7245d887d18f248a587790de64c264ba8318b2c2e195f258e4de1b4e8', '[\"*\"]', '2026-04-19 21:13:22', NULL, '2026-04-19 21:12:55', '2026-04-19 21:13:22'),
(101, 'App\\Models\\User', 53, 'token', '332ca4f9e82df83d12fdf1a9fef44e822e64c4da8fc34765f5a59b5dc4439a18', '[\"*\"]', NULL, NULL, '2026-04-19 21:13:21', '2026-04-19 21:13:21');

-- --------------------------------------------------------

--
-- Table structure for table `point`
--

CREATE TABLE `point` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `point_value` int NOT NULL DEFAULT '75',
  `positive_streak` int NOT NULL DEFAULT '0',
  `negative_streak` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `point`
--

INSERT INTO `point` (`id`, `employee_id`, `point_value`, `positive_streak`, `negative_streak`, `created_at`, `updated_at`) VALUES
(1, 52, 77, 2, 0, '2026-03-11 22:44:37', '2026-04-17 21:50:16');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','employee') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'employee',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `role`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'employee01', 'employee', 'employee01@gmail.com', '$2y$12$gKln/lk8mXFF2camIe8LmOptBwGxd.zQe0J9aRUuKhRIxfF1b0crq', '2026-03-11 22:09:43', '2026-03-11 22:09:43'),
(2, 'admin01', 'admin', 'admin01@gmail.com', '$2y$12$L0phwGWyKrSsdbnvKa/.k.4oKDZ1LMzLpxASNtEYn0KLqTsjaL8cK', '2026-03-11 22:09:43', '2026-03-11 22:09:43'),
(3, 'mallory31', 'employee', 'jaren.paucek@erdman.com', '$2y$12$8OlmIF3kHc7JGtwnv7/ACeuI82c28dxu.ZnKpuLM0gW.HNs.AMo42', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(4, 'bnienow', 'employee', 'barrows.jeramie@yahoo.com', '$2y$12$oInke63QHvulb6DpizbeSe5tnj0n4LbWWkxm8U7pOGPzpK6a6/tWK', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(5, 'antwon.mann', 'employee', 'gkirlin@schmitt.biz', '$2y$12$vuScEEgI7LqUXKLZfmUPMOFeT6bwZLy12KxKBXuT98r95fF8zw6KS', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(6, 'runolfsdottir.mathew', 'employee', 'brianne03@corkery.info', '$2y$12$CLyLF19elO/6d3RBMkPOfeFo4gd8HxyL0fVMceg4vWW/CNnqV3gYi', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(7, 'goldner.frieda', 'employee', 'clyde04@hotmail.com', '$2y$12$YfjnQTVo5AgBwLavxVB2ue9OADeIwMtu/M4p9.4bOAP/IlX7VtHAa', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(8, 'burnice.maggio', 'employee', 'cwisoky@schultz.com', '$2y$12$iP9q4pxLmTc87WitDhWgM.mCySkHq54GRJRqpcro6mVacsh1h/SQq', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(9, 'qryan', 'employee', 'ddurgan@schoen.com', '$2y$12$kl.MQnV8OYgrKECSHEl1zem0kw7ZsdQAE2s5IKmLjgPtWKUIZ/92S', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(10, 'witting.antwan', 'employee', 'gharris@stokes.com', '$2y$12$dlN2NSj1OC942vUcdkk/huyFeS5S9n9dFFN9Vn/0yo8u7j2YmEH/K', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(11, 'annamarie.langworth', 'employee', 'zakary.jenkins@yahoo.com', '$2y$12$SbbWDB0DcdknRuH947Bp3.nhLHUb8Rcrf9/zvnAs8iOdMYS8rPGvO', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(12, 'tony80', 'employee', 'constance.cummings@rath.com', '$2y$12$LJ.Pxv6K9yPS7ybY/b3dXuSGGcTSVAhYh6Z5fMKFlfCRs9ybOgkXi', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(13, 'kendrick91', 'employee', 'vivian51@schumm.biz', '$2y$12$2U8DYzcrQ5AafV8c/hOk6.3HvfFwRwFVmWaoDgWmwctGwCrobpBUC', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(14, 'kebert', 'employee', 'ngreen@reynolds.com', '$2y$12$xWx5SSGMJ5dVlpMd0d.mhOfQclPZLVNXfd0t5qGzUuxa0ByXySc8m', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(15, 'apollich', 'employee', 'waters.calista@gorczany.net', '$2y$12$vUIqMBHLGyJmH21Ag4ARa..iE8JqfuaYCQEqLR2ewWxmQMOioA5Ju', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(16, 'elian78', 'employee', 'dare.francesca@hackett.org', '$2y$12$vMqeLZxpm5YQZ3LFFytE1ON49dmbb.z7q18p9pJqdVHGlIlCUcSRG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(17, 'mgislason', 'employee', 'denesik.carissa@yahoo.com', '$2y$12$xxZnGKXtzP5VoD6WeTz2huFj0SnrswZ5lWVh21j3896fd1Nguj22m', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(18, 'leone14', 'employee', 'jstanton@gutkowski.net', '$2y$12$Xqbvaw/jxbAvNnFjz8FX8OAFJB8mJxKvHJwTmVdEkGDN26KnwxJLq', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(19, 'jerde.jamison', 'employee', 'moore.laila@yahoo.com', '$2y$12$ng3NL8D6ftU1EB7qlP4Yq.0ZS.NSMKjsMpIdnlWCv2NOaPOPsw7Ga', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(20, 'rahul28', 'employee', 'dcrist@moen.net', '$2y$12$QuFYTIJ.yapiHeQSVsf/T.A2fSQpLYb7OSbvjwgDiWOoYiskW8QXS', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(21, 'myron.weber', 'employee', 'marjory.hoeger@gmail.com', '$2y$12$4rM6i1Ud10Lx5A4jDjFlOO2EnsQ8cxGt/M5/PozjhiBUfKAURN1ZS', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(22, 'beer.domenick', 'employee', 'tate.rosenbaum@yahoo.com', '$2y$12$81p4qvsDuluSwHYCOttnlOPxB.hli.K4kTSMYidVhnFjSWo2xAmCO', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(23, 'adrien.monahan', 'employee', 'zmetz@pfeffer.net', '$2y$12$uzUQiBeV1ZASvIVNncycQOM4Ee0qakKDbZUobKkTj3EX5Jks4vXqG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(24, 'ltorp', 'employee', 'icummerata@kunde.com', '$2y$12$QUlupzAFC.M7yzeRna/zK.VDdhZIA4V/TZB6NA08AyYobXcWLRJci', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(25, 'iwiza', 'employee', 'pfannerstill.maia@gmail.com', '$2y$12$RD2ubslwsy31kQKvhn1aK.ASbotVO1iPq008xo4tnm/MTVx5Afpy.', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(26, 'hhomenick', 'employee', 'witting.zackery@hotmail.com', '$2y$12$P2MVq7VbosFYw8kXjHhTc.ZJNRJkh34p7k5hRyhcu54tYyXoMbS42', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(27, 'effertz.kristian', 'employee', 'shea.green@gulgowski.net', '$2y$12$zLPZehPXhVyFF0B7oX1lVeYi.gmQ50j7pcy1GhtwhVltjnm..5IzG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(28, 'darion15', 'employee', 'gusikowski.genesis@schultz.org', '$2y$12$SLVBoff1aIP92ftkXzvehemW.YTaJ3Nu7slrkCMudb6u5GakHMXRG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(29, 'dvolkman', 'employee', 'vveum@gmail.com', '$2y$12$BF/sLdejUTaaYvNyi4Yb4OeHLjpAcfPhmZ88Jgw00NMi26BnhglY2', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(30, 'jennings.spinka', 'employee', 'kuhlman.amalia@cummings.biz', '$2y$12$4aZ81TnekyFjk9/36wwwO.vobZ3Ry3VmmyHJZbLgp7yKHyg7qfY5e', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(31, 'virgil26', 'employee', 'qadams@rodriguez.com', '$2y$12$7bXqew65impoBdI/tYrEQu4QYok8rRC7nhIAunr/B8LiN5JriI3Ti', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(32, 'greta.will', 'employee', 'tbrakus@balistreri.info', '$2y$12$I0xS0cMJ8xefMAY/v8JM4ez7i41QyChHfHLzBSwIAi4w4gFSYT1Kq', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(33, 'ycasper', 'employee', 'pweber@yahoo.com', '$2y$12$2TmUMPSWxzbER24V1JiYU.baMuKRCGkTgCj6/VV1JcNg7BBXwViJy', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(34, 'nschmeler', 'employee', 'cummerata.jada@hotmail.com', '$2y$12$os8LzWPN2rHr5aAOtqjL/uscF.brkzWW.xj4mxC.0VnyXoW0BaM4q', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(35, 'taryn02', 'employee', 'daphne.schimmel@hotmail.com', '$2y$12$T5nja9h7.dvZLiIW/9MGSOLz5SgimiRpLDH8RoznHX1IVfHnGELkW', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(36, 'leo.berge', 'employee', 'itromp@yahoo.com', '$2y$12$WrngniF7hJp.I4PhBoXtIOPZ9V0L3k/Mv1q6kYZkQuObA37hz1xcW', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(37, 'julian92', 'employee', 'franecki.lizzie@simonis.com', '$2y$12$1Z8GMMSEUzRQISak6YLHheBaQJuKkR4NTouot07Z7SzNHpRR.ePT2', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(38, 'rodrick.sauer', 'employee', 'rebeka.schultz@gmail.com', '$2y$12$P9OuYLSJwPdcpOHzit1RjeZto/dGWQ61Aa0498y5bt6h53vQ0I8Py', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(39, 'jenifer.hoppe', 'employee', 'kling.grady@gmail.com', '$2y$12$f/0rIRBAm0gQMGxu8OhPye5jCI5mAscxYcui4ZW3bPKca0nisVi/K', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(40, 'aratke', 'employee', 'hallie.west@runolfsson.biz', '$2y$12$s2zAe9i3WHnGc3/pcEzJ7.HTnSo8OgFvGoAZncSSrsFoNsXQPClpy', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(41, 'susan75', 'employee', 'rosella97@hotmail.com', '$2y$12$ONFSBNVWuxvsxTu3nLDmDeAnjM0TQC2Ax/IIrPkVZ.sHX7pFOBK..', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(42, 'jschiller', 'employee', 'oran.russel@barrows.net', '$2y$12$xkO09O5NHQ68vIQ/ux30Fe0tE97p5uhOIfMy2vq4sd.aMevcLJSGS', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(43, 'margaret02', 'employee', 'vince.krajcik@bogisich.com', '$2y$12$4nMguDPbfVBCzbMOhz4sHuZdR9gOHHVjRE3Nzwlw4JByLgREJuksG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(44, 'lubowitz.mariam', 'employee', 'nannie.schmitt@grimes.com', '$2y$12$wN/cSF5WQhMviz8RfJU19eHiIVqhAbUplBEw2YSsXohY/HuxZPvIm', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(45, 'aleen90', 'employee', 'lucy.schiller@gmail.com', '$2y$12$VHnswJuUwUP9H1k6u.gY3e7fvLd/Mg1RNpWMTEUQLEPfKIhLpiBRG', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(46, 'jillian.metz', 'employee', 'hackett.dino@hotmail.com', '$2y$12$NhNVH1sSxi.ZRDHtur1l7ueg8dzglBIKIaWHzs3jBUIGuAdoU/nRS', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(47, 'droob', 'employee', 'lourdes.swaniawski@klein.com', '$2y$12$s.E.4hFhIMHzgk9x2ke/I.zoOeSeSUSkwbo4pZWg7ALj7XhofQA9G', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(48, 'loyal.flatley', 'employee', 'davion.erdman@lowe.com', '$2y$12$TW8N.Sr.ENzZF58Nvato5ealY/CBixS0iFHZdVObMgojcXg8Hhuba', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(49, 'aiyana.stehr', 'employee', 'reilly.kenyatta@kirlin.info', '$2y$12$l31ih9LN1PGxSxYab2soVeLADyV0qV2SMZakFBoil17pl.zoH3AN2', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(50, 'dibbert.griffin', 'employee', 'raphael31@yahoo.com', '$2y$12$iX5fyDnO3sLtJNPUKjXxCuM7dD38Ledl8juiwEo.NxQtzpjEXwJhO', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(51, 'cmonahan', 'employee', 'brown.ericka@daniel.biz', '$2y$12$QXKeA1xCBAS.K9yZzEvtmuBZKGTTTEYR5P5zle9UPDJngUgo1PFUa', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(52, 'america60', 'employee', 'russel.armand@funk.com', '$2y$12$ssXUB.L8SNdIyQ3Um6.N2u2UGRpXTk9MEz43rk3aJf6k1ZjK/OmMO', '2026-03-11 22:09:54', '2026-03-11 22:09:54'),
(53, 'BambangSutejo', 'employee', 'bambangsutejo2@gmail.com', '$2y$12$3Xvey3Q9Cai6YkAOJOz3nuhrnyFiSUBCcd/KfiNy1H.0IM1eE0IxS', '2026-03-11 22:43:34', '2026-04-19 21:31:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `division`
--
ALTER TABLE `division`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_company_id_unique` (`company_id`),
  ADD UNIQUE KEY `employee_phone_number_unique` (`phone_number`),
  ADD KEY `employee_user_id_foreign` (`user_id`),
  ADD KEY `employee_division_id_foreign` (`division_id`);

--
-- Indexes for table `employee_log_in`
--
ALTER TABLE `employee_log_in`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_log_in_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_log_out`
--
ALTER TABLE `employee_log_out`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_log_out_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `point`
--
ALTER TABLE `point`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `division`
--
ALTER TABLE `division`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `employee_log_in`
--
ALTER TABLE `employee_log_in`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `employee_log_out`
--
ALTER TABLE `employee_log_out`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `point`
--
ALTER TABLE `point`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_log_in`
--
ALTER TABLE `employee_log_in`
  ADD CONSTRAINT `employee_log_in_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_log_out`
--
ALTER TABLE `employee_log_out`
  ADD CONSTRAINT `employee_log_out_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
