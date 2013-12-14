SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `Client` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientName` varchar(16) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `marry` varchar(2) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `childs` int(11) DEFAULT NULL,
  `housing` varchar(11) DEFAULT NULL,
  `educationId` int(11) DEFAULT NULL,
  `homePhoneName` varchar(16) DEFAULT NULL,
  `homePhone` varchar(11) DEFAULT NULL,
  `email` varchar(16) DEFAULT NULL,
  `identityId` int(11) DEFAULT 0,
  `schoolId` int(11) DEFAULT 0,
  `relativesId` int(11) DEFAULT 0,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`clientName`,`identityId`),
  KEY `mobile` (`mobile`),
  KEY `housing` (`housing`),
  KEY `educationId` (`educationId`),
  CONSTRAINT `Client_ibfk_1` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `ClientJob` (
	`id` int(11) NOT NULL DEFAULT '0',
	`clientId` int(11) NOT NULL DEFAULT '0',
	`creditTypeId` int(11) NOT NULL DEFAULT '0',
	`saleId` int(11) NOT NULL DEFAULT '0',
	`jobNo` varchar(20) DEFAULT NULL,
	`creditAmount` decimal(7,3) DEFAULT NULL,
	`downAmount` decimal(7,3) DEFAULT NULL,
	`firstpayDate` date DEFAULT NULL,
	`repaymentDate` date DEFAULT NULL,
	`byUse` varchar(50) DEFAULT NULL,
	`jobDate` date DEFAULT NULL,
	`branchId` int(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE KEY `jobNo` (`jobNo`),
	KEY `clientId` (`clientId`),
	KEY `saleId` (`saleId`),
	KEY `creditAmount` (`creditAmount`),
	KEY `downAmount` (`downAmount`),
	KEY `firstpayDate` (`firstpayDate`),
	KEY `repaymentDate` (`repaymentDate`),
	KEY `byUse` (`byUse`),
	KEY `jobDate` (`jobDate`),
	KEY `branchId` (`branchId`),
	CONSTRAINT `ClientJob_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
	CONSTRAINT `ClientJob_ibfk_2` FOREIGN KEY (`creditTypeId`) REFERENCES `payShared`.`CreditType` (`id`),
	CONSTRAINT `ClientJob_ibfk_3` FOREIGN KEY (`saleId`) REFERENCES `Sale` (`id`),
  	CONSTRAINT `ClientJob_ibfk_4` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Bank` (
	`id` int(11) NOT NULL DEFAULT '0',
	`clientId` int(11) NOT NULL DEFAULT '0',
	`debitCard` varchar(19) DEFAULT NULL,
	`bankName` varchar(32) DEFAULT NULL,
	`autoPay` char(1) DEFAULT NULL,
	`branchId` int(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE KEY `debitCard` (`debitCard`),
	KEY `clientId` (`clientId`),
	KEY `bankName` (`bankName`),
	KEY `branchId` (`branchId`),
	CONSTRAINT `Bank_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
  	CONSTRAINT `Bank_ibfk_2` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `ClientJobTrack` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientJobId` int(11) NOT NULL DEFAULT '0',
  `userId` int(11) NOT NULL DEFAULT '0',
  `jobTypeId` int(11) DEFAULT NULL,
  `jobRemark` varchar(32) DEFAULT NULL,
  `processId` int(11) DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `clientJobId` (`clientJobId`),
  KEY `userId` (`userId`),
  KEY `jobTypeId` (`jobTypeId`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `ClientJobTrack_ibfk_1` FOREIGN KEY (`clientJobId`) REFERENCES `ClientJob` (`id`),
CONSTRAINT `ClientJobTrack_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `User` (`id`),
CONSTRAINT `ClientJobTrack_ibfk_3` FOREIGN KEY (`jobTypeId`) REFERENCES `payShared`.`JobType` (`id`),
  	CONSTRAINT `ClientJobTrack_ibfk_4` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Relatives` (
  `id` int(11) NOT NULL DEFAULT '0',
  `relativesType` varchar(16) DEFAULT NULL,

  `employerName` varchar(16) DEFAULT NULL,
  `officePhone` varchar(11) DEFAULT NULL,
  `extencePhone` varchar(11) DEFAULT NULL,
  `zipCode` varchar(8) DEFAULT NULL,
  `census` varchar(32) DEFAULT NULL,

  `province` varchar(32) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `county` varchar(32) DEFAULT NULL,
  `town` varchar(32) DEFAULT NULL,
  `street` varchar(32) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `valid` int(11) DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `employerName` (`employerName`),
  KEY `officePhone` (`officePhone`),
  KEY `extencePhone` (`extencePhone`),
  KEY `branchId` (`branchId`),
    	CONSTRAINT `Relatives_ibfk_1` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Sale` (
  `id` int(11) NOT NULL DEFAULT '0',
  `storeId` int(11) NOT NULL DEFAULT '0',
  `totalAmount` decimal(7,3) DEFAULT NULL,
  `saleNo` varchar(20) DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `storeId` (`storeId`),
  KEY `totalAmount` (`totalAmount`),
  KEY `saleNo` (`saleNo`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `Sale_ibfk_1` FOREIGN KEY (`storeId`) REFERENCES `payShared`.`Store` (`id`),
  	CONSTRAINT `Sale_ibfk_2` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `SaleDetail` (
	`id` int(11) NOT NULL DEFAULT '0',
	`saleId` int(11) NOT NULL DEFAULT '0',
	`productId` int(11) NOT NULL DEFAULT '0',
	`itemQuantity` int(11) NOT NULL DEFAULT '0',
	`itemPrice` decimal(7,3) DEFAULT NULL,
	`branchId` int(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	KEY `saleId` (`saleId`),
	KEY `productId` (`productId`),
	KEY `branchId` (`branchId`),
	CONSTRAINT `SaleDetail_ibfk_1` FOREIGN KEY (`saleId`) REFERENCES `Sale` (`id`),
	CONSTRAINT `SaleDetail_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `payShared`.`Product` (`id`),
	CONSTRAINT `SaleDetail_ibfk_3` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Product` (
  `id` int(11) NOT NULL DEFAULT '0',
  `productName` varchar(16) DEFAULT NULL,
  `brand` varchar(16) DEFAULT NULL,
  `modelNo` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productName` (`productName`),
  KEY `brand` (`brand`),
  KEY `modelNo` (`modelNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Store` (
  `id` int(11) NOT NULL DEFAULT '0',
  `storeName` varchar(16) DEFAULT NULL,
  `storeAddress` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storeName` (`storeName`),
  KEY `storeAddress` (`storeAddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `CreditType` (
  `id` int(11) NOT NULL DEFAULT '0',
  `creditName` varchar(16) DEFAULT NULL,
  `cycleTotal` int(11) DEFAULT '0',
  `cycleUnit` varchar(32) DEFAULT NULL,
  `creditRate` decimal(6,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `creditName` (`creditName`),
  KEY `cycleTotal` (`cycleTotal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `Certificate` (
  `id` int(11) NOT NULL DEFAULT '0',
  `certificateCode` varchar(20) DEFAULT NULL,
  `issuingAuthority` varchar(64) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `valid` int(11) DEFAULT NULL,
  `certificateType` enum('Identity','School') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificateCode` (`certificateCode`),
  KEY `issuingAuthority` (`issuingAuthority`),
  KEY `issueDate` (`issueDate`),
  KEY `valid` (`valid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
