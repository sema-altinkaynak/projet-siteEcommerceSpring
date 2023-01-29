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
			  rel="stylesheet" 
		      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" 
			  crossorigin="anonymous"/>
		<link href="<%= ctxPath %>/css/ie10-viewport-bug-workaround.css" rel="stylesheet"/>
		<link href="<%= ctxPath %>/css/docks.css" rel="stylesheet"/>
	</head>
	
	<body class="mx-5">
		<%@include file="/WEB-INF/views/_header.jsp" %> 
		
		 <h1 class="h1 display-2 mx-4 my-5">Add a dock</h1>
		 <form:form cssClass="mx-4" method="POST" action="submit" modelAttribute="dock">
		 	 <form:input type="hidden" path="id" /> <br/>
		 	 
		 	 <label for="x" class="col-sm-2 col-form-label"> X-Position <span class="required-symb">*</span> </label> 
			 <div class="col-4">
			 	<form:input cssClass="form-control" id="x" placeholder="X-Position .." min="1" type="number" path="x" required="required" /> 
			 </div>
			 
			 <label for="y" class="col-sm-2 col-form-label"> Y-Position<span class="required-symb">*</span> </label> 
			 <div class="col-4">
			 	<form:input cssClass="form-control" id="y" placeholder="Y-Position ..." min="1" type="number" path="y" required="required" /> 
			 </div>
			 
			 <label for="width" class="col-sm-2 col-form-label"> Width (in meters)<span class="required-symb">*</span> </label> 
			 <div class="col-4">
			 	<form:input cssClass="form-control" id="width" placeholder="Width ..." min="1" type="number" path="width" required="required" /> 		 	
			 </div>
			 
			 <label for="length" class="col-sm-2 col-form-label"> Length (in meters)<span class="required-symb">*</span> </label> 
			 <div class="col-4">
			 	<form:input id="length" cssClass="form-control" placeholder="Length ..." min="1" type="number" path="length" required="required" /> 
			 </div>		 
		 
		     <div class="row mb-3">
			    <div class="col-sm-5">
			      <div class="form-check">
			        <form:checkbox id="free" cssClass="form-check-input" path="free" value="checked"/>
			        <label class="form-check-label" for="free">
			          Is free ?
			        </label>
			      </div>
			    </div>
			</div>
					
			 <div class="col-4">
			 	<button class="btn btn-primary" type="submit"> Add dock </button>
			 </div>	
			<br>
			<a class="btn btn-primary" href="<%= ctxPath %>/app/docks">Show docks</a> 
		 </form:form>
		 
		 <c:if test="${newDock != null}">
		 	<div class="alert alert-success my-5 mx-4" style="width:32%;"> 
				<p> ${newDock} <strong>successfully</strong> ! </p>
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
		 
		   
	</body>
</html> 