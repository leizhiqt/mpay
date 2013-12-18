SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `ClientDoc` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientId` int(11) DEFAULT NULL,
  `docTypeId` int(11) DEFAULT NULL,
  `filepath` varchar(200) DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `filepath` (`filepath`),
  KEY `branchId` (`branchId`),
  CONSTRAINT `ClientDoc_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


`photoPath` varchar(64) DEFAULT NULL,

