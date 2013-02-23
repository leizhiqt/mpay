SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0

 CREATE TABLE `FinancialCategory` (
  `id` int(11) NOT NULL DEFAULT '0',
  `financialId` int(11) NOT NULL DEFAULT '0',
  `productId` int(11) NOT NULL DEFAULT '0',
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `financialId` (`financialId`),
  KEY `productId` (`productId`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `FinancialCategory_ibfk_1` FOREIGN KEY (`financialId`) REFERENCES `payShared`.`FinancialProduct` (`id`),
  CONSTRAINT `FinancialCategory_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `payShared`.`Product` (`id`),
  CONSTRAINT `FinancialCategory_ibfk_3` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8