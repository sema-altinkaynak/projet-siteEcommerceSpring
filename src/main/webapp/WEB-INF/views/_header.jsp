<!DOCTYPE html>
<%@page import="drive.model.Dock"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<% String ctxtPath = request.getContextPath(); %>
	
<nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Retrait</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link" href="<%= ctxtPath %>/app/docks">Docks</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= ctxtPath %>/app/borne/user.html">Borne</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= ctxtPath %>/app/borne/all.html">Deliveries</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= ctxtPath %>/app/codeBar/deliveryInfoRequest.html">Request</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= ctxtPath %>/app/statistic">Statistics</a>
        </li>
      </ul>
    </div>
  </div>
</nav>	