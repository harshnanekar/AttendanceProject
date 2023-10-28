<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="ISO-8859-1">
<title>header</title>

<style>
    .header{
                height: 100px;
                background-color: navy;
               margin-left:350px;  
            }
            
        .modal.right .modal-dialog {
            position: fixed;
            top: 0;
            right: 0;
            margin-right: 0;
            width:20%;
            height:20%;
        }
        
        .btcolor{
        background-color:navy;
        border:0;
       position: absolute;
            top: 10px;
            right: 10px;
        }
        .empdetails{
        font-family:sans-serif;
        font-weight:bold;
        font-style:italic;
        font-size:18px;
        }
        .closebt{
        width:100%;
        background-color:navy;
        color:white;
        font-weight:bold;
        }
        .ename{
        font-weight:bold;
        font-family:sans-serif;
        font-size:18px;
        color:white;
        }
           
</style>
</head>
<body>
<div class="header" >
    <button style="margin-top: 35px;" class="aside">&#9776;</button>
    <div class="profile" >

<button style="float:right; top:0; margin-right:20px;" type="button" class="btn btn-primary btcolor" data-toggle="modal" data-target="#userDetailsModal">
<img src="/resource/image/profile.jpg" style="width:80px;" />
</button>

<div class="modal right fade" id="userDetailsModal" tabindex="-1" role="dialog" aria-labelledby="userDetailsModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-vertical" role="document">
<div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="userDetailsModalLabel">Employee Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    
    
    <div class="modal-body">
        <!-- User details content goes here -->
        <c:forEach  var="daos" items="${userobj}">
        <p class="empdetails">Employee Name: ${daos.name}</br></br>
        Role: ${daos.rolename}</p>
        </c:forEach>
        
        
        <!-- Add more user details here -->
    </div>
    <div class="modal-footer">
        <button type="button" id="logoutbutt" class="btn btn-secondary closebt" data-dismiss="modal">Logout</button>
    </div>
</div>
</div>
</div>
</div>

<div class="btn-group">
    <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
      Left-aligned but right aligned when large screen
    </button>
    <ul class="dropdown-menu dropdown-menu-lg-end">
      <li><button class="dropdown-item" type="button">Action</button></li>
      <li><button class="dropdown-item" type="button">Another action</button></li>
      <li><button class="dropdown-item" type="button">Something else here</button></li>
    </ul>
  </div>
    </div>

   

</body>
</html>