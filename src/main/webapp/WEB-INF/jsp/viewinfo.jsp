<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>   
    <link rel="stylesheet" type="text/css" href="/css/side.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300&family=Secular+One&display=swap" rel="stylesheet">

<title>View Info</title>
<style>
body{
    padding:0;
    margin:0;
}
.mainbody{
    margin-left: 40px;
}
hr{
    background-color:black;
    height: 6px;
}
table{
    margin-bottom:10px;
}
.editlink{
    text-decoration: none;
    color:black;
    margin-top:20px;
}
</style>
</head>
<body>
    <jsp:include page="newsidebar.jsp" /> 
    <jsp:include page="newheader.jsp" />
    <div class="mainbody">

        <div class="profileimg">
            <div  style ="display:grid; grid-template-columns: auto; justify-content: center;">
        
                <c:choose>
                    <c:when test="${photo eq null}">
                        <img src="/resource/image/profile.jpg" style="width:100px;" />
                    </c:when>
                    <c:otherwise>
                        <img src= "${photo}" style="width:100px; border-radius: 100px; box-shadow:0px 0px 10px lightgray;" />
                    </c:otherwise>
                </c:choose>   

        </div>
        <div>
            <hr />
            <div>
            <c:forEach var="daos" items="${userobj}">
                <p>RoleName: ${daos.rolename}</p>
            </c:forEach>
               <p>Employee Id: ${eid}</p>
            </div>
        </div>
        </div>

        
        <div class="formsofinfo">
            <h5>Employee Details:</h5></br>
        
            <div style="display:flex; justify-content:center;">
            <table style="border: 3px;">
          
              <tr>
            <td>Name</td>
            <td class="col-md-3">:</td>
            <td>${emprecord[0].name}</td>
             </tr>
             <tr>
                <td>EmailId</td>
                <td class="col-md-3">:</td>
                <td>${emprecord[0].email}</td>
             </tr>
             <tr>
                <td>Phone No.</td>
                <td class="col-md-3">:</td>
                <c:choose>
                    <c:when test="${emprecord[0].phone eq null}">
                        <td></td>
                    </c:when>
                    <c:otherwise>
                  <td>${emprecord[0].phone}</td>
                    </c:otherwise>
                </c:choose>
             </tr>
             <tr>
                <td>Date of Birth</td>
                <td class="col-md-3">:</td>
                <c:choose>
                    <c:when test="${emprecord[0].dob eq null}">
                        <td>yyyy-mm-dd</td>
                    </c:when>
                    <c:otherwise>
                  <td>${emprecord[0].dob}</td>
                    </c:otherwise>
                </c:choose>
             </tr>
             <tr>
                <td>Place</td>
                <td class="col-md-3">:</td>
                <c:choose>
                    <c:when test="${emprecord[0].place eq null}">
                        <td></td>
                    </c:when>
                    <c:otherwise>
                  <td>${emprecord[0].place}</td>
                    </c:otherwise>
                </c:choose>
             </tr>
             <tr>
                <td>Adhar No.</td>
                <td class="col-md-3">:</td>
                <c:choose>
                    <c:when test="${emprecord[0].adharno eq null}">
                        <td></td>
                    </c:when>
                    <c:otherwise>
                  <td>${emprecord[0].adharno}</td>
                    </c:otherwise>
                </c:choose>
             </tr>
        
            </table>
        </div>
        <a class="editlink" href="/Emp/editprofile?id=${emprecord[0].id}"><svg  xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-pen" viewBox="0 0 16 16">
            <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z"/>  
        </svg>
       Edit Profile</a>
        </div>
</div>
<script src="/js/forsideheader.js"></script>
</body>
</html>