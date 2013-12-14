<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.mooo.mycoz.framework.Action"%>

<%
	Vector<Action> mainMenu = new Vector<Action>();
	
	Action setup = new Action(sessionId,"Setup", "Setup.do");
	setup.addChildAction(new Action(sessionId,"BranchCategory","BranchCategory.do"));
	setup.addChildAction(new Action(sessionId,"Branch","Branch.do"));
	setup.addChildAction(new Action(sessionId,"JobType","JobType.do"));

	/*
	setup.addChildAction(new Action(sessionId,"UserType","UserType.do"));
	setup.addChildAction(new Action(sessionId,"JobType","JobType.do"));
	setup.addChildAction(new Action(sessionId,"JobState","JobState.do"));
	setup.addChildAction(new Action(sessionId,"CardType","CardType.do"));
	setup.addChildAction(new Action(sessionId,"WineType","WineType.do"));
	setup.addChildAction(new Action(sessionId,"WineLevel","WineLevel.do"));
	
	setup.addChildAction(new Action(sessionId,"WarehouseItem","WarehouseItem.do"));
	setup.addChildAction(new Action(sessionId,"WineTaster","WineTaster.do"));*/
	mainMenu.add(setup);
	
	Action admin = new Action(sessionId,"Admin", "Admin.do");
	admin.addChildAction(new Action(sessionId,"WorkGroup","WorkGroup.do"));
	admin.addChildAction(new Action(sessionId,"Role","Role.do"));//Nested Group is Role
	admin.addChildAction(new Action(sessionId,"User","User.do"));
	mainMenu.add(admin);
	
	Action profile = new Action(sessionId,"Profile", "Profile.do");
	
	profile.addChildAction(new Action(sessionId,"CreditType","CreditType.do"));
	profile.addChildAction(new Action(sessionId,"Product","Product.do"));
	profile.addChildAction(new Action(sessionId,"Store","Store.do"));
	profile.addChildAction(new Action(sessionId,"Certificate","Certificate.do"));
	
	/*
	profile.addChildAction(new Action(sessionId,"WineryProperty","WineryProperty.do"));
	profile.addChildAction(new Action(sessionId,"Product","Product.do"));
	profile.addChildAction(new Action(sessionId,"Warehouse","Warehouse.do"));
	profile.addChildAction(new Action(sessionId,"StorageAccount","StorageAccount.do"));
	profile.addChildAction(new Action(sessionId,"SampleProduct","SampleProduct.do"));
	
	profile.addChildAction(new Action(sessionId,"BrewJob","BrewJob.do"));
	profile.addChildAction(new Action(sessionId,"BrewCrafts","BrewCrafts.do"));
	profile.addChildAction(new Action(sessionId,"BrewPoint","BrewPoint.do"));
	profile.addChildAction(new Action(sessionId,"BrewJobDetail","BrewJobDetail.do"));
	profile.addChildAction(new Action(sessionId,"Barcode","Barcode.do"));*/
	mainMenu.add(profile);
	
	Action operation = new Action(sessionId,"Operation", "Operation.do");
	operation.addChildAction(new Action(sessionId,"Client","Client.do"));
	
	/*
	operation.addChildAction(new Action(sessionId,"WineryManage","Winery.do"));
	operation.addChildAction(new Action(sessionId,"WineJarManage","WineJar.do"));
	operation.addChildAction(new Action(sessionId,"WineJarManage","WineJar.do","listLowWineJar"));
	operation.addChildAction(new Action(sessionId,"CardManage","Card.do"));
	operation.addChildAction(new Action(sessionId,"CardJob","CardJob.do","listCardJob"));
	operation.addChildAction(new Action(sessionId,"DayPatrol","DayCardJob.do","listDayPatrol"));
	
	operation.addChildAction(new Action(sessionId,"Package","Package.do"));
	operation.addChildAction(new Action(sessionId,"Sales","Sale.do"));*/
	mainMenu.add(operation);
	/*
	Action report = new Action(sessionId,"Report", "Report.do");
	report.addChildAction(new Action(sessionId,"PatrolReport","Report.do","patrolReport"));
	mainMenu.add(report);
	
	Action help = new Action(sessionId,"Help", "Help.do");
	help.addChildAction(new Action(sessionId,"Version","Help.do","version"));
	help.addChildAction(new Action(sessionId,"Document","Help.do","document"));
	mainMenu.add(help);
*/
	request.setAttribute("mainMenu", mainMenu);
%>