-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 14, 2022 at 06:16 PM
-- Server version: 10.6.9-MariaDB-1
-- PHP Version: 8.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `phalconshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `aname` varchar(50) NOT NULL,
  `amail` text NOT NULL,
  `apasswd` text NOT NULL,
  `active` varchar(2) NOT NULL,
  `level` varchar(2) NOT NULL,
  `type` varchar(2) NOT NULL,
  `servicename` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `contact` tinytext NOT NULL,
  `servicelogo` varchar(200) NOT NULL,
  `idcard` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `aname`, `amail`, `apasswd`, `active`, `level`, `type`, `servicename`, `address`, `contact`, `servicelogo`, `idcard`) VALUES
(1, 'webmaster', 'webmaster@localhost', '$1$d0dNcElp$gPXDDrwEEwLM7IN95Tq1n.', '1', '4', 's', 'developer', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE `area` (
  `aid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `areaname` varchar(100) NOT NULL,
  `delivery_charge` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`aid`, `cid`, `areaname`, `delivery_charge`) VALUES
(1, 2, 'Azimpur', '60'),
(2, 2, 'Bangabhaban', '50'),
(3, 2, 'Bangshal', '50'),
(4, 2, 'Basabo', '50'),
(5, 2, 'Chawk Bazar', '50'),
(6, 2, 'Demra', '50'),
(7, 2, 'Dhanmondi Road 1 - 10', '80'),
(8, 2, 'Dhanmondi Road 11 - 16', '80'),
(9, 2, 'Dhanmondi Road 1A - 13A', '80'),
(10, 2, 'Dilkusha', '50'),
(11, 2, 'Elephant Road', '50'),
(12, 2, 'Gendaria', '50'),
(13, 2, 'Gulistan', '50'),
(14, 2, 'Hazaribagh', '50'),
(15, 2, 'Jatrabari', '50'),
(16, 2, 'Kakrail', '50'),
(17, 2, 'Kalabagan', '50'),
(18, 2, 'Kamlapur', '50'),
(19, 2, 'Keraniganj Sadar', '50'),
(20, 2, 'Lalbagh', '50'),
(21, 2, 'Matuail', '50'),
(22, 2, 'Moghbazar', '50'),
(23, 2, 'Motijheel', '50'),
(24, 2, 'Nawabganj', '50'),
(25, 2, 'New Market', '50'),
(26, 2, 'Palamganj', '50'),
(27, 2, 'Pallabi', '50'),
(28, 2, 'Palton', '50'),
(29, 2, 'Ramna', '50'),
(30, 2, 'Rampura', '50'),
(31, 2, 'Shabujbagh', '50'),
(32, 2, 'Sarulia', '50'),
(33, 2, 'Shahbagh', '50'),
(34, 2, 'Shantinagar', '50'),
(35, 2, 'Wari', '50'),
(36, 1, 'Adabor', '50'),
(37, 1, 'Agargaon', '50'),
(38, 1, 'Asad Gate', '50'),
(39, 1, 'Badda', '50'),
(40, 1, 'Banani Road 1 - 11', '50'),
(41, 1, 'Banani Road 12 - 19', '50'),
(42, 1, 'Banani Road 20 - 28', '50'),
(43, 1, 'Baridhara', '50'),
(44, 1, 'Bashundhara', '50'),
(45, 1, 'Dakshinkhan', '50'),
(46, 1, 'Darus Salam', '50'),
(47, 1, 'Dhaka Cantonment', '50'),
(48, 1, 'Dhamrai', '50'),
(49, 1, 'Farmgate', '50'),
(50, 1, 'Gulshan 1', '50'),
(51, 1, 'Gulshan 2', '50'),
(52, 1, 'Kallyanpur', '50'),
(53, 1, 'Kawran Bazar', '50'),
(54, 1, 'Khilgaon', '50'),
(55, 1, 'Khilkhet', '50'),
(56, 1, 'Kuril', '50'),
(57, 1, 'Mirpur 1', '50'),
(58, 1, 'Mirpur 10', '50'),
(59, 1, 'Mirpur 11 - 13', '50'),
(60, 1, 'Mirpur 60 Feet', '50'),
(61, 1, 'Mirpur Cantonment', '50'),
(62, 1, 'Mirpur DOHS', '50'),
(63, 1, 'Mirpur Kazipara', '50'),
(64, 1, 'Mirpur Shewrapara', '50'),
(65, 1, 'Mohakhali', '50'),
(66, 1, 'Mohammadpur Chandmiya Housing', '50'),
(67, 1, 'Mohammadpur Mohammadia Housing Society', '50'),
(68, 1, 'Mohammadpur Non Housing Area', '50'),
(69, 1, 'Mohammadpur PC Culture Society', '50'),
(70, 1, 'Mohammadpur Residential Area', '50'),
(71, 1, 'Monipuri Para', '50'),
(72, 1, 'Niketon', '50'),
(73, 1, 'Sher-e-Bangla Nagar', '50'),
(74, 1, 'Shyamoli', '50'),
(75, 1, 'Tejgaon', '50'),
(76, 1, 'Tejgaon Industrial Area', '50'),
(77, 1, 'Uttara 1,3,5,14', '50'),
(78, 1, 'Uttara 2,4,6,8', '50'),
(79, 1, 'Uttara 7,12,13', '50'),
(80, 1, 'Uttara 9,10,11', '50');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `type` text NOT NULL,
  `productid` bigint(20) NOT NULL,
  `quantity` tinyint(11) NOT NULL,
  `size` text NOT NULL,
  `color` text NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `shipingcost` double NOT NULL DEFAULT 0,
  `subtotal` double NOT NULL DEFAULT 0,
  `coupon` varchar(50) NOT NULL,
  `orderflag` tinyint(2) NOT NULL,
  `orderid` varchar(100) NOT NULL,
  `orderstatus` tinyint(2) NOT NULL,
  `orderdate` date NOT NULL,
  `shopid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `categoryname` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `cid` smallint(6) NOT NULL,
  `regionid` int(11) NOT NULL,
  `cityname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`cid`, `regionid`, `cityname`) VALUES
