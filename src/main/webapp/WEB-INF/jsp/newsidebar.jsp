<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<div id="asides">
    <ul style="list-style-type:none;">
    <c:forEach var="dao" items="${gkey}" >
        <li style="padding-top:40px;">
            <a href="${dao.url}" class="modules" >${dao.moduleinfo}</a>
        </li>
    </c:forEach>
</ul>
    </div>