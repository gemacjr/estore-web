-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: EStore
-- Source Schemata: EStore
-- Created: Sun Feb 27 10:15:57 2022
-- Workbench Version: 8.0.28
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema EStore
-- ----------category------------------------------------------------------------------
DROP SCHEMA IF EXISTS `EStore` ;
CREATE SCHEMA IF NOT EXISTS `EStore` ;
USE `EStore`;

-- ----------------------------------------------------------------------------
-- Table EStore.Brand
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Brand` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Slug` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UQ_Brand_Slug` (`Slug` ASC) VISIBLE);

INSERT INTO `EStore`.`Brand` (`Name`, `Slug`) VALUES 
('Apple','apple'),
('Samsung','samsung'),
('Asus','asus'),
('HP','hp'),
('Xiaomi','xiaomi'),
('BeU','beu');

-- ----------------------------------------------------------------------------
-- Table EStore.Category
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Category` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `NameVI` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `NameEN` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Slug` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UQ_Category_Slug` (`Slug` ASC) VISIBLE);
  
INSERT INTO `EStore`.`Category` (`NameVI`, `NameEN`, `Slug`) VALUES 
('Điện thoại','Phone','phone'),
('Máy tính bảng','Tablet','tablet'),
('Máy tính xách tay','Laptop','laptop'),
('Máy tính để bàn','PC','pc'),
('Đồng hồ thông minh','Smartwatch','smartwatch'),
('Tai nghe','Headphone','headphone');

-- ----------------------------------------------------------------------------
-- Table EStore.Discount
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Discount` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `SaleOff` DOUBLE NOT NULL,
  `StartDate` DATETIME(6) NOT NULL,
  `EndDate` DATETIME(6) NOT NULL,
  `IsActive` TINYINT(1) NOT NULL DEFAULT 1,
  `CreatedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`));
  
INSERT INTO `EStore`.`Discount` (`Name`, SaleOff, StartDate, EndDate, IsActive, CreatedDate) VALUES 
('Khuyến mãi đầu năm',10,'2022-01-10 10:04:58.360000','2022-02-22 12:50:34.217000',0,'2022-02-19 03:04:58'),
('Khuyến mãi tháng 2',15,'2022-02-10 00:00:00.000000','2022-02-28 00:00:00.000000',1,'2022-02-21 20:59:38'),
('Khuyến mãi tháng 2',10,'2022-02-10 00:00:00.000000','2022-02-22 12:50:34.250000',0,'2022-02-21 21:41:16'),
('Khuyến mãi tháng 2',5,'2022-02-10 00:00:00.000000','2022-02-28 11:30:27.867000',1,'2022-02-21 21:42:07'),
('Khuyến mãi tháng 2',3,'2022-02-14 00:00:00.000000','2022-02-28 00:00:00.000000',1,'2022-02-21 21:42:54');

-- ----------------------------------------------------------------------------
-- Table EStore.Role
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Role` (
	`Id` BIGINT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`Id`)
);

INSERT INTO `EStore`.`Role` (`Name`) VALUES ('ROLE_CUSTOMER'), ('ROLE_STAFF'), ('ROLE_ADMIN');

