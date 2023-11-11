<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>   
    <link rel="stylesheet" type="text/css" href="/css/side.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300&family=Secular+One&display=swap" rel="stylesheet">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <style>
    .main{
        margin-left:20px;
    }
    </style>
</head>
<body>
    <jsp:include page="newsidebar.jsp" /> 
    <jsp:include page="newheader.jsp" />
    <main class="main">
    
      
<div class="needs-validation formsofinfo" novalidate>
  <span id="displayMessage"></span>
    <h2 style="text-align:center; padding-bottom:20px;">Update Profile!</h2>

    <div style="display:flex; justify-content: center;">
        <c:choose>
            <c:when test="${empdetails[0].photo eq null}" >
        <img src="/resource/image/profile.jpg" width="150px" />
            </c:when>
            <c:otherwise>
        <img  src="${empdetails[0].photo}" width="150px" style="border-radius: 100px;"/>
            </c:otherwise>
           </c:choose>
       <div style="position:fixed; left:70%;" id="invalid-photo"></div>
    </div>
    <input style="margin-left: 40%;padding-top:10px;padding-bottom:10px;" type="file" class="col-md-4 mb-3" id="validationCustom01" />
  <div class="form-row">
    <div class="col-md-4 mb-3">
      <label for="validaterCustom01">Employee name</label>
      <input type="text" class="form-control" id="validaterCustom01" placeholder="First name" value="${empdetails[0].name}" required>
      <div id="valid-name">
      
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <label for="validationCustom02">Email-Id</label>
      <input type="text" class="form-control" id="validationCustom02" placeholder="Email-Id" value="${empdetails[0].email}" required>
      <div id="valid-mail">

      </div>
    </div>
    <div class="col-md-4 mb-3">
      <label for="validationCustomUsername">EmployeeId</label>
      <div class="input-group">
        <input type="text" class="form-control" id="validationCustomUsername" value="${empdetails[0].eid}" placeholder="EmployeeId" aria-describedby="inputGroupPrepend" required >
    </input>
      </div>
      <div id="invalid-eid">
          
      </div>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-4 mb-3">
      <label for="validationCustom03">Place</label>
      <c:choose>
       <c:when test="${empdetails[0].place eq null}" >
        <input type="text" class="form-control" id="validationCustom03" placeholder="Place"  required />
       </c:when>
       <c:otherwise>
        <input type="text" class="form-control" id="validationCustom03" placeholder="Place" value="${empdetails[0].place}"  required />
       </c:otherwise>
      </c:choose>

      <div id="invalid-place">
        
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <label for="validationCustom04">Phone No.</label>
      <c:choose>
        <c:when test="${empdetails[0].phone eq null}" >
         <input type="text" class="form-control" id="validationCustom04" placeholder="Phone"  required />
        </c:when>
        <c:otherwise>
         <input type="text" class="form-control" id="validationCustom04" placeholder="Phone" value="${empdetails[0].phone}"  required />
        </c:otherwise>
       </c:choose>
      <div id="invalid-phone">
        
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <label for="validationCustom05">Adhar No.</label>
      <c:choose>
       <c:when test="${empdetails[0].adharno eq null}" >
        <input type="text" class="form-control" id="validationCustom05" placeholder="Adhar No"  required />
       </c:when>
       <c:otherwise>
        <input type="text" class="form-control" id="validationCustom05" placeholder="Adhar No" value="${empdetails[0].adharno}"  required />
       </c:otherwise>
      </c:choose>
      <div id="invalid-adhar">
     
      </div>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-3 mb-3">
        <label for="validationCustom06">Date Of Birth</label>
        <c:choose>
       <c:when test="${empdetails[0].dob eq null}" >
        <input type="date" class="form-control" id="validationCustom06"   required />
       </c:when>
       <c:otherwise>
        <input type="date" class="form-control" id="validationCustom06"  value="${empdetails[0].dob}"  required />
       </c:otherwise>
      </c:choose>
  </div>
  </div>
  <div style="display:flex; justify-content: center;">
  <button id="clickbutt" style="background-color: navy; border:none; width:20%; padding:10px;" class="btn btn-primary" type="submit">Update Profile</button>
 <div id="forb64"></p>
