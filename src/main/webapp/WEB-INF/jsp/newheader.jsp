<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

        <head>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        </head>

        <header>
            <div class="header">
                <button style="margin-top: 35px;" class="aside">&#9776;</button>
                <div class="profile">

                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle profilebutt" type="button"
                            id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
        <img style="width:50px;" src="/resource/image/profile.jpg" />
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <div class="modal-body">
                                <!-- User details content goes here -->
                                <c:forEach var="daos" items="${userobj}">
                                    <p class="empdetails">Employee Name: ${daos.name}</br></br>
                                        Role: ${daos.rolename}</p>
                                </c:forEach>


                                <!-- Add more user details here -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" id="logoutbutt" class="btn btn-secondary closebt"
                                    data-dismiss="modal">Logout</button>
                            </div>
                        </ul>
                    </div>

                </div>
            </div>
        </header>