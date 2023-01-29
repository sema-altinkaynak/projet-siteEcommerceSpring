<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<% String ctxPath = request.getContextPath(); %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Top navbar example · Bootstrap v5.2</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-static/">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
    			  rel="stylesheet"
    		      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
    			  crossorigin="anonymous"/>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


            
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
    </style>


    <!-- Custom styles for this template -->
    <link href="navbar-top.css" rel="stylesheet">
  </head>
  <body>
  	<%@include file="/WEB-INF/views/_header.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<main class="container">
            <section class="section">
              <div class="row">
                <div class="col-lg-12">
                  <div class="container">
                    <div class="row">
                  <form id="send" action="#" method="post">
                    <div class="row form-group">
                      <div class="col">
                        <label for="date" class="col-sm-1 col-form-label">Date</label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="datepicker">
                                <input type="text" class="form-control" id="dateP" 
                                
                                value="<fmt:formatDate pattern = 'dd/MM/yyyy'
                                value = '${dateChosen}' />"
                                > 
                                <span class="input-group-append">
                                    <span class="input-group-text bg-white d-block">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                </span>
                            </div>
                        </div>
                        </div>
                        <div class="col">
                            <p>Le nombre total de commande livrée est de ${total}</p>
                            <p>Le chiffre d'affaire du jour est de ${amount}</p>
                        </div>
                    </div>
                </form>
                </div>
                </div>
              </div>
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">Nombre de commande livrées par heure</h5>
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">Heure</th>
                            <th scope="col">Nombre de commande livrée</th>
                          </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${del}" var="var">
                            <tr>
                                  <th scope="col">${var[0]}</th>
                                  <td> ${var[1]}</td>
                            </tr>
                         </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>

                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">Nombre de commande livrées par employée et par heure</h5>
                      <c:choose>
                        <c:when test="${empty empl }">
                        Aucune statistique.
                        </c:when>
                      <c:otherwise>
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">Employée</th>
                            <th scope="col">Heure</th>
                            <th scope="col">Nombre de commande livrée</th>
                          </tr>
                        </thead>

                        <tbody>
                        
                        	<c:forEach items="${empl}" var="var">
                            <tr>
                                  <th scope="col">${var[0]}</th>
                                  <td> ${var[1]}</td>
                                  <td> ${var[2]}</td>
                            </tr>
                         </c:forEach>
                        </c:otherwise>
                         </c:choose>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  </div>
                </div>
              </div>


            </section>
          </main>

        

    
        <script type="text/javascript">
          $(function() {
              $('#datepicker').datepicker(
                {
                  format: 'dd/mm/yyyy',
                  endDate: 'now',
                  
              });
              $('#datepicker').on('changeDate',function(){
                var element = $("#dateP").val();
                $('#send').attr("action","/sra1/app/statistic?date="+ element);
                $('#send').submit();
                
              })
          });
      </script>
      

</body></html>