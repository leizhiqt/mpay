SET FOREIGN_KEY_CHECKS = 0;

//Pay System Database Version1.0
CREATE TABLE `ClientJobCheck` (
  `id` int(11) NOT NULL DEFAULT '0',
  `jobTrackId` int(11) NOT NULL DEFAULT '0',
  `jobCheckId` int(11) NOT NULL DEFAULT '0',
  `checkRemark` varchar(32) DEFAULT NULL,
  `branchId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `jobTrackId` (`jobTrackId`),
  KEY `jobCheckId` (`jobCheckId`),
  CONSTRAINT `ClientJobCheck_ibfk_1` FOREIGN KEY (`jobTrackId`) REFERENCES `ClientJobTrack` (`id`),
  CONSTRAINT `ClientJobCheck_ibfk_2` FOREIGN KEY (`jobCheckId`) REFERENCES `payShared`.`JobCheck` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

