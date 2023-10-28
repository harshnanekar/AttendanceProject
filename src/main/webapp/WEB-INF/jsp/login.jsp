<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
.divider:after,
.divider:before {
content: "";
flex: 1;
height: 1px;
background: #eee;
}
#flex{
display:flex;
}
.forms{
background:white;
padding:30px;
margin-top:40%;
border:1px;
box-shadow:4px 4px 4px  rgba(0,0,0,0.2);
}
label{
font-size:18px;
font-family:sans-serif;
font-weight:bold;

}
input{
padding:7px;
margin:10px;
border-radius:10px;
border:0px;
}
#forgot{
font-family:sans-serif;
font-size:15px;
text-decoration:none;
color:purple;
float:right;
font-weight:bold;
margin-top:10px;
}
button{
width:100%;
color:white;
font-weight:bold;
background-color:#0040ff;
padding:8px;
margin-top:20px;
border:0px;
border-radius:10px;
font-size:18px;

}
#message{
font-style:italic;
color:red;
font-size:20px;
font-weight:bold;
margin-top:10px;
margin-bottm:10px;
}
</style>
<meta charset="ISO-8859-1">
<title>LoginDashboard</title>
</head>
<body>
<section class="vh-100">
  <div class="container py-5 h-100">
    <div id="flex" class="row d-flex align-items-center justify-content-center h-100">
      <div class="col-md-8 col-lg-7 col-xl-6">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg"
          class="img-fluid" alt="Phone image">
      </div>
      <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">
        <div class="forms">
        <span id="message" ></span>
          <!-- Email input -->
          <div class="form-outline mb-4">
            <label class="form-label" for="form1Example13">Login-Id:</label>
            <input type="text" id="logid" class="form-control form-control-lg" />
          
          </div>

          <!-- Password input -->
          <div class="form-outline mb-4">
             <label class="form-label" for="form1Example23">Password:</label>
            <input type="password" id="pass" class="form-control form-control-lg" />
          </div>

          <div class="d-flex justify-content-around align-items-center mb-4">
            <!-- Checkbox -->
            <a id="forgot" href="#!">Forgot password?</a>
          </div>
           </br>
          <!-- Submit button -->
          <button id="clickbutt" type="submit" class="btn btn-primary btn-lg btn-block">Login</button>

        </div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">

document.getElementById("clickbutt").addEventListener("click",function(){
	
	var a= document.getElementById("logid").value;
	var b= document.getElementById("pass").value;
	
	var obj={
			"logerid": a,
			"password": b
	}
	
	checkuser('/EmpCtrl/logcheck','POST',obj)
	.then(responseData =>{
		
		if(responseData.auth === "error"){
			window.location.href="/Emp/error";		
		
		}else{
		
		if(responseData.auth === "Valid"){
		
		window.location.href="/Emp/getview";
		console.log("Valid" , responseData);
		document.getElementById("message").innerText =" ";
		}else{
			document.getElementById("message").innerText = responseData.auth;
			console.log( responseData);
		}
		}
	})
});

async function checkuser(url,method,obj){
	
	return new Promise( (resolve,reject) =>{
	const opt={
	method:method || 'GET',
	headers:{
		'Content-Type':'application/json'
	},
	body: obj ? JSON.stringify(obj) :undefined,
	}
	
	fetch(url,opt)
	.then(response => {
		if(!response.ok){
			throw new Error("Error occured");
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



</script>
</body>
</html>