</div>
</div>

    </main>
    <script src="/js/forsideheader.js"></script>
    <script>

    document.getElementById("clickbutt")?.addEventListener("click",async()=>{
     var phone = document.getElementById("validationCustom04").value;
     var adhar = document.getElementById("validationCustom05").value;
     var place = document.getElementById("validationCustom03").value;
     var ename = document.getElementById("validaterCustom01").value;
     var eid = document.getElementById("validationCustomUsername").value;
     var email = document.getElementById("validationCustom02").value;
     var photo = document.getElementById("validationCustom01").value;
     var date = document.getElementById("validationCustom06").value;



     
     console.log("ename----- ",eid);


     var valphone = phonecheck(phone);
     var valadhar = adharcheck(adhar);
     var valplace = placecheck(place);
     var valname = namecheck(ename);
     var valempid = empcheck(eid);
     var valemail = checkingmail(email);
     var valphoto = photocheck(photo);
     
     
    

     if(!valphone){
        document.getElementById("invalid-phone").style.display = "block";
        document.getElementById("invalid-phone").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("invalid-phone").style.display = "none";
     }

     if(!valadhar){
        document.getElementById("invalid-adhar").style.display = "block";
        document.getElementById("invalid-adhar").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("invalid-adhar").style.display = "none";
     }

     if(!valplace){
        document.getElementById("invalid-place").style.display = "block";
        document.getElementById("invalid-place").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("invalid-place").style.display = "none";
     }

     if(!valname){
        document.getElementById("valid-name").style.display = "block";
        document.getElementById("valid-name").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("valid-name").style.display = "none";
     }

     if(!valempid){
        document.getElementById("invalid-eid").style.display = "block";
        document.getElementById("invalid-eid").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("invalid-eid").style.display = "none";
     }

     if(!valemail){
        document.getElementById("valid-mail").style.display = "block";
        document.getElementById("valid-mail").innerHTML=`<i style="color:red;">Invalid Input</i>`;
     }else{
        document.getElementById("valid-mail").style.display = "none";
     }

     if(!valphoto){
        document.getElementById("invalid-photo").style.display = "block";
        document.getElementById("invalid-photo").innerHTML=`<img src='/resource/image/settings.gif' width=100px "><b style="font-size:20px;">Invalid Photo Type</img>`;
     }else{
        document.getElementById("invalid-photo").style.display = "none";
     }

 if(valphone==true && valadhar==true && valemail==true && valphoto==true && valempid==true && valplace==true && valname==true){
   
   console.log("method called");
  

   let file = document.querySelector('input[type=file]')['files'][0];
   let base64Image =await convertFileToBase64String(file,phone,adhar,place,email,ename,eid,date);
   console.log("new base64--- " , base64Image);

 }
    
    });

async function convertFileToBase64String(file,phone,adhar,place,email,ename,eid,date){

  //   let reader= new FileReader();
  //   reader.onload= async function(){
  //     const base64String = event.target.result;
  //     getbase64string(base64String,phone,adhar,place,email,ename,eid,date);
  //   };
  // reader.readAsDataURL(file);


  let  base64String;

      //let profilePhoto = document.getElementById("photo").files[0]

      if (file) {

        let filereader = new FileReader();

        filereader.readAsDataURL(file);

        filereader.onload = function (evt) {

          let profilePhotoBase64 = evt.target.result;

          base64String = profilePhotoBase64;
          getbase64string(base64String,phone,adhar,place,email,ename,eid,date);

        }

      } else {

        setTimeout(function () {

          base64String = null

        }, 1000)

      }    
}

