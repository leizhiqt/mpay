SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `StoreUser` (
  `id` int(11) NOT NULL DEFAULT '0',
  `storeId` int(11) NOT NULL DEFAULT '0',
  `userId` int(11) NOT NULL DEFAULT '0',
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `storeId` (`storeId`),
  KEY `userId` (`userId`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `StoreUser_ibfk_1` FOREIGN KEY (`storeId`) REFERENCES `payShared`.`Store` (`id`),
  CONSTRAINT `StoreUser_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `User` (`id`),
  CONSTRAINT `StoreUser_ibfk_3` FOREIGN KEY (`branchId`) REFERENCES `payShared`.`Branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 


