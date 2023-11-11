<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
import="java.util.List" %> <%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link
    rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
  />
  <link
  href="https://fonts.googleapis.com/css2?family=Secular+One&display=swap"
  rel="stylesheet"
/>
<link rel="preconnect" href="https://fonts.googleapis.com" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/side.css" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ApproveEmp</title>

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
    <div id="formessagebox"></div>
    <div  class="table-responsive">
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th class="checkbox-area" scope="col">Approve
                       <div class="form-check form-check-primary">
                           
                        </div> 
                    </th>
                   <th scope="col">Employee Id</th>
                    <th scope="col">Date</th>
                    <th class="text-center" scope="col">Reason</th>
                    <th class="text-center" scope="col">Status</th>
                    <th class="text-center" scope="col">Start Time</th>
                    <th class="text-center" scope="col">End Time</th>
                </tr>
            </thead>
            <tbody>
                  
              
                <c:forEach var = "daos" items = "${emprecord}" >
                  
                <tr>
                    <td id="chbox">
                        <div class="form-check form-check-primary">
                            <input class="form-check-input hover_child" type="checkbox" >
                        </div>
                    </td>
                    <td>${daos.empid}</td>
                    <td>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                        <span class="table-inner-text">${daos.date}</span>
                    </td>
                    <td class="text-center">${daos.reason}</td>
                    <td class="text-center">
                        <span class="badge badge-light-success">${daos.status}</span>
                    </td>
                    <td>${daos.starttime}</td>
                    <td>${daos.endtime}</td>
                </tr>
         
                </c:forEach>
        
            </tr>
         
            </tbody>
        </table>
        <button id="clickbutt" class="btn btn-primary">Approve</button>
        <button id="rejectbutt" class="btn btn-primary">Reject</button>
    </div>


 </main>
 <script src="/js/forsideheader.js"></script>
<script>

    document.getElementById("rejectbutt").addEventListener("click",()=>{
        var rejectarray= [];

        var data= document.querySelectorAll("tr");
     console.log(data);
    for(let i=0;i < data.length;i++){
        if(i > 0){
     var tddata = data[i].querySelectorAll("td");
     var chbox = tddata[0].querySelector("input[type='checkbox']");

    if(chbox && chbox.checked){
        var empid= tddata[1].innerText;
        var dates=tddata[2].innerText;
        var reason= tddata[3].innerText;
        var status = tddata[4].innerText;
        var sttime= tddata[5].innerText;
        var edtime= tddata[6].innerText;

        var obj={
            empid,dates,reason,status,sttime,edtime
        }
   
        rejectarray.push(obj);
        console.log(empid , dates , reason , status , sttime , edtime);
    }

        }
    }
    sendtabledata('/EmpCtrl/rejectdata','POST',rejectarray).then(responseData => {
            if(responseData.rejectemp == 'valid'){
                window.location.reload();
            }

    });


    });


 
 document.getElementById("clickbutt").addEventListener("click",()=>{
     var objarray=[];
   
    var data= document.querySelectorAll("tr");
     console.log(data);
    for(let i=0;i < data.length;i++){
        if(i > 0){
     var tddata = data[i].querySelectorAll("td");
     var chbox = tddata[0].querySelector("input[type='checkbox']");

    if(chbox && chbox.checked){
        var empid= tddata[1].innerText;
        var dates=tddata[2].innerText;
        var reason= tddata[3].innerText;
        var status = tddata[4].innerText;
        var sttime= tddata[5].innerText;
        var edtime= tddata[6].innerText;

        var obj={
            empid,dates,reason,status,sttime,edtime
        }
   
        objarray.push(obj);
        console.log(empid , dates , reason , status , sttime , edtime);
    }

        }
    }

    console.log(obj);
    sendtabledata('/EmpCtrl/approveddata','POST',objarray).then(responseData => {
              console.log(responseData.approved);
              if(responseData.approved == "success"){
                window.location.reload();
              }
              if(responseData.approved == "error"){
                window.location.href="/Emp/error";
              }
            });
    

//     async function sendtabledata(url,method,obj){

// try{
//   const a={
//     method:method || 'GET',
//     headers:{
//         'Content-Type':'application/json'
//     },
//     body: obj ? JSON.stringify(obj) :undefined,
//   }

//   const response= await fetch(url,a);
   
//   if(!response.ok){
//     throw new Error("Error Occured");
//   }

//   const responsedata = await response.json();

//   return responsedata;

// }catch(error){
//    console.log(error.message());
// }
// }
       

 });

 

 async function sendtabledata(url,method,obj){

try{
  const a={
    method:method || 'GET',
    headers:{
        'Content-Type':'application/json'
    },
    body: obj ? JSON.stringify(obj) :undefined,
  }

  const response= await fetch(url,a);
   
  if(!response.ok){
    throw new Error("Error Occured");
  }

  const responsedata = await response.json();

  return responsedata;

}catch(error){
   console.log(error.message());
}
}
  

</script>
</body>
</html>