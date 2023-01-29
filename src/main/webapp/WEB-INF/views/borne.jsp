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

<title>Hello !</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
			  rel="stylesheet" />
<link href="<%=ctxPath%>/css/ie10-viewport-bug-workaround.css"
	rel="stylesheet" />
<link href="<%= ctxPath %>/css/codeBar.css" rel="stylesheet" />
</head>

<body>
<%@include file="/WEB-INF/views/_header.jsp" %>
<main class="container">
	
	<%
	if (request.getParameter("error") != null) {
	%>
	<div class="alert alert-danger" role="alert">
		<%=request.getParameter("error")%>
	</div>
	<%
	}
	%>
	<div class="form">
		<form action='submit' method=post>
				<label for="inputClient">Client ID</label> 
				<input name="id" id="id" required="" autofocus="" type="text">
				<button class="btn btn-primary btn-block" type="submit">Confirm !</button>
		</form>
	</div>
</main>










</body>
</html>