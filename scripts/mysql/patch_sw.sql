SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `ClientJob` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientId` int(11) NOT NULL DEFAULT '0',
  `totalPrice` decimal(7,3) DEFAULT NULL,
  `selfAmount` decimal(7,3) DEFAULT NULL,
  `financialProductId` int(11) NOT NULL DEFAULT '0',
  `jobNo` varchar(20) DEFAULT NULL,
  `totalPay` decimal(7,3) DEFAULT NULL,
  `monthOfPay` decimal(7,3) DEFAULT NULL,
  `monthOfDate` date DEFAULT NULL,
  `byUse` varchar(50) DEFAULT NULL,
  `jobDate` date DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  `privateKey` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jobNo` (`jobNo`),
  KEY `clientId` (`clientId`),
  KEY `totalPay` (`totalPay`),
  KEY `monthOfPay` (`monthOfPay`),
  KEY `monthOfDate` (`monthOfDate`),
  KEY `byUse` (`byUse`),
  KEY `jobDate` (`jobDate`),
  KEY `financialProductId` (`financialProductId`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `ClientJob_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
  CONSTRAINT `ClientJob_ibfk_2` FOREIGN KEY (`financialProductId`) REFERENCES `payShared`.`FinancialProduct` (`id`),
  CONSTRAINT `ClientJob_ibfk_3` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


