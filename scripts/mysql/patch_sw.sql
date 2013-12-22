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


searchSQL->SELECT client.id,client.idNo,client.clientName,clientJob.id,clientJob.totalPrice,clientJob.selfAmount,clientJob.monthOfPay,clientJob.jobNo,clientJobTrack.jobDate,clientJobTrack.jobRemark,user.name,jobType.jobKey,jobType.nextState,financialProduct.cycleTotal FROM payShared.JobType jobType,payShared.FinancialProduct financialProduct,payBranch.Client client,payBranch.ClientJobTrack clientJobTrack,payBranch.User user,payBranch.ClientJob clientJob WHERE clientJob.clientId=client.id AND clientJob.financialProductId=financialProduct.id AND clientJobTrack.clientJobId=clientJob.id AND clientJobTrack.jobTypeId=jobType.id AND clientJobTrack.userId=user.id AND clientJob.storeId=1 AND clientJobTrack.jobDate >= '2012-12-22 15:33:13' AND clientJobTrack.jobDate <= '2013-12-23 15:33:13' AND clientJobTrack.processId=0
26

searchSQL->SELECT client.id,client.idNo,client.clientName,clientJob.id,clientJob.totalPrice,clientJob.selfAmount,clientJob.monthOfPay,clientJob.jobNo,clientJobTrack.jobDate,clientJobTrack.jobRemark,user.name,jobType.jobKey,jobType.nextState,financialProduct.cycleTotal FROM payShared.JobType jobType,payShared.FinancialProduct financialProduct,payBranch.Client client,payBranch.ClientJobTrack clientJobTrack,payBranch.User user,payBranch.ClientJob clientJob WHERE clientJob.clientId=client.id AND clientJob.financialProductId=financialProduct.id AND clientJobTrack.clientJobId=clientJob.id AND clientJobTrack.jobTypeId=jobType.id AND clientJobTrack.userId=user.id AND clientJobTrack.jobDate >= '2012-12-22 15:33:55' AND clientJobTrack.jobDate <= '2013-12-23 15:33:55' AND clientJobTrack.processId=0
59
