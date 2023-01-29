<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">

<%
String ctxPath = request.getContextPath();
%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>codeBar Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
<link href="<%=ctxPath%>/css/ie10-viewport-bug-workaround.css"
	rel="stylesheet" />
<link href="<%=ctxPath%>/css/codeBar.css" rel="stylesheet" />
<%@ page import="drive.model.CommandStatus"%>
</head>
<body>
	<%@include file="/WEB-INF/views/_header.jsp"%>
	<h1>Delivery Info</h1>
	<h3 class="h3">
		Command id :
		<c:out value="${delivery.commandId}" />
	</h3>
	<h3 class="h3">
		dock :
		<c:out value="${delivery.dock.id}" />
	</h3>
	<h3 class="h3">
		Client :
		<c:out value="${command.userID}" />
	</h3>
	<h3 class="h3">
		Command status :
		<c:choose>
			<c:when test="${delivery.status != CommandStatus.DELIVERED}">
			        Not Delivered 
			        
	
	</c:when>
			<c:otherwise>
				    	Delivered
	</c:otherwise>
		</c:choose>
	</h3>

	<c:if test="${empty delivery.employeeLogin}">
			<div class = "alert alert-danger"><h3 class="h3"> Can't deliver while no employee takes care of this delivery</h3></div>
	</c:if>
	<c:if test="${delivery.status != CommandStatus.DELIVERED && !empty delivery.employeeLogin}">
			<form action="<%= ctxPath %>/app/codeBar/validate/${delivery.id}"
			method=Post>
			<input type="submit" value="Validate delivery" />
		</form>
	</c:if>


</body>
</html>