function getbase64string(base64String,phone,adhar,place,email,ename,eid,date){

  var obj={
    "phone":phone,
    "adhar":adhar,
    "place": place,
    "email":email,
    "ename":ename,
    "eid":eid,
    "base64img" : base64String,
    "date": date
    }

    console.log("obj---- " , obj)
    sendinfodata('/EmpCtrl/empinfo','POST',obj).then((responseData) => {

      console.log(responseData , "response");

      if(responseData.empinfo == 'success'){
  
        alert("Profile Updated Successfully!");

      }else{
      
        alert("Invalid Input!");
        
      }

    });

    function sendinfodata(url,method,obj){
      return new Promise((resolve,reject) => {
      const data={
        method:method || 'GET',
        headers:{
          'Content-Type':'application/json'
        },
        body:obj ? JSON.stringify(obj) : undefined,
      }

      fetch(url,data)
      .then((response) => {
        if(!response.ok){
          throw new Error("Error occured " + response.status);
        }
       return response.json();
      })
      .then(data => {
        resolve(data);
      })
      .catch((error) => {
       reject(error);
      })
    });
    }
}

    function photocheck(photo){
        var valid;
        var index = photo.indexOf(".");
        var photoType= photo.substring(index,photo.length);
        console.log(photoType);
        if(".jpg" === photoType){
           valid=true;
        }else{
         valid=false;
        }

        return valid;
    }

    function phonecheck(phone){ 
     
     if(phone.length == 10){
        document.getElementById("invalid-phone").style.display = "none";
         var phoneval= numbervalidation(phone);
     }
     return phoneval;
 }

 function adharcheck(adhar){
    if(adhar.length == 12) {
        document.getElementById("invalid-adhar").style.display = "none";
        var adharval= numbervalidation(adhar);
    }
   return adharval;
 }

 function empcheck(eid){
  var bool = false;

  if(eid.length == 7){
    document.getElementById("invalid-eid").style.display = "none";

   var idnum = eid.substring(2,eid.length);
   var numval= numbervalidation(idnum);
   
   var caps = eid.substring(0,2);
   var checkcaps = valcaps(caps);

   if(numval == true && checkcaps == true){
    bool= true;
   }
}

   return bool;
 }

 function placecheck(place){
    var validplace = characterval(place);
    console.log("place validations----- " , validplace);
    return validplace;
 }

 function namecheck(ename){
    var validname = characterval(ename);
    return validname;
 }
     
    function numbervalidation(num){
        var bool;
    outer: for(let i=0;i < num.length;i++){
         
             let chindex = num.charCodeAt(i);
             if(chindex >= 48 && chindex <= 57){
                    bool = true;
             }else{
                bool=false;
                break outer;
             }
        }

        return bool;

    }

    function characterval(place){
        var val;
      outer:  for(let i=0 ; i < place.length ; i++){
            var index= place.charCodeAt(i);
            console.log("index-- " , index);
     
            if(index >= 33 && index <= 64 || index >=91 && index <= 96 || index >=123 && index <= 126){
              val = false;
              break outer;
            }else{
              val =true;
            }
        }

        return val;
    }

    function valcaps(eid){
        var val;
        outer: for(let i=0;i < eid.length;i++){
          var index = eid.charCodeAt(i);
          if(index >= 65 && index <=90){
             val=true;
          }else{
           val=false;
           break outer;
          }
        }

        return val;
    }

    function checkingmail(email) {
        var valid;
        var k = 0;

        outer: for (let i = 0; i < email.length; i++) {
          if (k <= 1) {
            if ('@' === email[i]) {
              k++;
            }
          } else {
            valid = false;
            break outer;
          }

        }

        if (k == 0 || k > 1) {
          valid=false;
           
        } else {
          valid = true;
          var mailindex = email.indexOf('@');

          if (mailindex != 0) {
            var m = 0;
            for (let j = mailindex; j < email.length; j++) {
              if (m <= 1) {
                if ('.' === email[j]) {
                  m++;
                }
              }
            }
            if (m == 0 || m > 1) {
              valid = false;
            
            
            } else {
           
              valid = true;
              var dotindex = email.indexOf('.');

              if (mailindex + 1 == dotindex) {

                console.log("No string present in middle");
                valid = false;
              
               return valid;
            
              } else {
                valid = true;
              }

              if (dotindex == email.length - 1) {
                valid = false;
               
              } else {
                valid = true;
              }
            }

          } else {
            valid = false;
           
            
          }
        }
         return valid;
      }


document.querySelector('#updateData')?.addEventListener('click', async function(e) {
    console.log('Started');
    let fileInput = document.querySelector('input[type=file]');
    let file = fileInput.files[0];
    let base64String;

    const readAsDataURL = (file) => {
        return new Promise((resolve, reject) => {
            let reader = new FileReader();
            reader.onload = function () {
                base64String = reader.result;
                resolve(base64String);
            };
            reader.onerror = function (error) {
                reject(error);
            };
            reader.readAsDataURL(file);
        });
    };

    try {
        await readAsDataURL(file);
        console.log(base64String);

        var obj = {
            "phone": "1111111111",
            "adhar": "111111111111",
            "place": "plafyhhce",
            "email": "email",
            "ename": "ename",
            "eid": "1",
            "base64img": base64String,
            "date": "12-10-12"
        };

        const responseData = await sendinfodata('/EmpCtrl/empinfo', 'POST', obj);
        console.log(responseData);
    } catch (error) {
        console.error(error);
    }
});


function sendinfodata(url,method,obj){
      return new Promise((resolve,reject) => {
      const data={
        method:method || 'GET',
        headers:{
          'Content-Type':'application/json'
        },
        body:obj ? JSON.stringify(obj) : undefined,
      }

      fetch(url,data).then((response) => {
        if(!response.ok){
          throw new Error("Error occured " + response.status);
        }
        return response.json();
        }).catch((error) => {
          console.log(error);
        })
      });
}
    </script>
</body>
</html>