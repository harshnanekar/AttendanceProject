<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
#invaliduser{
	display:none;
}
#invalidotp{
	display:none;
}
/* button{
width:100%;
color:white;
font-weight:bold;
background-color:#0040ff;
padding:8px;
margin-top:20px;
border:0px;
border-radius:10px;
font-size:18px;

} */
#message{
font-style:italic;
color:red;
font-size:20px;
font-weight:bold;
margin-top:10px;
margin-bottm:10px;
}
#submitbutt2{
	display:none;
}
#otps{
	display:none;
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
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
			Reset Password
			  </button>
			  
			  <!-- Modal -->
			  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				  <div class="modal-content">
					<div class="modal-header">
					  <h5 class="modal-title" id="exampleModalLabel">Reset Password</h5>

					  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					  </button>
					</div>
					<div class="modal-body">
						<label class="form-label" for="form1Example13"> Enter the Username:</label><span id="invaliduser"></span>
					 <input type="text" id="usernamereset" class="form-control form-control-lg" />
					<div id="otps"> 
					 <label class="form-label" for="form1Example13"> Enter the Otp:</label><span id="invalidotp"></span>
					 <input type="text" id="otp" class="form-control form-control-lg" />
					</div>
				</div>
					<div class="modal-footer" id="forresetbutt">
					  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					  <button type="button" id="submitbutt" class="btn btn-primary">Submit</button>
					  <button type='submit' id='submitbutt2' class='btn btn-primary'>Submit1</button>
					</div>
				  </div>
				</div>
			  </div>
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

document.getElementById("submitbutt")?.addEventListener("click",()=>{
 var username= document.getElementById("usernamereset").value;


 var objpass={
	"user":username
 }

 senddataforreset('/EmpCtrl/resetpass','POST',objpass).then((responseData) => {
   console.log(responseData.userpresent , "User ");

     if(responseData.userpresent == "success"){
         document.getElementById("submitbutt").style.display = "none";
		 document.getElementById("forresetbutt").style.display = "block";
		 document.getElementById("otps").style.display = "block";
		 document.getElementById("invaliduser").style.display = "none";
      //   document.getElementById("forresetbutt").innerHTML = "<button type='submit' id='submitbutt2' class='btn btn-primary'>Submit1</button>";
		document.getElementById("submitbutt2").style.display = "block";
	}else{
		document.getElementById("invaliduser").style.display = "block";
		document.getElementById("invaliduser").innerText = "Invalid Username";
	}
 });

});

document.getElementById("submitbutt2")?.addEventListener("click",()=>{
  
	console.log("otp method called");
	var otp = document.getElementById("otp").value;

	console.log("otp--- " , otp)
    
	var bool = checkotp(otp);
	if(bool){
		document.getElementById("invalidotp").style.display="none";

		var username1= document.getElementById("usernamereset").value; 

		var newobj={
		 "user":username1,
		 "otp": otp
		}

		sendotpwithusername('/EmpCtrl/checkotp','POST',newobj).then((responseData) => {

		});
	}else{
		document.getElementById("invalidotp").style.display="block";
     document.getElementById("invalidotp").innerText = "Invalid Input";
	}


});

function sendotpwithusername(url,method,newobj){
	return new Promise((resolve,reject) => {
     const a={
		method: method || 'GET',
		headers:{
			'Content-Type':'application/json'
		},
		body:newobj ? JSON.stringify(newobj) : undefined,
	 }

	 fetch(url,a)
	 .then(response => {
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

function checkotp(otp){
	var val;
	outer: for(let i = 0; i< otp.length ; i++){
      var index= otp.charCodeAt(i);
	  if(index >= 48 && index <= 57){
          val = true;
	  }else{
         val = false;
		 break outer;
	  }
	}
	return val;
}

function senddataforreset(url,method,objpass){
	return new Promise((resolve,reject) => {
      const a={
		method: method || 'GET',
		headers:{
			'Content-Type':'application/json'
		},
		body:objpass ? JSON.stringify(objpass) : undefined,
	  }

	  fetch(url,a)
	  .then( response => {
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