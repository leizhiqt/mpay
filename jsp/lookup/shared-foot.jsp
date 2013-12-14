<%@page language="java" contentType="text/html;charset=UTF-8"%>

Sprops = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=400,height=250';
Mprops = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=600,height=350';
Lprops = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=800,height=450';
</script>
</head>

<fmt:bundle basename="MessageBundle">
<body bgcolor="#ffffff" onLoad="loadSourceList();">
<center>
<form method="post">
<script language="JavaScript" src="../js/calendar.js"></script>
<table bgcolor="#01cd37" border="0" cellspacing="0" cellpadding="1">
<tr>
<td colspan=4 width=100%> 
<%
  String urlStr0 = request.getContextPath() + request.getServletPath();
  StringTokenizer st = new StringTokenizer(urlStr0, "?");
  urlStr0 = st.nextToken();
  
  String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  if (listBy.equals("alphabet")) {
    for (int i=0; i < alphabet.length(); i++) {
      String urlStr = urlStr0 + "?char0=" + alphabet.charAt(i);
%>
      <a href="<%= urlStr %>"> <%= alphabet.charAt(i) %> </a>
<%
    }
%>
      <a href="<%= urlStr0+"?char0=ALL" %>"> ALL </a>
<%} else if (listBy.equals("date") || listBy.equals("jobID")) { %>
    <table bgcolor="#01cd37" border="0" cellspacing="0" cellpadding="1" width=100%><tr width=100%>
      <td><fmt:message key="StartDate"/></td>
      <td><input type='text' name="StartDate" value="<%= startDate %>" size="10" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
      </td>
      <td>&nbsp;&nbsp;&nbsp;<fmt:message key="EndDate"/></td>
      <td><input type='text' name="EndDate" value="<%= endDate %>" size="10"  onclick="displayCalendar(this,'yyyy-MM-dd');"/>
      </td>
      <td align=right width=15%><input type='submit' name='submit' value='List'></td>
   </tr></table>
<%} else if (listBy.equals("number")) { %>
<%} else { %>
   &nbsp;
<%} %>
</td>
</tr>

<tr bgcolor="#01cd37">
<td><fmt:message key="<%= textboxTitle %>"/>&nbsp;</td>
<td><input type="text" name="textbox" value="" size="17"  OnKeyUp="jumpToSelect1()" OnChange="jumpToSelect1()"></td>
<td align="left"><input type="button" name="bDone" value="Done" onClick = "addSelectedToParent();"></td>
<td align="left"><input type="button" name="bCancel" value="Cancel" onClick = "window.close();"></td>
</tr>

<tr bgcolor="#a8e1ae">
<td colspan=2><fmt:message key="<%= availableTitle %>"/></td>
<td colspan=2><fmt:message key="<%= detailTitle %>"/> </td>
</tr>

<tr bgcolor="#a8e1ae">
<td colspan=2 width="250">
<select size="17" name="srcList" onChange="display()">
<option >No record found!</option>
</select>
</td>
<td colspan=2 width="250" align="left" bgcolor="#a8e1ae">
<textarea name=info rows=12 cols=15 readonly wrap=virtual>
More details, like full name, full code, remark, or
description will display here.</textarea>
</td>
</tr>
</table>
</form>
</center>
</body>
</html>
</fmt:bundle>