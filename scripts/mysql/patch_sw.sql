SET FOREIGN_KEY_CHECKS = 0;

//Pay try t
alter table ClientJob add `sessionId` int(11) DEFAULT NULL;
alter table ClientJob add  key `sessionId`(`sessionId`) ;
alter table ClientJob add  CONSTRAINT `ClientJob_ibfk_5` FOREIGN KEY (`sessionId`) REFERENCES `User` (`id`);

//Pay System Database Version1.0

alter table ClientJob add `unLock` char(1) DEFAULT 'N';
