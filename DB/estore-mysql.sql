CREATE DATABASE  IF NOT EXISTS `estore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `estore`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: estore
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authority`
--

DROP TABLE IF EXISTS `authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authority` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `UserId` bigint NOT NULL,
  `RoleId` bigint NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Authority_User` (`UserId`),
  KEY `FK_Authority_Role` (`RoleId`),
  CONSTRAINT `FK_Authority_Role` FOREIGN KEY (`RoleId`) REFERENCES `role` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Authority_User` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authority`
--

LOCK TABLES `authority` WRITE;
/*!40000 ALTER TABLE `authority` DISABLE KEYS */;
INSERT INTO `authority` VALUES (1,1,1),(2,1,2),(3,2,1),(4,3,1),(5,3,2),(6,3,3);
/*!40000 ALTER TABLE `authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UQ_Brand_Slug` (`Slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Apple','apple'),(2,'Samsung','samsung'),(3,'Asus','asus'),(4,'HP','hp'),(5,'Xiaomi','xiaomi'),(6,'BeU','beu');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `NameVI` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NameEN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UQ_Category_Slug` (`Slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Điện thoại','Phone','phone'),(2,'Máy tính bảng','Tablet','tablet'),(3,'Máy tính xách tay','Laptop','laptop'),(4,'Máy tính để bàn','PC','pc'),(5,'Đồng hồ thông minh','Smartwatch','smartwatch'),(6,'Tai nghe','Headphone','headphone');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SaleOff` double NOT NULL,
  `StartDate` datetime(6) NOT NULL,
  `EndDate` datetime(6) NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (1,'Khuyến mãi đầu năm',10,'2022-01-10 10:04:58.000000','2022-02-22 12:50:34.000000',0,'2022-02-18 20:04:58'),(3,'Khuyến mãi tháng 2',10,'2022-02-10 00:00:00.000000','2022-04-05 07:29:21.052000',0,'2022-02-21 14:41:16'),(6,'Khuyến mãi tháng 3',15,'2022-03-03 23:05:00.558000','2022-04-05 05:47:40.914000',0,'2022-04-03 16:05:17'),(7,'Khuyến mãi tháng 4',5,'2022-04-01 00:00:00.867000','2022-04-30 12:00:00.867000',1,'2022-04-04 22:47:30');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderCode` varchar(11) NOT NULL,
  `UserId` bigint NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` int NOT NULL DEFAULT '0',
  `Fullname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Email` varchar(128) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UQ_Order_OrderCode` (`OrderCode`),
  KEY `FK_Order_User` (`UserId`),
  CONSTRAINT `FK_Order_User` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'cjbyB61lo9P',3,'2022-01-14 20:58:38',1,'Admin','Phường Trung Mỹ Tây, Quận 12, TP.HCM','admin@gmail.com','0345679898'),(2,'bYG94HomdOi',3,'2022-02-21 21:12:31',0,'Admin','Phường Trung Mỹ Tây, Quận 12, TP.HCM','admin@gmail.com','0345679898'),(3,'d3htmb6yask',1,'2021-12-10 21:13:00',1,'Nguyễn Thị Mai','Đạ Ròn - Đơn Dương - Lâm Đồng','maint@gmail.com','0389894357'),(4,'N7CKkltEtzD',1,'2021-10-04 21:13:58',1,'Nguyễn Thị Mai','Đạ Ròn - Đơn Dương - Lâm Đồng','maint@gmail.com','0389894357'),(5,'PA52heWJsvR',2,'2021-12-15 21:14:50',1,'Phan Thị Quỳnh Anh','Trung Mỹ Tây, Quận 12, TP.HCM','anhptq@gmail.com','0389894357'),(6,'QuhO5HL0nWE',2,'2022-02-21 21:16:08',0,'Phan Thị Quỳnh Anh','Trung Mỹ Tây, Quận 12, TP.HCM','anhptq@gmail.com','0389894357');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderId` bigint NOT NULL,
  `ProductId` bigint NOT NULL,
  `Quantity` int NOT NULL,
  `Price` double NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_OrderDetail_Order` (`OrderId`),
  KEY `FK_OrderDetail_Product` (`ProductId`),
  CONSTRAINT `FK_OrderDetail_Order` FOREIGN KEY (`OrderId`) REFERENCES `order` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OrderDetail_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,1,2,1,17490000),(2,2,12,1,8990000),(3,3,3,1,30990000),(4,4,10,1,31290000),(5,5,13,1,4990000),(6,6,11,1,20590000);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(100) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` datetime(6) NOT NULL,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
INSERT INTO `persistent_logins` VALUES ('admin@gmail.com','mgz0zndpio7t4kICuLgvDA==','TCIX6LiTFlFxJ7gXMWp08A==','2022-04-05 07:46:41.843000');
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Image` varchar(150) NOT NULL,
  `ImagePreview1` varchar(150) NOT NULL,
  `ImagePreview2` varchar(150) DEFAULT NULL,
  `ImagePreview3` varchar(150) DEFAULT NULL,
  `ImagePreview4` varchar(150) DEFAULT NULL,
  `VideoPreview` varchar(150) DEFAULT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Quantity` int DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Available` int NOT NULL DEFAULT '0',
  `CategoryId` bigint NOT NULL,
  `BrandId` bigint NOT NULL,
  `DiscountId` bigint DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UQ_Product_Slug` (`Slug`),
  KEY `FK_Product_Brand` (`BrandId`),
  KEY `FK_Product_Category` (`CategoryId`),
  KEY `FK_Product_Discount` (`DiscountId`),
  CONSTRAINT `FK_Product_Brand` FOREIGN KEY (`BrandId`) REFERENCES `brand` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Product_Category` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Product_Discount` FOREIGN KEY (`DiscountId`) REFERENCES `discount` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'iPhone 13 128GB','iphone-13-128gb','https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/ip13-pro_2.jpg','https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-1.jpg','https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-2.jpg','https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-3.jpg','https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-white-2.jpg','RF6F5vwbyok','Mỗi lần ra mắt phiên bản mới là mỗi lần iPhone chiếm sóng trên khắp các mặt trận và lần này cái tên khiến vô số người \"sục sôi\" là iPhone 13 Pro, chiếc điện thoại thông minh vẫn giữ nguyên thiết kế cao cấp, cụm 3 camera được nâng cấp, cấu hình mạnh mẽ cùng thời lượng pin lớn ấn tượng.',100,32490000,'2022-04-02 17:00:00',0,1,1,NULL),(2,'iPhone XR 128GB','iphone-xr-128gb','https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/iphone_xr_red_1.png','https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-1-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-2-org.jpg','https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-3-org.jpg','https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-4-org.jpg','9LpyLziSSK0','Được xem là phiên bản iPhone giá rẻ đầy hoàn hảo, iPhone Xr 128GB khiến người dùng có nhiều sự lựa chọn hơn về màu sắc đa dạng nhưng vẫn sở hữu cấu hình mạnh mẽ và thiết kế sang trọng.',100,17490000,'2022-04-02 17:00:00',0,1,1,NULL),(3,'Apple MacBook Air M1 2020 16GB/256GB/7-core GPU','apple-macbook-air-m1-2020-16gb-256gb-7-core-gpu','https://cdn.tgdd.vn/Products/Images/44/239552/apple-macbook-air-m1-2020-z124000de-1-org.jpg','https://cdn.tgdd.vn/Products/Images/44/239552/apple-macbook-air-m1-2020-z124000de-1-org.jpg','https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-02-org.jpg','https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-03-org.jpg','https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-04-org.jpg','YqLueJ0hDV8','Laptop Apple MacBook Air M1 2020 có thiết kế đẹp, sang trọng với CPU M1 độc quyền từ Apple cho hiệu năng đồ họa cao, màn hình Retina hiển thị siêu nét cùng với hệ thống bảo mật tối ưu.',500,30990000,'2022-04-04 06:12:13',1,3,1,7),(4,'iPhone 12 Pro Max 512GB','iphone-12-pro-max-512gb','https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/iphone_12_pro_max_white.png','https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-2-org.jpg','https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-3-org.jpg','https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-5-org.jpg','DQgPImbgiKg','iPhone 12 Pro Max 512GB - đẳng cấp từ tên gọi đến từng chi tiết. Ngay từ khi chỉ là tin đồn thì chiếc smartphone này đã làm đứng ngồi không yên bao “fan cứng” nhà Apple, với những nâng cấp vô cùng nổi bật hứa hẹn sẽ mang đến những trải nghiệm tốt nhất về mọi mặt mà chưa một chiếc iPhone tiền nhiệm nào có được.',100,41990000,'2022-04-02 17:00:00',0,1,1,NULL),(5,'Samsung Galaxy Z Fold3 5G 256GB','samsung-galaxy-z-fold3-5g-256gb','https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-silver-1-600x600.jpg','https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-1-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-2-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-3-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-4-1-org.jpg','bASu58FOYDQ','Không dừng lại ở một chiếc điện thoại thông minh cao cấp, mà nó còn bền bỉ và kết nối siêu tốc với 5G. Kế đến là màn hình tràn viền lớn với trải nghiệm gập mở độc nhất để bạn có thể giải trí và làm việc ở một cách hoàn hảo.<br/><br/>Nhờ chế độ gập mở đa góc độ Flex Mode, Galaxy Z Fold3 5G mở ra một thế giới tuyệt vời với khả năng đứng thẳng độc đáo.2 Thiết kế cân đối hoàn hảo cho bạn thỏa sức khám phá kỷ nguyên tiếp theo của tương lai điện thoại thông minh.',100,41990000,'2022-04-02 17:00:00',0,1,2,NULL),(6,'Samsung Galaxy S21 FE 5G 128GB','samsung-galaxy-s21-fe-5g-128gb','https://cdn.tgdd.vn/Products/Images/42/267211/Samsung-Galaxy-S21-FE-tim-600x600.jpg','https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-trang-4.jpg','https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-1.jpg','https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-2.jpg','https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-3.jpg','7MEpNQpd2hU','Tiếp nối sự thành công của Galaxy S20 FE, gã khổng lồ Hàn Quốc tiếp tục cho ra mắt Samsung S21 FE với định hướng tốt về giá – mạnh về hiệu năng của mình cho phân khúc cao cấp. Sản phẩm là sự kết hợp hoàn hảo của một thiết kế thời trang, cấu hình và hiệu năng mạnh mẽ đi kèm mức giá tốt cho người dùng.',50,15990000,'2022-04-02 17:00:00',0,1,2,NULL),(7,'Samsung Galaxy A03s','samsung-galaxy-a03s','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-600x600.jpg','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-gc-org.jpg','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-4.jpg','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-5.jpg','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-3.jpg','6zhdoERt_AM','Nhằm đem đến cho người dùng thêm sự lựa chọn trong phân khúc, Samsung đã cho ra mắt thêm một chiếc điện thoại giá rẻ với tên gọi Galaxy A03s. So với người tiền nhiệm Galaxy A02s, thiết bị sẽ có một số nâng cấp mới, đây hứa hẹn sẽ là sản phẩm đáng để bạn trải nghiệm.',100,3690000,'2022-04-02 17:00:00',0,1,2,NULL),(8,'Samsung Galaxy Z Flip3 5G 128GB','samsung-galaxy-z-flip3-5g-128gb','https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-600x600.jpg','https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip-3-black-gc-org.jpg','https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-1-org.jpg','https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-2-org.jpg','https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-3-org.jpg','jECDdUHO-Fw','Trong sự kiện Galaxy Unpacked hồi 11/8, Samsung đã chính thức trình làng mẫu điện thoại màn hình gập thế hệ mới mang tên Galaxy Z Flip3 5G 128GB. Đây là một siêu phẩm với màn hình gập dạng vỏ sò cùng nhiều điểm cải tiến và thông số ấn tượng, sản phẩm chắc chắn sẽ thu hút được rất nhiều sự quan tâm của người dùng, đặc biệt là phái nữ.',80,24990000,'2022-04-02 17:00:00',0,1,2,NULL),(9,'Asus VivoBook A415EA i5 1135G7 (AM1637W)','asus-vivobook-a415ea-i5-1135g7-am1637w','https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-1135g7-8gb-512gb-600x600.jpg','https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-6.jpg','https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-7.jpg','https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-8.jpg','https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-1.jpg','76kx8zeIeuk','Laptop VivoBook A415EA (AM1637W) được nhà Asus cho ra mắt với vai trò là người bạn đồng hành đắc lực trong phân khúc laptop học tập - văn phòng khi sở hữu lối thiết kế đơn giản nhưng không kém phần thanh lịch cùng những thông số kỹ thuật ổn định đáp ứng tốt đa tác vụ thiết yếu cho người dùng.',100,18790000,'2022-04-02 17:00:00',0,3,3,NULL),(10,'iPad Pro M1 12.9 inch 5G','ipad-pro-m1-129-inch-5g','https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-2021-129-inch-gray-600x600.jpg','https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-128gb-2021-xam-1-org.jpg','https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-128gb-2021-xam-2-org.jpg','https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-512gb-2021-xam-3.jpeg','https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-129-inch-wifi-cellular-13.jpeg','oTB1T_Z0d9k','Bạn có đang mong chờ những sản phẩm chất lượng đến từ Apple? Sau hàng loạt các sản phẩm đình đám như iPhone 12 series thì hãng đã tung ra chiếc iPad Pro M1 12.9 inch Wifi Cellular 128GB (2021) trang bị những tính năng ngày càng vượt trội và thời thượng.',100,31290000,'2022-04-02 17:00:00',0,2,1,NULL),(11,'HP AIO 24 df1030d i5 1135G7/8GB/512GB/23.8','hp-aio-24-df1030d-i5-1135g7-8gb-512gb-238f','https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-2.jpg','https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-2.jpg','https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-1.jpg','https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-3.jpg','https://hanoicomputercdn.com/media/product/60735_pc_hp_all_in_one_24_df1028d_4.jpg','dTL9p0OSHe8','Nếu bạn đang tìm kiếm một chiếc máy tính để bàn tích hợp đầy đủ mọi tính năng trên một màn hình lớn bao gồm CPU, ổ cứng, loa, camera và có cả chuột cùng bàn phím đi kèm, HP AIO 24 df1030d i5 (4B6E3PA) sẽ là một sự lựa chọn sáng giá đáp ứng mọi nhu cầu học tập, văn phòng cơ bản cho người dùng.',50,20590000,'2022-04-04 03:54:05',0,4,4,NULL),(12,'Apple Watch SE 40mm viền nhôm dây silicon','apple-watch-se-40mm','https://cdn.tgdd.vn/Products/Images/7077/234918/se-40mm-vien-nhom-day-cao-su-den-thumb-600x600.jpg','https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/vi-vn-se-40mm-vien-nhom-day-cao-su-hong-slider-fix.jpg','https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/se-40mm-vien-nhom-day-cao-su-hong-080221-0347530.jpg','https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/vi-vn-se-40mm-vien-nhom-day-cao-su-hong-hbv-fix.jpg','https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/se-40mm-vien-nhom-day-cao-su-hong-080221-0348059.jpg','npToOhjFot8','Apple Watch SE 40mm viền nhôm dây cao su hồng có khung viền chắc chắn, thiết kế bo tròn 4 góc giúp thao tác vuốt chạm thoải mái hơn. Mặt kính cường lực Ion-X strengthened glass với kích thước 1.57 inch, hiển thị rõ ràng. Khung viền nhôm chắc chắn cùng dây đeo cao su có độ đàn hồi cao, êm ái, tạo cảm giác thoải mái khi đeo.',80,8990000,'2022-04-04 03:32:14',0,5,1,NULL),(13,'Bluetooth AirPods Pro MagSafe Charge Apple MLWK3','bluetooth-airpods-pro-magsafe-charge-apple-mlwk3','https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-1.jpg','https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-1.jpg','https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-2.jpg','https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-3.jpg','https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-4.jpg','emL289uOTRY','Tai nghe Bluetooth AirPods Pro MagSafe Charge Apple MLWK3 trắng được chế tác với vẻ ngoài tinh giản, gam màu trắng trẻ trung, sáng đẹp, phối hợp tuyệt vời với mọi trang phục từ đời thường đến công sở, dự tiệc của bạn. ',90,4990000,'2022-04-02 17:00:00',0,6,1,NULL),(14,'Xiaomi 11 Lite 5G NE','xiaomi-11-lite-5g-ne','https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-pink-600x600.jpg','https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-1-1.jpg','https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-black-gc-1.jpg','https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-tr-1.jpg','https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-blue-gc.jpg','bvlqH2kiNMI','Xiaomi 11 Lite 5G NE một phiên bản có ngoại hình rất giống với Mi 11 Lite được ra mắt trước đây. Chiếc smartphone này của Xiaomi mang trong mình một hiệu năng ổn định, thiết kế sang trọng và màn hình lớn đáp ứng tốt các tác vụ hằng ngày của bạn một cách dễ dàng.',1500,9490000,'2022-04-04 03:37:34',0,1,5,NULL),(15,'BeU B2','beu-b2','https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi3-org.jpg','https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi3-org.jpg','https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi1-org.jpg','https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-4-org.jpg','https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-3-org.jpg','XWymK4iNXzo','Đồng hồ thông minh BeU tự hào là dòng sản phẩm mang thương hiệu Việt Nam, sở hữu đầy đủ những tính năng hữu ích và cần thiết như: theo dõi giấc ngủ, đo nhịp tim, trang bị nhiều bài luyện tập thể thao,... đi kèm với giá thành rẻ, phù hợp với thị trường người tiêu dùng Việt',500,490000,'2022-04-04 05:29:23',0,5,6,NULL),(16,'Xiaomi 11T Pro 5G','xiaomi-11t-pro-5g','https://cdn.tgdd.vn/Products/Images/42/262566/xiaomi-11t-pro-5g-8gb-thumb-600x600.jpeg','https://cdn.tgdd.vn/Products/Images/42/262566/xiaomi-11t-pro-5g-8gb-thumb-600x600.jpeg','https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48','https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48','https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48','lb0DZ1O8Z08','Xiaomi 11T đầy nổi bật với thiết kế vô cùng trẻ trung, màn hình AMOLED, bộ 3 camera sắc nét và viên pin lớn đây sẽ là mẫu smartphone của Xiaomi thỏa mãn mọi nhu cầu giải trí, làm việc và là niềm đam mê sáng tạo của bạn.',500,10990000,'2022-04-04 04:20:41',0,1,5,NULL),(18,'Samsung Galaxy Buds Live R180 Gold','samsung-galaxy-buds-live-r180-gold','https://cdn.tgdd.vn/Products/Images/54/252124/ai-nghe-bluetooth-true-wireless-samsung-galaxy-buds-live-r180-gold-thumb-600x600.jpeg','https://cdn.tgdd.vn/Products/Images/54/252124/true-wireless-samsung-galaxy-buds-live-r180-3.jpg','https://cdn.tgdd.vn/Products/Images/54/252124/true-wireless-samsung-galaxy-buds-live-r180-10.jpg','https://cdn.tgdd.vn/Products/Images/54/252124/true-wireless-samsung-galaxy-buds-live-r180-11.jpg','https://cdn.tgdd.vn/Products/Images/54/252124/true-wireless-samsung-galaxy-buds-live-r180-13.jpg',NULL,'Việc sử dụng tai nghe từ lâu đã trở thành một thói quen của nhiều người bởi sự tiện lợi mà thiết bị này mang lại. Nhưng ngày nay, người dùng đòi hỏi ngày càng cao hơn đối với một chiếc tai nghe không chỉ ở thiết kế mà cả sự cải thiện về tính năng. Đáp ứng điều đó, Samsung đã cho ra mắt Samsung Galaxy Buds Live giúp trải nghiệm sử dụng tai nghe của người dùng trở nên tuyệt vời hơn',300,1990000,'2022-04-04 05:37:36',0,6,2,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_CUSTOMER'),(2,'ROLE_STAFF'),(3,'ROLE_DIRECTOR');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `UserId` bigint NOT NULL,
  `ProductId` bigint NOT NULL,
  `Quantity` int DEFAULT '1',
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `FK_ShoppingCart_Product` (`ProductId`),
  KEY `FK_ShoppingCart_User` (`UserId`),
  CONSTRAINT `FK_ShoppingCart_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ShoppingCart_User` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(128) NOT NULL,
  `Fullname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Email` varchar(128) NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PhoneNumber` varchar(10) DEFAULT NULL,
  `Photo` varchar(128) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UQ_User_Username` (`Username`),
  UNIQUE KEY `UQ_User_Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'MaiNT','$2a$10$LuRi1lmkBg/3c/bg./EcbeC1DeT2.BZfXsTVCrA8nDYr4hPYNnqbq','Nguyễn Thị Mai','maint@gmail.com','Đạ Ròn - Đơn Dương - Lâm Đồng','0389894357','MaiNT.jpg','2022-02-21 02:42:23',1),(2,'AnhPTQ','$2a$10$z/mpc04bezbLWwxodoQb9OXA0cVO0Pr1p2reAT/6zFSpwJnIFuuIy','Phan Thị Quỳnh Anh','anhptq@gmail.com','Trung Mỹ Tây, Quận 12, TP.HCM','0389894357','AnhPTQ.jpg','2022-02-21 02:37:04',1),(3,'Admin','$2a$10$kL0UEwTe2Q2fSf8TfXYahOPLtC.Q1k7ZX1ynbgiwgw7A0.1pmaaSG','Admin','admin@gmail.com','Phường Trung Mỹ Tây, Quận 12, TP.HCM','0345679898','Admin.jpeg','2022-02-21 02:53:32',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_token`
--

DROP TABLE IF EXISTS `verification_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_token` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Token` varchar(30) NOT NULL,
  `UserId` bigint NOT NULL,
  `ExpiryDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `FK_Verification_User` (`UserId`),
  CONSTRAINT `FK_Verification_User` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_token`
--

LOCK TABLES `verification_token` WRITE;
/*!40000 ALTER TABLE `verification_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-05  7:53:57
