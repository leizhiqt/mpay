<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.mooo.mycoz.framework.Action"%>

<%
	Vector<Action> mainMenu = new Vector<Action>();
	
	Action setup = new Action(sessionId,"Setup", "Setup.do");
	setup.addChildAction(new Action(sessionId,"BranchCategory","BranchCategory.do"));
	setup.addChildAction(new Action(sessionId,"Branch","Branch.do"));
	setup.addChildAction(new Action(sessionId,"JobType","JobType.do"));
	mainMenu.add(setup);
	
	Action admin = new Action(sessionId,"Admin", "Admin.do");
	admin.addChildAction(new Action(sessionId,"WorkGroup","WorkGroup.do"));
	admin.addChildAction(new Action(sessionId,"Role","Role.do"));//Nested Group is Role
	admin.addChildAction(new Action(sessionId,"User","User.do"));
	mainMenu.add(admin);
	
	Action profile = new Action(sessionId,"Profile", "Profile.do");
	
	profile.addChildAction(new Action(sessionId,"Product","Product.do"));
	profile.addChildAction(new Action(sessionId,"FinancialProduct","FinancialProduct.do"));
	profile.addChildAction(new Action(sessionId,"JobCheck","JobCheck.do"));
	profile.addChildAction(new Action(sessionId,"Store","Store.do"));
	mainMenu.add(profile);
	
	Action operation = new Action(sessionId,"Operation", "Operation.do");
	operation.addChildAction(new Action(sessionId,"LoginStore","LoginStore.do"));
	operation.addChildAction(new Action(sessionId,"Sales","Sale.do"));
	operation.addChildAction(new Action(sessionId,"Approval","ClientInfo.do"));

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