-- ----------------------------------------------------------------------------
-- Table EStore.User
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`User` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(128) NOT NULL,
  `Fullname` VARCHAR(128) CHARACTER SET 'utf8mb4' NOT NULL,
  `Email` VARCHAR(128) NOT NULL,
  `Address` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL,
  `PhoneNumber` VARCHAR(10) NULL,
  `Photo` VARCHAR(128) NULL,
  `CreatedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `IsAdmin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UQ_User_Username` (`Username` ASC) VISIBLE,
  UNIQUE INDEX `UQ_User_Email` (`Email` ASC) VISIBLE);

INSERT INTO`EStore`.`User` (Username, `Password`, Fullname, Email, Address, PhoneNumber, Photo, CreatedDate, Enabled, IsAdmin) VALUES 
('MaiNT','$2a$10$LuRi1lmkBg/3c/bg./EcbeC1DeT2.BZfXsTVCrA8nDYr4hPYNnqbq','Nguyễn Thị Mai','maint@gmail.com','Đạ Ròn - Đơn Dương - Lâm Đồng','0389894357','MaiNT.jpg','2022-02-21 09:42:23',1,0),
('AnhPTQ','$2a$10$z/mpc04bezbLWwxodoQb9OXA0cVO0Pr1p2reAT/6zFSpwJnIFuuIy','Phan Thị Quỳnh Anh','anhptq@gmail.com','Trung Mỹ Tây, Quận 12, TP.HCM','0389894357','AnhPTQ.jpg','2022-02-21 09:37:04',1,0),
('Admin','$2a$10$kL0UEwTe2Q2fSf8TfXYahOPLtC.Q1k7ZX1ynbgiwgw7A0.1pmaaSG','Admin','admin@gmail.com','Phường Trung Mỹ Tây, Quận 12, TP.HCM','0345679898','Admin.jpeg','2022-02-21 09:53:32',1,1);

-- ----------------------------------------------------------------------------
-- Table EStore.Authority
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Authority` (
	`Id` BIGINT NOT NULL AUTO_INCREMENT,
    `UserId` BIGINT NOT NULL,
    `RoleId` BIGINT NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT FK_Authority_User FOREIGN KEY (`UserId`) REFERENCES `EStore`.`User` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Authority_Role FOREIGN KEY (`RoleId`) REFERENCES `EStore`.`Role` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `EStore`.`Authority` (`UserId` ,`RoleId`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(3, 2),
(3, 3);

-- ----------------------------------------------------------------------------
-- Table EStore.Product
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Product` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) CHARACTER SET 'utf8mb4' NOT NULL,
  `Slug` VARCHAR(255) CHARACTER SET 'utf8mb4' NOT NULL,
  `Image` VARCHAR(150) NOT NULL,
  `ImagePreview1` VARCHAR(150) NOT NULL,
  `ImagePreview2` VARCHAR(150) NULL,
  `ImagePreview3` VARCHAR(150) NULL,
  `ImagePreview4` VARCHAR(150) NULL,
  `VideoPreview` VARCHAR(150) NULL,
  `Description` TEXT CHARACTER SET 'utf8mb4' NOT NULL,
  `Quantity` INT NULL,
  `Price` DOUBLE NULL,
  `CreatedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Available` INT NOT NULL DEFAULT 0,
  `CategoryId` BIGINT NOT NULL,
  `BrandId` BIGINT NOT NULL,
  `DiscountId` BIGINT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UQ_Product_Slug` (`Slug` ASC) VISIBLE,
  CONSTRAINT `FK_Product_Brand`
    FOREIGN KEY (`BrandId`)
    REFERENCES `EStore`.`Brand` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Product_Category`
    FOREIGN KEY (`CategoryId`)
    REFERENCES `EStore`.`Category` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Product_Discount`
    FOREIGN KEY (`DiscountId`)
    REFERENCES `EStore`.`Discount` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

INSERT INTO `EStore`.`Product` (`Name`, Slug, Image, ImagePreview1, ImagePreview2, ImagePreview3, ImagePreview4, VideoPreview, `Description`, Quantity, Price, CreatedDate, Available, CategoryId, BrandId, DiscountId) VALUES 
('iPhone 13 128GB', 'iphone-13-128gb', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/ip13-pro_2.jpg', 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-1.jpg', 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-2.jpg', 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-black-3.jpg', 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-white-2.jpg', 'RF6F5vwbyok', 'Mỗi lần ra mắt phiên bản mới là mỗi lần iPhone chiếm sóng trên khắp các mặt trận và lần này cái tên khiến vô số người "sục sôi" là iPhone 13 Pro, chiếc điện thoại thông minh vẫn giữ nguyên thiết kế cao cấp, cụm 3 camera được nâng cấp, cấu hình mạnh mẽ cùng thời lượng pin lớn ấn tượng.', 100, 32490000, CURDATE(), 0, 1, 1, NULL),
('iPhone XR 128GB', 'iphone-xr-128gb', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/iphone_xr_red_1.png', 'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-1-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-2-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-3-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-trang-4-org.jpg', '9LpyLziSSK0', 'Được xem là phiên bản iPhone giá rẻ đầy hoàn hảo, iPhone Xr 128GB khiến người dùng có nhiều sự lựa chọn hơn về màu sắc đa dạng nhưng vẫn sở hữu cấu hình mạnh mẽ và thiết kế sang trọng.', 100, 17490000, CURDATE(), 0, 1, 1, 4),
('Apple MacBook Air M1 2020 16GB/256GB/7-core GPU', 'apple-macbook-air-m1-2020-16gb-256gb-7-core-gpu', 'https://cdn.tgdd.vn/Products/Images/44/239552/apple-macbook-air-m1-2020-z124000de-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/44/239552/apple-macbook-air-m1-2020-z124000de-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-02-org.jpg', 'https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-03-org.jpg', 'https://cdn.tgdd.vn/Products/Images/44/239552/macbook-air-m1-2020-silver-04-org.jpg', 'YqLueJ0hDV8', 'Laptop Apple MacBook Air M1 2020 có thiết kế đẹp, sang trọng với CPU M1 độc quyền từ Apple cho hiệu năng đồ họa cao, màn hình Retina hiển thị siêu nét cùng với hệ thống bảo mật tối ưu.', 500, 30990000, CURDATE(), 1, 3, 1, NULL),
('iPhone 12 Pro Max 512GB', 'iphone-12-pro-max-512gb', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/small_image/9df78eab33525d08d6e5fb8d27136e95/i/p/iphone_12_pro_max_white.png', 'https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-2-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-3-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/228744/iphone-12-pro-max-512gb-5-org.jpg', 'DQgPImbgiKg', 'iPhone 12 Pro Max 512GB - đẳng cấp từ tên gọi đến từng chi tiết. Ngay từ khi chỉ là tin đồn thì chiếc smartphone này đã làm đứng ngồi không yên bao “fan cứng” nhà Apple, với những nâng cấp vô cùng nổi bật hứa hẹn sẽ mang đến những trải nghiệm tốt nhất về mọi mặt mà chưa một chiếc iPhone tiền nhiệm nào có được.', 100, 41990000, CURDATE(), 0, 1, 1, 5),
('Samsung Galaxy Z Fold3 5G 256GB', 'samsung-galaxy-z-fold3-5g-256gb', 'https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-silver-1-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-1-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-2-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-3-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/226935/samsung-galaxy-z-fold-3-4-1-org.jpg', 'bASu58FOYDQ', 'Không dừng lại ở một chiếc điện thoại thông minh cao cấp, mà nó còn bền bỉ và kết nối siêu tốc với 5G. Kế đến là màn hình tràn viền lớn với trải nghiệm gập mở độc nhất để bạn có thể giải trí và làm việc ở một cách hoàn hảo.<br/><br/>Nhờ chế độ gập mở đa góc độ Flex Mode, Galaxy Z Fold3 5G mở ra một thế giới tuyệt vời với khả năng đứng thẳng độc đáo.2 Thiết kế cân đối hoàn hảo cho bạn thỏa sức khám phá kỷ nguyên tiếp theo của tương lai điện thoại thông minh.', 100, 41990000, CURDATE(), 0, 1, 2, NULL),
('Samsung Galaxy S21 FE 5G 128GB', 'samsung-galaxy-s21-fe-5g-128gb', 'https://cdn.tgdd.vn/Products/Images/42/267211/Samsung-Galaxy-S21-FE-tim-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-trang-4.jpg', 'https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-1.jpg', 'https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-2.jpg', 'https://cdn.tgdd.vn/Products/Images/42/267211/samsung-galaxy-s21-fe-tim-3.jpg', '7MEpNQpd2hU', 'Tiếp nối sự thành công của Galaxy S20 FE, gã khổng lồ Hàn Quốc tiếp tục cho ra mắt Samsung S21 FE với định hướng tốt về giá – mạnh về hiệu năng của mình cho phân khúc cao cấp. Sản phẩm là sự kết hợp hoàn hảo của một thiết kế thời trang, cấu hình và hiệu năng mạnh mẽ đi kèm mức giá tốt cho người dùng.', 50, 15990000, CURDATE(), 0, 1, 2, NULL),
('Samsung Galaxy A03s', 'samsung-galaxy-a03s', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-gc-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-4.jpg', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-5.jpg', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-3.jpg', '6zhdoERt_AM', 'Nhằm đem đến cho người dùng thêm sự lựa chọn trong phân khúc, Samsung đã cho ra mắt thêm một chiếc điện thoại giá rẻ với tên gọi Galaxy A03s. So với người tiền nhiệm Galaxy A02s, thiết bị sẽ có một số nâng cấp mới, đây hứa hẹn sẽ là sản phẩm đáng để bạn trải nghiệm.', 100, 3690000, CURDATE(), 0, 1, 2, NULL),
('Samsung Galaxy Z Flip3 5G 128GB', 'samsung-galaxy-z-flip3-5g-128gb', 'https://cdn.tgdd.vn/Products/Images/42/241049/samsung-galaxy-a03s-black-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip-3-black-gc-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-2-org.jpg', 'https://cdn.tgdd.vn/Products/Images/42/229949/samsung-galaxy-z-flip3-black-3-org.jpg', 'jECDdUHO-Fw', 'Trong sự kiện Galaxy Unpacked hồi 11/8, Samsung đã chính thức trình làng mẫu điện thoại màn hình gập thế hệ mới mang tên Galaxy Z Flip3 5G 128GB. Đây là một siêu phẩm với màn hình gập dạng vỏ sò cùng nhiều điểm cải tiến và thông số ấn tượng, sản phẩm chắc chắn sẽ thu hút được rất nhiều sự quan tâm của người dùng, đặc biệt là phái nữ.', 80, 24990000, CURDATE(), 0, 1, 2, NULL),
('Asus VivoBook A415EA i5 1135G7 (AM1637W)', 'asus-vivobook-a415ea-i5-1135g7-am1637w', 'https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-1135g7-8gb-512gb-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-6.jpg', 'https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-7.jpg', 'https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-8.jpg', 'https://cdn.tgdd.vn/Products/Images/44/266203/asus-vivobook-a415ea-i5-am1637w-1.jpg', '76kx8zeIeuk', 'Laptop VivoBook A415EA (AM1637W) được nhà Asus cho ra mắt với vai trò là người bạn đồng hành đắc lực trong phân khúc laptop học tập - văn phòng khi sở hữu lối thiết kế đơn giản nhưng không kém phần thanh lịch cùng những thông số kỹ thuật ổn định đáp ứng tốt đa tác vụ thiết yếu cho người dùng.', 100, 18790000, CURDATE(), 0, 3, 3, NULL),
('iPad Pro M1 12.9 inch 5G', 'ipad-pro-m1-129-inch-5g', 'https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-2021-129-inch-gray-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-128gb-2021-xam-1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-128gb-2021-xam-2-org.jpg', 'https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-m1-129-inch-wifi-cellular-512gb-2021-xam-3.jpeg', 'https://cdn.tgdd.vn/Products/Images/522/238649/ipad-pro-129-inch-wifi-cellular-13.jpeg', 'oTB1T_Z0d9k', 'Bạn có đang mong chờ những sản phẩm chất lượng đến từ Apple? Sau hàng loạt các sản phẩm đình đám như iPhone 12 series thì hãng đã tung ra chiếc iPad Pro M1 12.9 inch Wifi Cellular 128GB (2021) trang bị những tính năng ngày càng vượt trội và thời thượng.', 100, 31290000, CURDATE(), 0, 2, 1, NULL),
('HP AIO 24 df1030d i5 1135G7/8GB/512GB/23.8', 'hp-aio-24-df1030d-i5-1135g7-8gb-512gb-238f', 'https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-2.jpg', 'https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-2.jpg', 'https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-1.jpg', 'https://cdn.tgdd.vn/Products/Images/5698/265511/hp-aio-24-df1030d-i5-4b6e3pa-3.jpg', 'https://hanoicomputercdn.com/media/product/60735_pc_hp_all_in_one_24_df1028d_4.jpg', 'dTL9p0OSHe8', 'Nếu bạn đang tìm kiếm một chiếc máy tính để bàn tích hợp đầy đủ mọi tính năng trên một màn hình lớn bao gồm CPU, ổ cứng, loa, camera và có cả chuột cùng bàn phím đi kèm, HP AIO 24 df1030d i5 (4B6E3PA) sẽ là một sự lựa chọn sáng giá đáp ứng mọi nhu cầu học tập, văn phòng cơ bản cho người dùng.', 50, 20590000, CURDATE(), 0, 4, 4, NULL),
('Apple Watch SE 40mm viền nhôm dây silicon', 'apple-watch-se-40mm', 'https://cdn.tgdd.vn/Products/Images/7077/234918/se-40mm-vien-nhom-day-cao-su-den-thumb-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/vi-vn-se-40mm-vien-nhom-day-cao-su-hong-slider-fix.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/se-40mm-vien-nhom-day-cao-su-hong-080221-0347530.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/vi-vn-se-40mm-vien-nhom-day-cao-su-hong-hbv-fix.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/234918/Slider/se-40mm-vien-nhom-day-cao-su-hong-080221-0348059.jpg', 'npToOhjFot8', 'Apple Watch SE 40mm viền nhôm dây cao su hồng có khung viền chắc chắn, thiết kế bo tròn 4 góc giúp thao tác vuốt chạm thoải mái hơn. Mặt kính cường lực Ion-X strengthened glass với kích thước 1.57 inch, hiển thị rõ ràng. Khung viền nhôm chắc chắn cùng dây đeo cao su có độ đàn hồi cao, êm ái, tạo cảm giác thoải mái khi đeo.', 80, 8990000, CURDATE(), 0, 5, 1, NULL),
('Bluetooth AirPods Pro MagSafe Charge Apple MLWK3', 'bluetooth-airpods-pro-magsafe-charge-apple-mlwk3', 'https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-1.jpg', 'https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-1.jpg', 'https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-2.jpg', 'https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-3.jpg', 'https://cdn.tgdd.vn/Products/Images/54/253802/bluetooth-airpods-pro-magsafe-charge-apple-mlwk3-4.jpg', 'emL289uOTRY', 'Tai nghe Bluetooth AirPods Pro MagSafe Charge Apple MLWK3 trắng được chế tác với vẻ ngoài tinh giản, gam màu trắng trẻ trung, sáng đẹp, phối hợp tuyệt vời với mọi trang phục từ đời thường đến công sở, dự tiệc của bạn. ', 90, 4990000, CURDATE(), 0, 6, 1, 4),
('Xiaomi 11 Lite 5G NE', 'xiaomi-11-lite-5g-ne', 'https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-pink-600x600.jpg', 'https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-1-1.jpg', 'https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-black-gc-1.jpg', 'https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-tr-1.jpg', 'https://cdn.tgdd.vn/Products/Images/42/249427/xiaomi-11-lite-5g-ne-blue-gc.jpg', 'bvlqH2kiNMI', 'Xiaomi 11 Lite 5G NE một phiên bản có ngoại hình rất giống với Mi 11 Lite được ra mắt trước đây. Chiếc smartphone này của Xiaomi mang trong mình một hiệu năng ổn định, thiết kế sang trọng và màn hình lớn đáp ứng tốt các tác vụ hằng ngày của bạn một cách dễ dàng.', 1500, 9490000, CURDATE(), 0, 1, 4, NULL),
('BeU B2', 'beu-b2', 'https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi3-org.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi3-org.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-moi1-org.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-4-org.jpg', 'https://cdn.tgdd.vn/Products/Images/7077/231681/beu-b2-hong-3-org.jpg', 'XWymK4iNXzo', 'Đồng hồ thông minh BeU tự hào là dòng sản phẩm mang thương hiệu Việt Nam, sở hữu đầy đủ những tính năng hữu ích và cần thiết như: theo dõi giấc ngủ, đo nhịp tim, trang bị nhiều bài luyện tập thể thao,... đi kèm với giá thành rẻ, phù hợp với thị trường người tiêu dùng Việt', 500, 490000, CURDATE(), 0, 5, 5, NULL);
-- ----------------------------------------------------------------------------
-- Table EStore.Order
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Order` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `OrderCode` VARCHAR(11) NOT NULL,
  `UserId` BIGINT NOT NULL,
  `CreatedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` INT NOT NULL DEFAULT 0,
  `Fullname` VARCHAR(128) CHARACTER SET 'utf8mb4' NOT NULL,
  `Address` VARCHAR(255) CHARACTER SET 'utf8mb4' NOT NULL,
  `Email` VARCHAR(128) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UQ_Order_OrderCode` (`OrderCode` ASC) VISIBLE,
  CONSTRAINT `FK_Order_User`
    FOREIGN KEY (`UserId`)
    REFERENCES `EStore`.`User` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
INSERT INTO `EStore`.`Order` (OrderCode, UserId, CreatedDate, `Status`, Fullname, Address, Email, PhoneNumber) VALUES 
('cjbyB61lo9P',3,'2022-01-15 03:58:38',1,'Admin','Phường Trung Mỹ Tây, Quận 12, TP.HCM','admin@gmail.com','0345679898'),
('bYG94HomdOi',3,'2022-02-22 04:12:31',0,'Admin','Phường Trung Mỹ Tây, Quận 12, TP.HCM','admin@gmail.com','0345679898'),
('d3htmb6yask',1,'2021-12-11 04:13:00',1,'Nguyễn Thị Mai','Đạ Ròn - Đơn Dương - Lâm Đồng','maint@gmail.com','0389894357'),
('N7CKkltEtzD',1,'2021-10-05 04:13:58',1,'Nguyễn Thị Mai','Đạ Ròn - Đơn Dương - Lâm Đồng','maint@gmail.com','0389894357'),
('PA52heWJsvR',2,'2021-12-16 04:14:50',1,'Phan Thị Quỳnh Anh','Trung Mỹ Tây, Quận 12, TP.HCM','anhptq@gmail.com','0389894357'),
('QuhO5HL0nWE',2,'2022-02-22 04:16:08',0,'Phan Thị Quỳnh Anh','Trung Mỹ Tây, Quận 12, TP.HCM','anhptq@gmail.com','0389894357');

-- ----------------------------------------------------------------------------
-- Table EStore.Order_Detail
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Order_Detail` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `OrderId` BIGINT NOT NULL,
  `ProductId` BIGINT NOT NULL,
  `Quantity` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_OrderDetail_Order`
    FOREIGN KEY (`OrderId`)
    REFERENCES `EStore`.`Order` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_OrderDetail_Product`
    FOREIGN KEY (`ProductId`)
    REFERENCES `EStore`.`Product` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

INSERT INTO `EStore`.`Order_Detail` (OrderId, ProductId, Quantity, Price) VALUES 
(1,2,1,17490000),
(2,12,1,8990000),
(3,3,1,30990000),
(4,10,1,31290000),
(5,13,1,4990000),
(6,11,1,20590000);

-- ----------------------------------------------------------------------------
-- Table EStore.Persistent_Logins
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Persistent_Logins` (
  `username` VARCHAR(100) NOT NULL,
  `series` VARCHAR(64) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `last_used` DATETIME(6) NOT NULL,
  PRIMARY KEY (`series`));

-- ----------------------------------------------------------------------------
-- Table EStore.Shopping_Cart
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Shopping_Cart` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `UserId` BIGINT NOT NULL,
  `ProductId` BIGINT NOT NULL,
  `Quantity` INT NULL DEFAULT 1,
  `CreatedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_ShoppingCart_Product`
    FOREIGN KEY (`ProductId`)
    REFERENCES `EStore`.`Product` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ShoppingCart_User`
    FOREIGN KEY (`UserId`)
    REFERENCES `EStore`.`User` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- ----------------------------------------------------------------------------
-- Table EStore.Verification_Token
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `EStore`.`Verification_Token` (
  `Id` BIGINT NOT NULL AUTO_INCREMENT,
  `Token` VARCHAR(30) NOT NULL,
  `UserId` BIGINT NOT NULL,
  `ExpiryDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Verification_User`
    FOREIGN KEY (`UserId`)
    REFERENCES `EStore`.`User` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
SET FOREIGN_KEY_CHECKS = 1;
