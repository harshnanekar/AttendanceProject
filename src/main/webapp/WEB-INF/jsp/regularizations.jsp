<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
import="java.util.List" %> <%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link
    rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
  />
  <link
  href="https://fonts.googleapis.com/css2?family=Secular+One&display=swap"
  rel="stylesheet"
/>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link
href="https://fonts.googleapis.com/css2?family=Secular+One&display=swap"
rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/side.css" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<style>
      tr{
            font-family: "Secular One", sans-serif;
            font-size:20px;
            color:navy;
         
        }
        rect , line{
            color:navy;
        }
       
       
</style>
</head>
<body style="padding: 0; margin: 0">
    <jsp:include page="newsidebar.jsp" />
    <jsp:include page="newheader.jsp" />
 <main id="main">
    <div  class="table-responsive">
        <table class="table table-hover table-bordered">
            <thead id="theads">
                <tr>
                
                    <th class="text-center" scope="col">Date</th>
                    <th class="text-center" scope="col">Reason</th>
                    <th class="text-center" scope="col">Status</th>
                    <th class="text-center" scope="col">Start Time</th>
                    <th class="text-center" scope="col">End Time</th>
                </tr>
            </thead>
            <tbody>
                  
              
                <c:forEach var = "daos" items = "${emprecord}" >
                  
                <tr>
            
                    <td>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                        <span class="table-inner-text">${daos.date}</span>
                    </td>
                    <td class="text-center">${daos.reason}</td>
                    <td class="text-center">
                        <c:if test="${daos.status eq 'Pending'}">
                        <span  style="padding:10px;"  class="badge badge-light-warning">${daos.status}</span>
                    </c:if>
                    <c:if test="${daos.status eq 'Completed'}">
                        <span  style="padding:10px;"  class="badge badge-light-success">${daos.status}</span>
                    </c:if>
                    <c:if test="${daos.status eq 'Rejected'}">
                        <span  style="padding:10px;" class="badge badge-light-danger">${daos.status}</span>
                    </c:if>
                    </td>
                    <td>${daos.starttime}</td>
                    <td>${daos.endtime}</td>
                </tr>
         
                </c:forEach>
        
            </tr>
         
            </tbody>
        </table>
       
    </div>


    </main>
    
 <script src="/js/forsideheader.js"></script>
</body>
</html>