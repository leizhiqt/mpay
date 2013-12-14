<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script language="javascript">
	function times(){
		var datetime=new Date()
		a=datetime.getFullYear();
		b=datetime.getMonth()+1;
		c=datetime.getDate();
		e=datetime.getHours();
		f=datetime.getMinutes();
		g=datetime.getSeconds();
		h=datetime.getDay();
		i=Array("日","一","二","三","四","五","六");
		if (e<10){ e="0"+e;}
		if (f<10){f="0"+f;}
		if (g<10){ g="0"+g;}
		document.getElementById('time').innerHTML = a+"年"+b+"月"+c+"日 "+e+":"+f+":"+g+" 星期"+i[h]; 
		setTimeout("times()",500);
   }
</script>
</head>

<body>
<form>
<div id="time">
	<script language="javascript">
		times();
	</script>
</div>
</form>
</body>
</html>