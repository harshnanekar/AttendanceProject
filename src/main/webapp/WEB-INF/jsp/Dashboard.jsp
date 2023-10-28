<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <title>Document</title>
    <style>
        :root{
            --sidewidth: 350px;
        }
        .sideBar{
            height: 100vh;
            width: var(--sidewidth);
            background-color: bisque;
            transition: ease-in-out 0.5s;
        } 
        .mainBody{
            height: 100vh;
            width: calc(100% - var(--sidewidth));
            background-color: white;
            position: absolute;
            right: 0;
            transition: ease-in-out 0.5s;
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
        color: navy;
        font-weight:bold;
        
        
        }
       .modules:hover{
        color:white;
        background-color:navy;
        padding:10px;
        border-radius:20px;
        text-decoration:none;
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
        background-color: navy;
        color:white;
        font-weight:bold;
        }
        .attendmark{
        padding:20px;
        font-family:Helvetica;
        font-weight:bold;
        border: 1px white;
        box-shadow: 0 0 10px lightblue;
        width:20%;
        margin-top:30px;
        margin-left:20px;
        border-radius:10px;
        
        }
        .markattend{
        background-color:navy;
        color:white;
        font-weight:bold;
        }
        
        #signoutbutt{
         background-color:navy;
        color:white;
        font-weight:bold;
        }
        .forflex{
        display:flex;
        }
        #attendmessage{
        display:none;
        font-family:Helvetica;
        font-weight:bold;
        color:white;
        background-color: green;
        padding:5px;
        margin-top:30px;
        margin-left:100px;
        height:40px;
        border-radius:5px;
        }
    </style>
</head>
<body style="padding: 0; box-sizing: border-box; margin: 0;">
    <main style="display: flex;"> 
        <div class="sideBar">
<c:forEach var="dao" items="${gkey}" >
<ul style="list-style-type:none;">
<li style="margin-top:40px;">
    <a href="${dao.url}" class="modules" >${dao.moduleinfo}</a>
</li>
</ul>
</c:forEach>
        </div>
        <div class="mainBody">
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
            </div>
            <div class="forflex" >
            <div class="attendmark">
            <span id="newtime" ></span>
          <c:choose>
             <c:when test="${userattendance[0].aid == null}">
               <button id="clickbutt" type="submit" class="btn btn-primary markattend" >Sign In</button>
               </c:when>
        <c:otherwise>
               <button id="signoutbutt" data-outId="${userattendance[0].aid}" class="btn btn-primary">Sign Out</button>
            </c:otherwise>
             </c:choose>
            </div>
            
            <span id="attendmessage"></span>
            </div>
        </div>
    </main>
</body>
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
    
    function setallinfo(){
    let days= ["Sunday" , "Monday" , "Tuesday" ,"Wednesday" , "Thursday" , "Friday" , "Saturday"];
    let month= ["January" , "February" , "March" ,"April" , "May" , "June" , "July" ,"August" ,"September",
    	"October" , "November" , "December"];
const a=new Date();
var setday;
var setmonth; 

let gday=a.getDay();
outer: for(i=0;i < days.length;i++){
    if(gday == i){
     setday= days[i];
     break outer;
    }
}

let gmon=a.getMonth();
outer: for(i=0;i < month.length;i++){
    if(gmon == i){
     setmonth= month[i];
     break outer;
    }
}

let hr= a.getHours();
let min= a.getMinutes();
let sec= a.getSeconds();

let getdate= a.getDate();
let year= a.getFullYear();

console.log(hr , min , sec , setday);

document.getElementById("newtime").innerHTML = `<p> \${getdate} \${setmonth} \${year} </br>
	                                            \${setday} </br>
	                                            \${hr} : \${min} : \${sec} </p>`;

    }
   
     setInterval(setallinfo,1000);
     setallinfo();
     
     document.getElementById("clickbutt")?.addEventListener("click",callclickbutt);
     
     function callclickbutt(){
    	
    	 callapi('/EmpCtrl/addattendance','GET').then(responseData => {
    		
    		 
    		 if(responseData.attendance === "success"){
                window.location.reload();
    			 console.log(responseData.attendance);
    		
    			 setTimeout(calltime,4000);
            	 
    		 }
    	 })
    	 
     }
     
    function calltime(){
    	 document.getElementById("attendmessage").style.display="none";
    	 document.getElementById("attendmessage").innerText=" ";
     }
     
     function callapi(url,method){
    	 
    	 return new Promise((resolve,reject) => {
    	 const a={
    			 method: method,
    			 headers:{
    				 'Accept':'appilication/json'
    			 },
    	 }
    	 fetch(url,a)
    	 .then(response => {
    		 if(!response.ok){
    			throw new Error("Error occrured"); 
    		 }
    		 return response.json();
    	 })
    	 .then(response =>{
    		 resolve(response);
    	 })
    	 .catch(error => {
    		 reject(error);
    	 })
    	
    	 });
     }
    
     document.getElementById("signoutbutt")?.addEventListener("click",function(){
    	 
    	 console.log("Signout button called");
    	 
 	     var signdata= this.getAttribute("data-outId");
 	     console.log("Data" , signdata);
    	 
    	 var obj={
    			 "aid": signdata,
    	 }
    	  callsignout('/EmpCtrl/signout','POST',obj).then(responsedata =>{
    		if(responsedata.signout === "signoutted"){

    			 setTimeout(calltime,4000);
                window.location.reload();
            }
    	 }) 
     });
     
     function callsignout(url,method,obj){
    	 return new Promise((resolve,reject)=>{
    	 const a= {
          method : method,
          headers:{
        	  'Content-Type':'application/json'
          },
          body:obj ? JSON.stringify(obj) : undefined,
    	 }
    	 
    	 fetch(url,a)
    	 .then( response =>{
    		 if(!response.ok){
    			 throw new Error("Error Occured");
    		 }
    		 return response.json();
    	 })
    	 .then(data => {
    		 resolve(data);
    		 
    	 })
    	 .catch(error => {
    		 reject(error);
    	 })
    	 });
     }
     
     document.getElementById("logoutbutt").addEventListener("click", ()=>{
       console.log("logout button called");

       callapi('/EmpCtrl/logout','GET').then(responseData =>{
        if(responseData.logout == "success"){
            window.location = "/Emp/logout" ;
        }
         
       });
     });
     
</script>
</html>






