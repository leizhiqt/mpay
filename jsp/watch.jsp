<%
	long totle = Runtime.getRuntime().totalMemory() / (1024*1024);

	long free = Runtime.getRuntime().freeMemory() / (1024*1024);

	long max = Runtime.getRuntime().maxMemory()/(1024*1024);

	int activeCount = Thread.activeCount();

	out.println("<p>totalMemory:"+totle+"M</p>");
	out.println("<p>freeMemory:"+free+"M</p>");
	out.println("<p>maxMemory:"+max+"M</p>");
	out.println("<p>activeCount:"+activeCount+"</p>");
%>
