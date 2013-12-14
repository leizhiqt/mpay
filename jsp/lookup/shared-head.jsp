<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.*,java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script language="JavaScript" src="../js/lookup.js"></script>
<script language="JavaScript" src="../js/popConfirm.js"></script>
<style type="text/css">
html,body{
	padding:0 !important;
	padding:100px 0;
	width:100%;
	height:100%;
	overflow:hidden;
	text-align:center;
	font-family: Trebuchet MS, Lucida Sans Unicode, Arial, sans-serif;
	font-size: 18px;
	color: #000000;
}
</style>

<script>
<%! String newValue = null, newUrl = null; %>
<%! String listBy = ""; %>
<%! String startDate = ""; %>
<%! String endDate = ""; %>