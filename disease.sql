-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2024 at 07:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `disease`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Id` int(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Id`, `username`, `password`) VALUES
(1, 'np', 111);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(100) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `confidence_score` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `image_path`, `class_name`, `confidence_score`, `created_at`) VALUES
(159, 'uploads/image', 'Abnormal', 0.255982, '2024-10-12 15:51:40'),
(160, 'uploads/image', 'Normal', 0.362265, '2024-10-12 15:52:56'),
(161, 'uploads/image', 'Normal', 0.34165, '2024-10-23 01:27:25'),
(162, 'uploads/image', 'Normal', 0.34165, '2024-10-23 01:28:28'),
(163, 'uploads/tmp0de3xahs', 'Abnormal', 0.252921, '2024-10-24 00:13:47'),
(164, 'uploads/tmpqb_4tk6a', 'Abnormal', 0.29016, '2024-10-24 00:16:19'),
(165, 'uploads/image', 'Abnormal', 0.288144, '2024-10-25 00:51:25');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `Id` int(50) NOT NULL,
  `patientName` varchar(50) NOT NULL,
  `patientId` int(50) NOT NULL,
  `age` int(100) NOT NULL,
  `sex` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`Id`, `patientName`, `patientId`, `age`, `sex`) VALUES
(353, 'dolly', 12345, 32, 'Female'),
(354, 'Alice', 908765, 34, 'Male'),
(356, 'bobby', 34567, 78, 'Male'),
(357, 'celvin', 0, 45, 'Male'),
(358, 'p', 0, 0, 'Female'),
(359, 'p', 4, 45, 'Female'),
(360, 'cherry', 12345, 23, 'Female'),
(361, 'sarry', 45678, 56, 'Female'),
(362, 'p', 0, 67, 'Female'),
(363, 'curry', 2345, 56, 'Female'),
(364, 'p', 0, 56, 'Female'),
(365, 'p', 0, 34, 'Female'),
(366, 'p', 0, 45, 'Female'),
(367, 'p', 0, 67, 'Female'),
(368, 'p', 0, 45, 'Female'),
(369, 'p', 0, 56, 'Male'),
(370, 'p', 0, 4, 'Male'),
(371, 'p', 0, 67, 'Female'),
(372, 'p', 0, 78, 'Female'),
(373, 'p', 0, 78, 'Female'),
(374, 'p', 0, 8, 'Female'),
(375, 'p', 0, 45, 'Female'),
(376, 'p', 0, 0, 'Female'),
(377, 'p', 0, 89, 'Female'),
(378, 'p', 0, 5, 'Female'),
(379, 'p', 234, 56, 'Female'),
(380, 'amma', 89076, 67, 'Female'),
(381, 'amma', 1, 67, 'Female'),
(382, 'pooji', 2345, 45, 'Female'),
(383, 'poojitha', 98765, 56, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `id` int(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `confirmPassword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`id`, `username`, `email`, `password`, `confirmPassword`) VALUES
(4, 'p', '1@gmail.com', '$2y$10$dOvXArwxbGREvI6cGd01cuD8ZqkUvY9Mn3.IqODoSy/kqj7UwMiRq', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `Id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=384;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
