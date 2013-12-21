SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `StoreProduct` (
  `id` int(11) NOT NULL DEFAULT '0',
  `storeId` int(11) NOT NULL DEFAULT '0',
  `productId` int(11) NOT NULL DEFAULT '0',
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `storeId` (`storeId`),
  KEY `productId` (`productId`),
  CONSTRAINT `StoreProduct_ibfk_1` FOREIGN KEY (`storeId`) REFERENCES `payShared`.`Store` (`id`),
  CONSTRAINT `StoreProduct_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `payShared`.`Product` (`id`),
  CONSTRAINT `StoreProduct_ibfk_3` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


