SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `ClientJob` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientId` int(11) NOT NULL DEFAULT '0',
  `storeId` int(11) NOT NULL DEFAULT '0',
  `oProductId` int(11) NOT NULL DEFAULT '0',
  `oPrice` decimal(7,3) DEFAULT NULL,
  `tProductId` int(11) NOT NULL DEFAULT '0',
  `tPrice` decimal(7,3) DEFAULT NULL,
  `totalPrice` decimal(7,3) DEFAULT NULL,
  `financialProductId` int(11) NOT NULL DEFAULT '0',
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
  KEY `creditAmount` (`creditAmount`),
  KEY `downAmount` (`downAmount`),
  KEY `firstpayDate` (`firstpayDate`),
  KEY `repaymentDate` (`repaymentDate`),
  KEY `byUse` (`byUse`),
  KEY `jobDate` (`jobDate`),
  KEY `storeId` (`storeId`),
  KEY `oProductId` (`oProductId`),
  KEY `tProductId` (`tProductId`),
  KEY `financialProductId` (`financialProductId`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `ClientJob_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
  CONSTRAINT `ClientJob_ibfk_2` FOREIGN KEY (`oProductId`) REFERENCES `payShared`.`Product` (`id`),
  CONSTRAINT `ClientJob_ibfk_3` FOREIGN KEY (`tProductId`) REFERENCES `payShared`.`Product` (`id`),
  CONSTRAINT `ClientJob_ibfk_4` FOREIGN KEY (`storeId`) REFERENCES `payShared`.`Store` (`id`),
  CONSTRAINT `ClientJob_ibfk_5` FOREIGN KEY (`financialProductId`) REFERENCES `payShared`.`FinancialProduct` (`id`),
  CONSTRAINT `ClientJob_ibfk_6` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8