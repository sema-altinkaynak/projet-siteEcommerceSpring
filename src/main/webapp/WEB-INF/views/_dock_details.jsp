<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<p class="mx-5 text-muted" style="font-size:15px;" >
	<c:choose>	 
	      <c:when test="${errorMessage != null}"> ${errorMessage} </c:when>
	      
	      <c:otherwise>
		      Dock (id=${dockDetails.id}, x-position=${dockDetails.x}, y-position=${dockDetails.y}, length=${dockDetails.length}, width=${dockDetails.width})  
	      </c:otherwise>
	</c:choose>
</p>