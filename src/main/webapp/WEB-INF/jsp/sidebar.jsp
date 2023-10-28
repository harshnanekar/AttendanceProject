<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            :root{
                --sidewidth: 350px;
            }
            .sideBar{
                height: 100vh;
                width: var(--sidewidth);
                background-color: bisque;
                transition: ease-in-out 1s;
            } 
            .mainBody{
                height: 100vh;
                width: calc(100% - var(--sidewidth));
                background-color: white;
                position: absolute;
                right: 0;
                transition: ease-in-out 1s;
            }
            .header{
                height: 100px;
                background-color: navy;
            }
            .ename{
        font-weight:bold;
        font-family:sans-serif;
        font-size:18px;
        color:white;
        }
      
        .modules{
        text-decoration:none;
        font-family:sans-serif;
        font-size:20px;
        color:navy;
        font-weight:bold;
        
        
        }
       .modules:hover{
        color:white;
        background-color:navy;
        padding:10px;
        border-radius:20px;
        text-decoration:none;
        }
       

</style>

    </head>
    <body>
 
        <main  style="display:flex;" >
        <div class="sideBar">
            <c:forEach var="dao" items="${gkey}" >
            <ul style="list-style-type:none;">
            <li style="margin-top:40px;">
                
                <a href="${dao.url}" class="modules" >${dao.moduleinfo}</a>
            
            </li>
            </ul>
            </c:forEach>
                    </div>
                   
</main>


<script>

document.querySelector('.aside').addEventListener('click',function(){
        var style = getComputedStyle(document.body);
        let asideVAlue = style.getPropertyValue('--sidewidth');
        console.log(asideVAlue);
        if(asideVAlue == '350px'){

            document.documentElement.style.setProperty("--sidewidth", "0px");

        }else{
            document.documentElement.style.setProperty("--sidewidth", "350px");
        }
    })

</script>
</body>
</html>