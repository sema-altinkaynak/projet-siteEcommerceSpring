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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
			  rel="stylesheet" 
		      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" 
			  crossorigin="anonymous"/>
<link href="<%=ctxPath%>/css/ie10-viewport-bug-workaround.css"
	rel="stylesheet" />
<title>Hello !</title>

</head>

<body>
<%@include file="/WEB-INF/views/_header.jsp" %>
	<main class="container">
		<section class="section">
			<div class="col-lg-12">
				<h1>Commands</h1>
				<c:choose>

					<c:when test="${empty commands}">
						<p class="h3">
							<mark> No commands</mark>
						</p>
					</c:when>


					<c:otherwise>
						<ul class="list-group">
							<c:forEach items="${commands}" var="command">
								<li class="list-group-item"><span> Command Id :
										${command.id}<br> Command Status : ${command.status}<br>
								</span>
									<div class="row">		
										<div>
										<c:choose>
											<c:when test="${empty command.employeeLogin}">
												<form class="form-inline" action="select" method=POST>
													<div class="col-md-1" style="margin-left:-7px;">Employee:</div>
													<div class="col-md-1">
														<select class="btn btn-primary" name="employe" id="employe-select">
															<c:forEach items="${users}" var="user">
																<option value="${user.login}">${user.login}</option>
															</c:forEach>
														</select> <input id="command" name="command" value="${command.id }"
															type="hidden">
													</div>
													<div class="col-md-1">
														<button style="width: auto;"
															class="btn btn-primary btn-block" type="submit">Select</button>
													</div>
												</form>
											</c:when>
											<c:otherwise>
											<div class="col-md-1" style="margin-left:-7px;"><span>Employee:</span><span>${command.employeeLogin}</span></div>
											</c:otherwise>
										</c:choose>
										</div>
									</div></li>

							</c:forEach>
						</ul>
					</c:otherwise>

				</c:choose>
			</div>
		</section>
	</main>


</body>
</html>