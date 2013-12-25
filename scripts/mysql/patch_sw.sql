SET FOREIGN_KEY_CHECKS = 0;

//Pay try t
alter table ClientJob add `sessionId` int(11) DEFAULT NULL;
alter table ClientJob add  key `sessionId`(`sessionId`) ;
alter table ClientJob add  CONSTRAINT `ClientJob_ibfk_5` FOREIGN KEY (`sessionId`) REFERENCES `User` (`id`);

//Pay System Database Version1.0

alter table ClientJob add `jobLock` char(1) DEFAULT 'N';
alter table ClientDoc change `docTypeId`  `docType`  varchar(64) DEFAULT NULL;

delete  from ClientJobSale  where  clientJobId IN (select id from ClientJob where id<29);
delete from ClientJobCheck  where jobTrackId IN (select id  from ClientJobTrack  where  clientJobId IN (select id from ClientJob where id<29));
delete from ClientJobTrack  where  clientJobId IN (select id from ClientJob where id<29);
delete from ClientJob where id<29;
delete from ClientDoc where clientId IN (select id from Client where id<51);
delete from Bank where clientId IN (select id from Client where id<51);