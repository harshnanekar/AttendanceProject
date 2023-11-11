<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
import="java.util.List" %> <%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ApproveEmp</title>
    <style>
        .flexses{
            margin-top:20px;
            display:flex;
           gap:30px;
            flex-wrap:wrap;
        }
        #flexproperty{
            box-sizing:border-box;
            display:flex;
            justify-content:center;
            padding:20px;
            font-family: 'Secular One', 'sans-serif';
            font-size:25px;
            color:navy;
            width: 30%;
            box-shadow:0px 0px 10px lightblue;
            border-radius:20px;
          
        }
        .links{
            margin-left:20px;
            color: navy;
            text-decoration:none;
        }
    </style>
</head>
<body style="padding: 0; margin: 0">
    <jsp:include page="newsidebar.jsp" />
    <jsp:include page="newheader.jsp" />
 <main id="main">
<div class="flexses">
    <div id="flexproperty">
        <img style="width: 80px;" src="/resource/image/approve.png" /> <a class="links" href="/Emp/approving">Approved Employees</a>
    </div>
    <div id="flexproperty">
        <img style="width: 80px;" src="/resource/image/rejected.png" /> <a class="links" href="/Emp/rejected">Rejected Employees</a>
    </div>
    <div id="flexproperty">
        <img style="width: 80px;" src="/resource/image/clock.png" /> <a class="links" href="/Emp/pending">Pending Employees</a>
    </div>
</div>
    </main>

</body>
<script src="/js/forsideheader.js"></script>
</html>