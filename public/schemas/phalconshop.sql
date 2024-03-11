-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 06, 2024 at 11:27 AM
-- Server version: 10.11.6-MariaDB-2
-- PHP Version: 8.3.0-1ubuntu1

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `aname`, `amail`, `apasswd`, `active`, `level`, `type`, `servicename`, `address`, `contact`, `servicelogo`, `idcard`) VALUES
(1, 'webmaster', 'webmaster@localhost.com', '$1$d0dNcElp$gPXDDrwEEwLM7IN95Tq1n.', '1', '4', 's', 'developer', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE `area` (
  `aid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `areaname` varchar(100) NOT NULL,
  `delivery_charge` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `cashonfee` varchar(5) NOT NULL DEFAULT '0',
  `subtotal` double NOT NULL DEFAULT 0,
  `coupon` varchar(50) NOT NULL,
  `orderflag` tinyint(2) NOT NULL,
  `orderid` varchar(100) NOT NULL,
  `trxn` varchar(50) NOT NULL,
  `paytype` tinyint(2) NOT NULL,
  `orderstatus` tinyint(2) NOT NULL,
  `orderdate` date NOT NULL,
  `shopid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `userid`, `type`, `productid`, `quantity`, `size`, `color`, `price`, `discount`, `shipingcost`, `cashonfee`, `subtotal`, `coupon`, `orderflag`, `orderid`, `trxn`, `paytype`, `orderstatus`, `orderdate`, `shopid`) VALUES
(1, 1, 'b', 2, 3, '10g', '100224133257-breadboard -medium-88.jpg', 1200, 1100, 0, '0', 3300, '0', 0, '12-100224145844', '0', 0, 0, '2024-02-10', 1),
(2, 1, 'b', 3, 1, '100KG', '100224145038-b.jpeg', 65000, 52000, 0, '0', 52000, '0', 0, '13-100224145857', '0', 0, 0, '2024-02-10', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `categoryname` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `categoryname`) VALUES
(1, 'Power'),
(2, 'Grocery'),
(3, 'Electronics');

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `cid` smallint(6) NOT NULL,
  `regionid` int(11) NOT NULL,
  `cityname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Table structure for table `prating`
--

CREATE TABLE `prating` (
  `id` int(11) NOT NULL,
  `usrid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `rating` int(2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prating`
--

INSERT INTO `prating` (`id`, `usrid`, `productid`, `rating`, `created_at`) VALUES
(1, 1, 2, 4, '2024-02-21 19:09:50'),
(2, 1, 12, 5, '2024-02-21 19:10:07'),
(3, 1, 33, 5, '2024-02-21 19:10:29'),
(4, 1, 27, 4, '2024-02-21 19:27:16'),
(5, 1, 11, 2, '2024-02-21 19:27:26'),
(6, 1, 13, 1, '2024-02-21 19:27:33'),
(7, 1, 3, 3, '2024-02-21 19:27:41'),
(8, 1, 29, 2, '2024-02-21 19:27:49'),
(9, 1, 4, 4, '2024-02-21 19:27:57'),
(10, 1, 34, 4, '2024-02-21 19:40:24');

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
  `couponamount` int(11) NOT NULL DEFAULT 0,
  `discount` int(11) NOT NULL DEFAULT 0,
  `psize` varchar(150) NOT NULL DEFAULT '0',
  `pcode` varchar(20) DEFAULT NULL,
  `scaletype` tinyint(3) NOT NULL,
  `pweight` varchar(300) NOT NULL,
  `keywords` mediumtext DEFAULT NULL,
  `warranty` varchar(500) DEFAULT NULL,
  `specification` longtext NOT NULL,
  `shopid` int(11) NOT NULL,
  `stage` varchar(2) NOT NULL,
  `hits` int(11) NOT NULL,
  `stock` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_title`, `sscid`, `category_id`, `subcategory_id`, `pimg_front`, `pimg_back`, `pimg_left`, `pimg_right`, `pimg_top`, `pimg_bottom`, `product_price`, `coupon`, `couponamount`, `discount`, `psize`, `pcode`, `scaletype`, `pweight`, `keywords`, `warranty`, `specification`, `shopid`, `stage`, `hits`, `stock`) VALUES
(2, 'Sensor ESP32', 2, 1, 1, '100224133257-breadboard -medium-88.jpg', '100224133257-ultrasonic sensor pin details.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1200, 'SDER45', 8, 1100, '1g,2g,5g,10g,15g,20g', 'S-E901D', 7, '0', 'sensor,esp32,power,generator,diesel', '0', 'esp32', 1, '2', 112, 1),
(3, 'Tiger 20 KVA Gasoline Generator Set', 1, 1, 1, '100224145037-111.png', '100224145037-234.jpg', 'empty.png', 'empty.png', '100224145038-b.jpeg', 'empty.png', 65000, 'SE43EU', 15, 52000, '100KG,500KG,1T', 'S-E901456', 7, '0', 'tiger,gasoline,power,generator', '0', 'Tiger Brand', 1, '2', 29, 1),
(4, 'Data Load', 1, 1, 1, '010324224746-91cszmus6nl._ac_uf1000,1000_ql80_.jpg', '010324224746-hsc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 3000, '0', 0, 2700, '10g,15g,20g,25g,30g,40g,50g,100g', '0', 7, '0', 'data,load,power,generator,gasoline', '0', 'data load', 2, '2', 51, 0),
(5, 'Resume data', 2, 1, 1, '020324011209-btr.jpg', '020324011209-ieb-engr.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 800, '0', 0, 0, '250g,300g,400g,500g', '0', 7, '0', 'resume,data,power,generator,diesel', '0', 'resume data', 2, '2', 28, 1),
(6, 'Delta Power Solar Panel', 1, 1, 1, '290224140553-abbt1.jpg', '290224140554-pocket usb led 40.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 24000, '0', 0, 0, '5g,20g,50g,50KG,1T', 'D-EGB11', 7, '0', 'delta,solar,power,generator,gasoline', '0', 'delta super solar panel', 2, '2', 12, 1),
(8, 'Sukam IPS', 11, 1, 14, '200224015805-hsc.jpg', '200224015806-led.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 29500, '0', 0, 0, '5KG,10KG', '0', 7, '0', 'sukam,power,ips,luminous', '4', 'sukam ips', 2, '2', 5, 1),
(9, 'Rahim Afrooz UPS', 10, 1, 15, '200224020119-networkmap_dashboard_1.png', '200224020119-pushb.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 3500, '0', 0, 0, '50KG,100KG', '0', 7, '0', 'rahim,afrooz,power,ups,rahim afrooz', '5', 'Rahim Afrooz IPS', 2, '2', 4, 1),
(10, 'Cotton Pant', 4, 2, 12, '200224030113-amarbangla.jpg', '200224030113-gcc vs tcc.jpg', 'empty.png', 'empty.png', '200224030113-freedownloadmanager.jpg', 'empty.png', 1200, '0', 0, 0, '3,4,6,7', '0', 4, '0', 'pant,cotton,grocery,dynamic,pants', '5', 'pants', 1, '3', 4, 1),
(11, 'Cotton jeans', 3, 2, 12, '030324160350-ieb-engr.jpg', '030324160350-led.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 500, '0', 0, 0, '4XL,5XL,6XL,7XL,8XL', '0', 1, '0', 'pant,cotton,jeans,grocery,dynamic,demo dyna', '0', 'jeans', 1, '3', 8, 0),
(12, 'Cotton Bras', 4, 2, 12, '200224030443-isp-speed.jpg', '200224030443-l1.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1700, '0', 0, 0, '(24-36) A,(24 - 36) B,(24 - 36) C', '0', 6, '0', 'bras,cotton,grocery,dynamic,pants', '0', 'cotton bras', 1, '3', 5, 1),
(13, 'data', 10, 1, 15, '030324160441-slch.jpeg', '030324160442-tb6612fbg-dual-driver-module.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1200, '0', 0, 0, '500g,1KG,2KG', '0', 7, '0', 'power,ups,rahim afrooz', '0', 'sdsdsa', 1, '3', 7, 0),
(14, 'data sample', 7, 1, 13, '200224030825-hsc.jpg', '200224030826-dcsa result.png', 'empty.png', 'empty.png', '200224030826-ssc-t.jpg', 'empty.png', 65000, '0', 0, 0, '4,5,7', '0', 4, '0', 'data,sample,power,battery,lithium ion', '2', 'data sample', 1, '3', 4, 1),
(15, 'Sensor ESP32', 12, 1, 14, '200224030937-ssc.jpg', '200224030937-ssc-t.jpg', '200224030937-hsc-m.jpg', 'empty.png', '200224030937-image (7).jpg', 'empty.png', 24000, '0', 0, 0, 'A,C,D,E,F', '0', 5, '0', 'power,ips,sukam', '2', 'dfsfdsf', 1, '3', 0, 1),
(16, 'Nokia Android11', 13, 3, 18, '200224031502-image (7).jpg', '200224031502-hsc-m.jpg', '200224031502-dcsa result.png', 'empty.png', '200224031502-hsc.jpg', 'empty.png', 78000, '0', 0, 0, '10g,15g,20g,25g,30g,40g,50g', '0', 7, '0', 'nokia,android,electronics,mobile', '5', 'nokia mobile', 1, '4', 6, 1),
(17, 'Symphony mobile IS170', 14, 3, 18, '200224031805-dcsa result.png', '200224031806-hsc.jpg', 'empty.png', 'empty.png', '200224031806-hsc-m.jpg', 'empty.png', 15000, '0', 0, 0, '25g,40g,100g,150g', '0', 7, '0', 'mobile,android,symphony,electronics', '0', 'Symphony mobile', 1, '4', 4, 1),
(18, 'Walton Android 12', 15, 3, 18, '200224031933-hsc.jpg', '200224031933-dcsa result.png', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 18000, '0', 0, 0, '150g,200g,250g', '0', 7, '0', 'walton,electronics,mobile', '1', 'walton android mobile', 1, '4', 5, 1),
(19, 'Micromax Mobile 199F', 16, 3, 18, '030324211837-water level sensor module-195.png', '030324211837-car.png', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 22000, '0', 0, 0, '250g,300g,400g', '0', 7, '0', 'Micromax,electronics,mobile,micromax', '0', 'Micromax Mobile', 1, '4', 7, 0),
(20, 'Honor 8 Android Mobile', 17, 3, 18, '200224032117-hsc-m.jpg', '200224032117-image (7).jpg', 'empty.png', 'empty.png', '200224032117-ssc.jpg', 'empty.png', 32000, '0', 0, 0, '300g,400g,500g', '0', 7, '0', 'honor,electronics,mobile', '0', 'Honor Mobile', 1, '4', 4, 1),
(21, 'data loader extra', 15, 3, 18, '200224223524-91cszmus6nl._ac_uf1000,1000_ql80_.jpg', '200224223524-hsc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 550, '0', 0, 0, 'B,C,D,E', '0', 5, '0', 'data,electronics,mobile,walton', '5', 'datax', 1, '3', 3, 1),
(22, 'dynamic loads', 3, 2, 12, '200224223710-hsc.jpg', '200224223710-led.jpg', 'empty.png', 'empty.png', '200224223710-ieb-engr.jpg', 'empty.png', 650, '0', 0, 0, '8,9,10,11', '0', 3, '0', 'dynamic,grocery,demo dyna', '0', 'dynamic loads', 1, '4', 7, 1),
(23, 'Golden Ring', 4, 2, 12, '200224223845-ieb-engr.jpg', '200224223845-led.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1800, '0', 0, 0, '4.5,5,5.5,6,6.5,9,10', '0', 2, '0', 'gold,diamond,ring,grocery,dynamic,pants', '1', 'ring gold', 1, '1', 4, 1),
(24, 'Symphony 12I9 Android Mobile', 14, 3, 18, '200224224025-ieb-engr.jpg', '200224224025-hsc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 34000, '0', 0, 0, 'M,L,XL,XXL', '0', 1, '0', 'symphony,android,mobile,electronics', '3', 'symphony 12I9', 1, '4', 4, 1),
(25, 'Luminous Heavy Duty', 11, 1, 14, '200224230246-s-l1600.jpg', '200224230247-pushb.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 134000, '0', 0, 0, '100KG,500KG,1T', '0', 7, '0', 'luminous,ips,ups,power', '0', 'Luminous', 1, '1', 7, 1),
(26, 'Walton Rugged Mobile', 15, 3, 18, '200224231111-91cszmus6nl._ac_uf1000,1000_ql80_.jpg', '200224231111-hsc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 43500, '0', 0, 0, '40g,50g,100g,150g,200g', '0', 7, '0', 'walton,rugged,mobile,electronics', '6', 'Walton Rugged Mobile\r\nHeavy duty\r\nIP68', 1, '1', 11, 1),
(27, 'Samsung TV 22', 20, 3, 20, '210224024135-amarbangla.jpg', '210224024135-fdm-config.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 22000, '0', 0, 0, '15g,20g,25g,30g,40g,50g,100g', '0', 7, '0', 'samsung,tv,electronics,television,samsung led television', '0', 'samsung tv', 2, '1', 5, 1),
(28, 'AMD Ryzen I7', 22, 3, 19, '210224024355-fdm-config.jpg', '210224024355-freedownloadmanager.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 72000, '0', 0, 0, '2KG,5KG,10KG', '0', 7, '0', 'amd,ryzen,electronics,laptops,amd ryzen i7', '6', 'AMD Ryzen', 2, '1', 3, 1),
(29, 'Asus I7 Laptop', 23, 3, 19, '210224024504-fdm-config.jpg', '210224024504-freedownloadmanager.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 68500, 'TP001', 10, 0, '1KG,2KG,5KG,10KG', '0', 7, '0', 'I7,i7,asus,electronics,laptops,asus i7', '0', 'Asus I7', 2, '1', 5, 1),
(30, 'Demo Dyna', 3, 2, 12, '290224151420-networkmap_dashboard_1.png', '290224151420-abbt1.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1250, '0', 0, 0, '(24 - 36) C,(24 - 36) D,(24 - 36) E', '0', 6, '0', 'demo,dyna,grocery,dynamic,demo dyna', '0', 'Demo Dyna', 2, '1', 22, 1),
(31, 'Micromax Mobile LXG', 16, 3, 18, '030324221102-esp32-pinout.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 1850, '0', 0, 0, '20g,25g,30g', '0', 7, '0', 'Micromax,mobile,electronics,micromax', '0', 'Micromax LXG', 2, '1', 13, 0),
(32, 'walton led tv', 19, 3, 20, '210224024933-amarbangla.jpg', '210224024933-gcc vs tcc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 28000, '0', 0, 0, '5KG,10KG,20KG', '0', 7, '0', 'tv,walton,led,electronics,television,walton led television', '6', 'walton led tv', 2, '1', 1, 1),
(33, 'xiaomi 14 pro', 25, 3, 18, '030324211449-tb6612fbg-dual-driver-module.jpg', '030324211449-s-l1600.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 38900, '0', 0, 0, '200g,250g,300g', '0', 7, '0', 'xiaomi,android,electronics,mobile', '0', 'xiaomi 14 pro', 2, '1', 22, 0),
(34, 'mi 14 pro max', 24, 3, 18, '210224152619-91cszmus6nl._ac_uf1000,1000_ql80_.jpg', '210224152619-hsc.jpg', 'empty.png', 'empty.png', 'empty.png', 'empty.png', 42800, '0', 0, 0, '8,9,10,11', '0', 3, '0', 'mi,android,electronics,mobile', '1', 'mi 14 pro max', 2, '1', 37, 1);

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `rid` int(11) NOT NULL,
  `regionname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `name`, `shopname`, `address`, `contact`, `email`, `passwd`, `nidpassport`, `servicelogo`, `active`, `level`, `type`, `salt`, `created_at`) VALUES
(1, 'daraz', 'daraz', 'daraz', '0909090909', 'daraz@localhost.com', '$1$em9FdytN$HfsPbQyOQ50yj9YmlPy/N0', '060123161245-o1.jpg', '060123161245-o1.jpg', '1', '2', 's', 'hdo1P2kkfziFJbjr', '2023-01-06 10:12:45'),
(2, 'bdcom', 'bdcom', 'bdcom', '435435543435', 'bdcom@localhost.com', '$1$UDlKa2I1$VHN9aLg.5ez5ndW2Y9vE31', '060123161512-n1.jpg', '060123161512-n1.jpg', '1', '2', 's', 'FFlsHBc08I6H9swh', '2023-01-06 10:15:12');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ssc`
--

CREATE TABLE `ssc` (
  `id` int(11) NOT NULL,
  `subcatid` int(11) NOT NULL,
  `ssctitle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ssc`
--

INSERT INTO `ssc` (`id`, `subcatid`, `ssctitle`) VALUES
(1, 1, 'Gasoline'),
(2, 1, 'Diesel'),
(3, 12, 'Demo Dyna'),
(4, 12, 'Pants'),
(5, 16, 'NextBack'),
(6, 17, 'US Navy491'),
(7, 13, 'Lithium Ion'),
(8, 13, 'Hamco'),
(9, 14, 'Rahim Afrooz'),
(10, 15, 'Rahim Afrooz'),
(11, 14, 'Luminous'),
(12, 14, 'Sukam'),
(13, 18, 'Nokia'),
(14, 18, 'Symphony'),
(15, 18, 'Walton'),
(16, 18, 'Micromax'),
(17, 18, 'Honor'),
(18, 19, 'LG LED Television'),
(19, 20, 'Walton LED Television'),
(20, 20, 'Samsung LED Television'),
(21, 19, 'Lenovo X230'),
(22, 19, 'AMD Ryzen I7'),
(23, 19, 'Asus I7'),
(24, 18, 'Mi'),
(25, 18, 'Xiaomi');

-- --------------------------------------------------------

--
-- Table structure for table `subcategory`
--

CREATE TABLE `subcategory` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategory`
--

INSERT INTO `subcategory` (`id`, `category_id`, `subcategory_name`) VALUES
(1, 1, 'Generator'),
(12, 2, 'Dynamic'),
(13, 1, 'Battery'),
(14, 1, 'IPS'),
(15, 1, 'UPS'),
(16, 16, 'BackGen'),
(17, 12, 'Telescope'),
(18, 3, 'Mobile'),
(19, 3, 'Laptops'),
(20, 3, 'Television'),
(21, 3, 'Desktop PC');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `mail`, `passwd`, `active`, `level`, `type`, `salt`) VALUES
(1, 'sayed', 'sayed@localhost.com', '$1$dndrM3Fw$yS06EiLQW4ZAkjm8xIJ8j/', '1', '1', 'b', '20231025200025');

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
-- Indexes for table `prating`
--
ALTER TABLE `prating`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `cid` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `prating`
--
ALTER TABLE `prating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ship`
--
ALTER TABLE `ship`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ssc`
--
ALTER TABLE `ssc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
