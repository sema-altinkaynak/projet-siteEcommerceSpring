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

<link href="<%= ctxPath %>/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%= ctxPath %>/css/ie10-viewport-bug-workaround.css"
	rel="stylesheet" />
<link href="<%= ctxPath %>/css/codeBar.css" rel="stylesheet" />
</head>

<body>
	<%@include file="/WEB-INF/views/_header.jsp" %>
	<c:choose>


		<c:when test="${empty delivery}">
			<p class="h3">
				<mark> Error no codeBar. </mark>
			</p>
		</c:when>


		<c:otherwise>
			<h1 class="h1 center">Welcome</h1>
			<h2 class="h2 center">Please go to dock <c:out value="${delivery.dock.id}"/> </h2>
			<img class="displayed" src="<%= ctxPath %>/app/codeBar/codeBarId/${delivery.codeBarId}"/>
		</c:otherwise>

	</c:choose>
</body>
</html>
