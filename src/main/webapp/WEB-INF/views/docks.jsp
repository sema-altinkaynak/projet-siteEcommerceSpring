<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

	<% 
	String ctxPath = request.getContextPath(); 
	%>
	
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Dock Management</title>
		
		
		<link href="<%= ctxPath %>/css/ie10-viewport-bug-workaround.css" rel="stylesheet"/>
		<link href="<%= ctxPath %>/css/docks.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
			  rel="stylesheet" 
		      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" 
			  crossorigin="anonymous"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
		
		
		
		<script src="https://code.jquery.com/jquery-3.6.1.min.js"
		  integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
		  crossorigin="anonymous"></script>
		
		<script src="<%= ctxPath %>/js/dock.js" type="text/javascript"></script>
		  
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		        
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" 
		        integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" 
		        crossorigin="anonymous"></script>
		
	</head>
	
	<body>
	    <%@include file="/WEB-INF/views/_header.jsp" %>
		<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
			<symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
				<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
			</symbol>
			<symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
				<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
			</symbol>
			<symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
				<path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
			</symbol>
		</svg>
			
		<h1 class="h1 display-2 mx-1 my-5">List of available docks</h1>	
         
        <a class="btn btn-primary my-3 mx-2" href="<%=ctxPath%>/app/docks/add.html"> 
        	<i class="bi bi-plus"></i> Add dock 
        </a>
        
       	<button id="show-view-btn" class="btn btn-primary my-3 mx-2" > 
       		<i id="eye" class="bi bi-eye"></i> 
       		<span id="show-view-text">Show view</span> 
       	</button>
        
        <div id="show-view-plane" class="my-3 mx-5">
             <p id="details" class="mx-5 text-muted"></p>
        </div> 
		
		<div id="deleted-dock-popup" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="alert alert-success modal-dialog">
			    <div class="modal-content">
			      <div id="delete-dock-msg" class="modal-body">
			          <!-- This part is replaced with an ajax call -->
			      </div>
			    </div>
			  </div>
		</div>   
		
		<c:choose>	 
		      
		   <c:when test="${empty docks}"> 
		     <div class="mx-2 my-5 alert alert-warning d-flex align-items-cente" role="alert"> 
		     	<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:">
		     		<use xlink:href="#exclamation-triangle-fill"/>
		     	</svg>
		   		 <div > <strong>No available dock !</strong> </div>
		   	 </div>  
		   </c:when> 
		   
		   <c:otherwise>
		   	 <div class="table-responsive mx-2">   
		       <table id="docks-list" class="table table-responsive table-striped table-hover table-condensed">
		       		<thead>
						<tr class="table-primary">
							<th scope="col">Index</th>
						    <th scope="col">Dock-ID</th> 
						    <th scope="col">X-Position</th>
						    <th scope="col">Y-Position</th>   
						    <th scope="col">Width</th>
						    <th scope="col">Length</th>
						    <th scope="col">Is free</th>
						    <th scope="col"></th>
						    <th scope="col"></th>
						</tr>
					</thead>
				   <tbody id="container" class="table-group-divider">
				       <c:forEach items="${docks}" var="dock">		
								<tr id="row-${dock.id}" class="table-light">
									<th scope="row">${docks.indexOf(dock) + 1}</th>
								    <td>${dock.id}</td>
								    <td>${dock.x}</td>
								    <td>${dock.y}</td>
								    <td>${dock.width}</td>
								    <td>${dock.length}</td> 						      
								    <td> 
								    	<c:choose>
								    		<c:when test="${dock.free}">
								    			<i id="is-free" class="bi bi-check-circle-fill"></i>
								    		</c:when>
								    		<c:otherwise>
								    			<i id="is-not-free" class="bi bi-x-circle-fill"></i>
								    		</c:otherwise>
								    	</c:choose>  
								    </td>
								    <td> <a class="link-primary btn btn-* pe-auto" href="docks/${dock.id}/update"> update </a> </td>
								    <td> 
								         <span class="delete-btn link-danger btn btn-* pe-auto " 
								               data-ref="${dock.id}" 
								               data-bs-toggle="modal" 
								               data-bs-target="#deleted-dock-popup"
								               > delete 
								        </span> 
								    </td>
								</tr>			
				       </c:forEach>
			       </tbody>
		         </table>
		       </div>
	        </c:otherwise>
		   
		</c:choose>
		
		
	</body>
	
</html>
