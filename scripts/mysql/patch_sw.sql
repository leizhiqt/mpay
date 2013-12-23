SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `StoreType` (
  `id` int(11) NOT NULL DEFAULT '0',
  `typeKey` varchar(6) DEFAULT NULL,
  `typeName` varchar(16) DEFAULT NULL,
  `typeBankName` varchar(16) DEFAULT NULL,
   `typeBankNo` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `typeKey` (`typeKey`),
  KEY `typeName` (`typeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8