(1, 3, 'Dhaka North'),
(2, 3, 'Dhaka South'),
(3, 3, 'Faridpur'),
(4, 3, 'Gazipur'),
(5, 3, 'Gopalganj'),
(6, 3, 'Kishoreganj'),
(7, 3, 'Madaripur'),
(8, 3, 'Manikganj - Shibloya'),
(9, 3, 'Manikganj - Shingair'),
(10, 3, 'Manikganj - Town'),
(11, 3, 'Munshiganj - Gajaria'),
(12, 3, 'Munshiganj - Lohajong'),
(13, 3, 'Munshiganj - Sirajdikhan'),
(14, 3, 'Munshiganj - Town'),
(15, 3, 'Narayanganj'),
(16, 3, 'Narsingdi'),
(17, 3, 'Nawabganj'),
(18, 3, 'Rajbari - Balaikandi'),
(19, 3, 'Rajbari - Pangsha'),
(20, 3, 'Rajbari - Town'),
(21, 3, 'Savar'),
(22, 3, 'Shariatpur - Naria'),
(23, 3, 'Shariatpur - Town'),
(24, 3, 'Tangail - Basail'),
(25, 3, 'Tangail - Bahuapur'),
(26, 3, 'Tangail - Deldur'),
(27, 3, 'Tangail - Ghatail'),
(28, 3, 'Tangail - Gopalpur'),
(29, 3, 'Tangail - Kalihati'),
(30, 3, 'Tangail - Kashkawlia'),
(31, 3, 'Tangail - Madhupur'),
(32, 3, 'Tangail - Mirzapur'),
(33, 3, 'Tangail - Nagarpur'),
(34, 3, 'Tangail - Shakhipur'),
(35, 3, 'Tangail - Town');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `status` varchar(2) NOT NULL,
  `pamount` varchar(50) DEFAULT NULL,
  `trxn` varchar(100) DEFAULT NULL,
  `paytype` varchar(40) DEFAULT NULL,
  `orderid` mediumtext NOT NULL,
  `paydate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `prating`
--

CREATE TABLE `prating` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `rating` int(2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_title` text NOT NULL,
  `sscid` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `pimg_front` text NOT NULL,
  `pimg_back` text DEFAULT NULL,
  `pimg_left` text DEFAULT NULL,
  `pimg_right` text DEFAULT NULL,
  `pimg_top` text DEFAULT NULL,
  `pimg_bottom` text DEFAULT NULL,
  `product_price` int(11) NOT NULL DEFAULT 0,
  `coupon` varchar(10) NOT NULL DEFAULT '0',
  `couponamount` float NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `psize` varchar(150) NOT NULL DEFAULT '0',
  `keywords` varchar(300) DEFAULT NULL,
  `specification` longtext NOT NULL,
  `shopid` int(11) NOT NULL,
  `stage` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `rid` int(11) NOT NULL,
  `regionname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`rid`, `regionname`) VALUES
(1, 'Barisal'),
(2, 'Chittagong'),
(3, 'Dhaka'),
(4, 'Khulna'),
(5, 'Mymensingh'),
(6, 'Rajshahi'),
(7, 'Rangpur'),
(8, 'Sylhet');

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `shopname` text NOT NULL,
  `address` text NOT NULL,
  `contact` tinytext NOT NULL,
  `email` text NOT NULL,
  `passwd` text NOT NULL,
  `nidpassport` varchar(300) NOT NULL,
  `servicelogo` varchar(300) NOT NULL,
  `active` tinytext NOT NULL,
  `level` tinytext NOT NULL,
  `type` tinytext NOT NULL,
  `salt` tinytext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ship`
--

CREATE TABLE `ship` (
  `sid` int(11) NOT NULL,
  `suserid` tinyint(4) NOT NULL,
  `type` text NOT NULL,
  `fname` text NOT NULL,
  `sphone` text NOT NULL,
  `sregion` text NOT NULL,
  `scity` text NOT NULL,
  `sarea` text NOT NULL,
  `saddress` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ssc`
--

CREATE TABLE `ssc` (
  `id` int(11) NOT NULL,
  `subcatid` int(11) NOT NULL,
  `ssctitle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ssc`
--

INSERT INTO `ssc` (`id`, `subcatid`, `ssctitle`) VALUES
(1, 1, 'Gasoline'),
(2, 1, 'Diesel'),
(3, 12, 'Demo Dyna'),
(4, 12, 'Pants');

-- --------------------------------------------------------

--
-- Table structure for table `subcategory`
--

CREATE TABLE `subcategory` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subcategory`
--

INSERT INTO `subcategory` (`id`, `category_id`, `subcategory_name`) VALUES
(1, 1, 'Generator'),
(12, 2, 'Dynamic'),
(13, 1, 'Battery'),
(14, 1, 'IPS'),
(15, 1, 'UPS');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mail` text NOT NULL,
  `passwd` mediumtext NOT NULL,
  `active` text NOT NULL,
  `level` text NOT NULL,
  `type` text NOT NULL,
  `salt` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`aid`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `products` ADD FULLTEXT KEY `query` (`product_title`,`keywords`,`specification`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ship`
--
ALTER TABLE `ship`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `ssc`
--
ALTER TABLE `ssc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `area`
--
ALTER TABLE `area`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `cid` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ship`
--
ALTER TABLE `ship`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ssc`
--
ALTER TABLE `ssc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
