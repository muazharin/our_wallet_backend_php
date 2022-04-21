-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2022 at 08:23 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `our_wallet`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `historyId` int(11) NOT NULL,
  `historyWalletId` int(11) NOT NULL,
  `historyUserId` int(11) NOT NULL,
  `historyTransactionId` int(11) NOT NULL,
  `historyDetail` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `history_seen`
--

CREATE TABLE `history_seen` (
  `hsId` int(11) NOT NULL,
  `hsHistoryId` int(11) NOT NULL,
  `hsUserId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `our_wallet`
--

CREATE TABLE `our_wallet` (
  `owId` int(11) NOT NULL,
  `owWalletId` int(11) NOT NULL,
  `owUserId` int(11) NOT NULL,
  `owIsUserActive` tinyint(1) NOT NULL,
  `owIsAdmin` tinyint(1) NOT NULL,
  `owDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `our_wallet`
--

INSERT INTO `our_wallet` (`owId`, `owWalletId`, `owUserId`, `owIsUserActive`, `owIsAdmin`, `owDate`) VALUES
(3, 3, 13, 1, 1, '2022-02-08 12:27:58'),
(7, 3, 14, 0, 0, '2022-02-14 00:09:24');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transactionId` int(11) NOT NULL,
  `transactionUserId` int(11) NOT NULL,
  `transactionWalletId` int(11) NOT NULL,
  `transactionType` enum('Kredit','Debit') NOT NULL,
  `transactionTitle` varchar(100) NOT NULL,
  `transactionDetail` text NOT NULL,
  `transactionPrice` int(11) NOT NULL,
  `transactionDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transactionId`, `transactionUserId`, `transactionWalletId`, `transactionType`, `transactionTitle`, `transactionDetail`, `transactionPrice`, `transactionDate`) VALUES
(68, 13, 3, 'Kredit', 'Top Up Uang Kas', 'Uangnya di simpan di laci', 1000000, '2022-02-13 16:09:13'),
(69, 13, 3, 'Debit', 'Beli Makanan', 'Ayam bakar penyet', 50000, '2022-02-13 16:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `transactions_comment`
--

CREATE TABLE `transactions_comment` (
  `tcId` int(11) NOT NULL,
  `tcTransactionId` int(11) NOT NULL,
  `tcUserId` int(11) NOT NULL,
  `tcComment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transactions_file`
--

CREATE TABLE `transactions_file` (
  `tfId` int(11) NOT NULL,
  `tfTransactionId` int(11) NOT NULL,
  `tfFile` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions_file`
--

INSERT INTO `transactions_file` (`tfId`, `tfTransactionId`, `tfFile`) VALUES
(25, 68, '1644682447.png'),
(26, 68, '1644682447.png'),
(27, 69, '1644682497.png'),
(28, 69, '1644682497.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `userName` varchar(100) NOT NULL,
  `userPassword` varchar(100) NOT NULL,
  `userEmail` varchar(100) NOT NULL,
  `userPhone` varchar(15) NOT NULL,
  `userPhoto` varchar(100) NOT NULL,
  `userGender` enum('Pria','Wanita') NOT NULL,
  `userTglLahir` date NOT NULL,
  `userAddress` text NOT NULL,
  `userCreatedAt` datetime NOT NULL,
  `userUpdatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `userName`, `userPassword`, `userEmail`, `userPhone`, `userPhoto`, `userGender`, `userTglLahir`, `userAddress`, `userCreatedAt`, `userUpdatedAt`) VALUES
(13, 'muazharin', '9ac068c47239458b7bd76052aae7cd86', 'alfanmuazharin@gmail.com', '081234567890', 'https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg', 'Pria', '1996-11-07', 'Jakarta', '2022-02-05 22:16:30', '2022-02-05 22:16:30'),
(14, 'ragil', '9ac068c47239458b7bd76052aae7cd86', 'ragil@gmail.com', '082243309591', '', 'Pria', '1997-11-07', 'Jakarta', '2022-02-06 18:53:02', '2022-02-06 18:53:02');

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

CREATE TABLE `wallet` (
  `walletId` int(11) NOT NULL,
  `walletName` varchar(100) NOT NULL,
  `walletMoney` double NOT NULL,
  `walletColor` varchar(20) NOT NULL,
  `walletCreatedAt` datetime NOT NULL,
  `walletUpdatedAt` datetime NOT NULL,
  `walletIsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wallet`
--

INSERT INTO `wallet` (`walletId`, `walletName`, `walletMoney`, `walletColor`, `walletCreatedAt`, `walletUpdatedAt`, `walletIsActive`) VALUES
(3, 'Kos Anker', 950000, 'blue', '2022-02-08 12:27:58', '2022-02-13 19:07:57', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`historyId`);

--
-- Indexes for table `history_seen`
--
ALTER TABLE `history_seen`
  ADD PRIMARY KEY (`hsId`);

--
-- Indexes for table `our_wallet`
--
ALTER TABLE `our_wallet`
  ADD PRIMARY KEY (`owId`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transactionId`);

--
-- Indexes for table `transactions_comment`
--
ALTER TABLE `transactions_comment`
  ADD PRIMARY KEY (`tcId`);

--
-- Indexes for table `transactions_file`
--
ALTER TABLE `transactions_file`
  ADD PRIMARY KEY (`tfId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);

--
-- Indexes for table `wallet`
--
ALTER TABLE `wallet`
  ADD PRIMARY KEY (`walletId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `historyId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history_seen`
--
ALTER TABLE `history_seen`
  MODIFY `hsId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `our_wallet`
--
ALTER TABLE `our_wallet`
  MODIFY `owId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transactionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `transactions_comment`
--
ALTER TABLE `transactions_comment`
  MODIFY `tcId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions_file`
--
ALTER TABLE `transactions_file`
  MODIFY `tfId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `wallet`
--
ALTER TABLE `wallet`
  MODIFY `walletId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
