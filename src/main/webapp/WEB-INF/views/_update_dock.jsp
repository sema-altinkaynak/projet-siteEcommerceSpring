<!DOCTYPE html>
<%@page import="drive.model.Dock"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html lang="en">
	<% String ctxPath = request.getContextPath(); %>
	
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Dock Management</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
			  rel="stylesheet" />
		<link href="<%= ctxPath %>/css/ie10-viewport-bug-workaround.css" rel="stylesheet"/>
		<link href="<%= ctxPath %>/css/docks.css" rel="stylesheet"/>
	</head>
	
	<body class="position-absolute top-50 start-50 translate-middle">
		<%@include file="/WEB-INF/views/_header.jsp" %>
		<c:choose>
			<c:when test="${unavailableDock != null}">
				<div class="alert alert-danger">${unavailableDock}</div>
			</c:when>
			<c:otherwise>
				 <h1 class="h1 display-2 mx-1 my-5">Dock update</h1>
				 <form:form cssClass="mx-4" method="POST" action="confirmUpdate" modelAttribute="dock" >
				 	 
				 	 <label for="id" class="col-sm-2 col-form-label"> ID </label> <br>
					 <div class="col-4">
				 	 	<form:input cssClass="form-control" disabled="true" path="id" /> 
			 		 </div>
			 		 
			 		 <label for="x" class="col-sm-5 col-form-label"> X-Position(Old X : ${toUpdate.x}) </label> <br>
					 <div class="col-4">
					 	<form:input id="x" class="form-control"  min="0" type="number" path="x" value="${toUpdate.x}"/>   
					 </div>
					 
					 <label for="y" class="col-sm-10 col-form-label"> Y-Position(Old Y : ${toUpdate.y}) </label> <br>
					 <div class="col-4">
					 	<form:input id="y" class="form-control"  min="0" type="number" path="y" value="${toUpdate.y}"/>   
					 </div>
			 		  
					 <label for="length" class="col-form-label"> Length(Old length : ${toUpdate.length}) </label> <br>
					 <div class="col-4">
					 	<form:input id="length" cssClass="form-control"  min="1" value="${toUpdate.length}" type="number" path="length" />  
					 </div>
		
			 
					 <label for="width" class="col-form-label"> Width(Old width : ${toUpdate.width}) </label> <br>
					 <div class="col-4">
					 	<form:input id="width" cssClass="form-control" min="1" value="${toUpdate.width}"  type="number" path="width" /> 
					 </div>
		
					 
					 <div class="row mb-3">
					    <div class="col-sm-5">
					      <div class="form-check">
					        <form:checkbox id="free" cssClass="form-check-input" path="free" value="${dock.free}" />
					        <label class="form-check-label" for="free">
					          Is free ?
					        </label>
					      </div>
					    </div>
					</div>
		  
					 <button class="btn btn-primary" type="submit"> Update </button> <br>
					 <a class="btn btn-primary my-2" href="<%= ctxPath %>/app/docks">Show docks</a>
				 </form:form>	 
				 
				 <c:if test="${updateSuccess != null}">
				 	<div class="alert alert-success my-3 mx-4"> 
						<p> The dock ${toUpdate.id} <strong>${updateSuccess}</strong> !</p>						
					</div>	
				 </c:if>
				 
				 <c:if test="${fieldError != null}">
			 		<div class="alert alert-danger my-3 mx-4" style="width:32%;"> 
						<p> ${fieldError} </p>
					</div>
			 	</c:if>
			 	
				 <c:if test="${errorCollision != null && dockCollision != null}"> 
					<div class="alert alert-danger my-3 mx-4"> 
						${errorCollision}
					</div>
					<span class="cannotUpdate link-primary btn btn-link mx-4" style="font-size:12px;" data-ref="${dockCollision}" >
						Click here to show the according dock
					</span> 
					<div id="problemDock"> 
						<!-- This part is replaced with an ajax call -->
					</div>
				 </c:if>
	 
				 <c:if test="${errorMessage != null}"> 
					<div class="alert alert-danger my-3 mx-4" style="width:32%;"> 
						<p> ${errorMessage} </p>
					</div>
				 </c:if>
				 
				 <c:if test="${fieldError != null}">
			 		<div class="alert alert-danger my-3 mx-4" style="width:32%;"> 
						<p> ${fieldError} </p>
					</div>
			 	</c:if>
				 
			</c:otherwise>
		</c:choose>	
	</body>
	
	
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"
		  integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
		  crossorigin="anonymous"></script>
	<script src="<%= ctxPath %>/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%= ctxPath %>/js/dock.js" type="text/javascript"></script>
</html> 