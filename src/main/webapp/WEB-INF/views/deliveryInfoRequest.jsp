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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
			  rel="stylesheet" 
		      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" 
			  crossorigin="anonymous"/>
<link href="<%=ctxPath%>/css/ie10-viewport-bug-workaround.css"
	rel="stylesheet" />
<link href="<%=ctxPath%>/css/codeBar.css" rel="stylesheet" />
<%@ page import="drive.model.CommandStatus"%>
</head>
<body>
<%@include file="/WEB-INF/views/_header.jsp" %>
	<main class="container">
		<section class="section">
			<div class="col-lg-12">
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
						<label for="code">Code Bar Identifier :</label> <input
							class="center" type="text" id="code" name="code" required
							minlength="12" maxlength="12">
						<button class="btn btn-primary btn-block" type="submit">Send</button>
					</form>
				</div>
			</div>
		</section>
	</main>
</body>
</html>
