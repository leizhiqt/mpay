SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `Store` (
  `id` int(11) NOT NULL DEFAULT '0',
  `storeKey` varchar(6) DEFAULT NULL,
  `storeName` varchar(16) DEFAULT NULL,
  `storeAddress` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storeKey` (`storeKey`),
  UNIQUE KEY `storeName` (`storeName`),
  KEY `storeAddress` (`storeAddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

