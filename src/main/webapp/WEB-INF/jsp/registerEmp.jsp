<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>   
    <link rel="stylesheet" type="text/css" href="/css/side.css">

    <style>
      .form{
    width:50vw;
    background-color: white;
    top:20%;
    position: absolute;
   left:550px;
   border:solid white 1px;
   box-shadow : 0px 0px 10px lightblue;
   padding:20px;
   border-radius:20px; 
  }
  #empdata{
   color:red;
   margin-left:20px;
   font-weight:bold;
   font-style:italic;
  }
  #empnamevals{
    color:red;
   margin-left:20px;
   font-weight:bold;
   font-style:italic;
  }
  #empvalidmail{
    color:red;
   margin-left:20px;
   font-weight:bold;
   font-style:italic;
  }
  #getrole{
  width: 100%;
  padding: 6px;
  border-color:lightgray;
  border-radius: 5px;
  
  }
  
    </style>
</head>
<body style="padding:0; margin:0;">
    <jsp:include page="newsidebar.jsp" /> 
    <jsp:include page="newheader.jsp" />
    <div class="mainbody">

      <div class="form">
        <div class="form-row">
          <div class="form-group col-md-6">
            <label for="inputEmail4">Employee Name</label>
            <span id="empnamevals"></span>
            <input type="text" id="name" class="form-control" id="inputEmail4" placeholder="Employee Name">
          </div>
          <div class="form-group col-md-6">
            <label for="inputPassword4">Email</label>
            <span id="empvalidmail"></span>
            <input type="email" id="email" class="form-control" id="inputPassword4" placeholder="Email">
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <label for="inputCity">City</label>
            <input id="city" type="text" class="form-control" id="inputCity" placeholder="City">
          </div>
          <div class="form-group col-md-6">
            <label for="inputState">Phone No.</label>
            <input id="phone" type="text" class="form-control" id="inputCity" placeholder="Phone No."> 
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <label for="inputCity">AdharNo.</label>
            <input id="adhar" type="text" class="form-control" id="inputCity" placeholder="AdharNo.">
          </div>
          <div class="form-group col-md-6">
            <label for="inputState">Date Of Birth.</label>
            <input type="date" class="form-control" id="inputCity"> 
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <label for="inputCity">Employee Id</label>
            <span id="empdata"></span>
            <input id="empid" type="text" class="form-control" id="inputCity" placeholder="Employee Id.">
          </div>

          <div class="dropdownlist col-md-6">
            <label for="inputCity">Select Role</label></br>
            <select id="getrole">
              <c:forEach var="dao" items="${roles}">
              <option id="seloptions" value="${dao.rolename}">${dao.rolename}</option>
            </c:forEach>
            </select>
          </div>

        </div>

      <div class="form-row">
        <div class="form-group col-md-6">
          <label for="inputCity">Set Password</label>
          <span id="empdata"></span>
          <input id="emppass" type="text" class="form-control" id="inputCity" placeholder="Employee Password.">
        </div>
      </div>

        <button id="clickbutt" type="submit" class="btn btn-primary">Save</button>
      </div>
      

       </div>
    <script src="/js/forsideheader.js"></script>
    <script> 
    
    document.getElementById("clickbutt").addEventListener("click",function(){

      

      var name = document.getElementById("name").value;
      var email= document.getElementById("email").value;
      var empid= document.getElementById("empid").value;
      var getrole= document.getElementById("getrole").value;
      var getpass= document.getElementById("emppass").value;
      console.log(getrole);
     
      var empbool= checkempid(empid);
      var empnameval = checkname(name);
      var checkmail= checkingmail(email);

    if(empbool==true && empnameval==true && checkmail==true){
     
      var obj={
        empname: name,
        email: email,
        eid: empid,
        role:getrole,
        pass: getpass
      }


        sendformdata('/EmpCtrl/registerEmpdata','POST',obj).then(responseData => {
          console.log("Response--- " ,responseData.registerEmp);
          if(responseData.registerEmp === 'valid'){
            alert("Registered Employee Successfully");
          }else if(responseData.registerEmp === 'invalidid'){
            alert("Username Taken");
          }else{
            alert("Invalid Inputs");
          }

        })
    }

    });

    //Employee Name
    function checkname(name){
    var valid;

     outer: for(let i=0;i < name.length;i++){
     var chars= name.charAt(name[i]);
     var getascii = name.charCodeAt(chars);

     if(getascii >=65 && getascii<=90 || getascii >=97 && getascii<=122 || getascii == 32){
        valid= true;
      document.getElementById("empnamevals").style.visibility = "hidden";
     }else{
      valid= false;
      document.getElementById("empnamevals").style.visibility = "visible";
      document.getElementById("empnamevals").innerText = "*Invalid Name";
      break outer;
        
     }


    }
    return valid;

    }

    //Employee EmailId
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
            document.getElementById("empvalidmail").style.visibility="visible";
            document.getElementById("empvalidmail").innerText="*Invalid Email-Id";
            break outer;
          }

        }

        if (k == 0 || k > 1) {
          valid=false;
          document.getElementById("empvalidmail").style.visibility="visible";
            document.getElementById("empvalidmail").innerText="*Invalid Email-Id";
           
        } else {
          document.getElementById("empvalidmail").style.visibility="hidden";
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
              document.getElementById("empvalidmail").style.visibility = "visible";
              document.getElementById("empvalidmail").innerText = "*Invalid Email-Id";
              valid = false;
            
            
            } else {
              document.getElementById("empvalidmail").style.visibility = "hidden";
              valid = true;
              var dotindex = email.indexOf('.');

              if (mailindex + 1 == dotindex) {

                console.log("No string present in middle");

                document.getElementById("empvalidmail").style.visibility = "visible";
                document.getElementById("empvalidmail").innerText = "*Invalid Email-Id";
                valid = false;
            
            
              } else {
                document.getElementById("empvalidmail").style.visibility = "hidden";
                valid = true;
              }

              if (dotindex == email.length - 1) {
                document.getElementById("empvalidmail").style.visibility = "visible";
                document.getElementById("empvalidmail").innerText = "*Invalid Email-Id";
                valid = false;
               
              } else {
                document.getElementById("empvalidmail").style.visibility = "hidden";
                valid = true;
              }
            }

          } else {
            document.getElementById("empvalidmail").style.visibility="visible";
            document.getElementById("empvalidmail").innerText="*Invalid Email-Id";
            valid = false;
           
            
          }
        }
        console.log("valids---- " , valid);
        return valid;
      }

    

    //Employee Id Validation
    function checkempid(empid) {
        var val = true;
        if (empid.length == 7) {
          document.getElementById("empdata").style.visibility = "hidden";
          var checkalphabet = checkcaps(empid);

          var empnum = empid.substring(2, empid.length);
          var checknum = checknums(empnum);

          if (checkalphabet == false) {

            console.log("this function called");

            document.getElementById("empdata").style.visibility = "visible";
            document.getElementById("empdata").innerText = "*Invalid Input";

          } else if (checknum == false) {
            document.getElementById("empdata").style.visibility = "visible";
            document.getElementById("empdata").innerText = "*Invalid Input";
          } else {
            document.getElementById("empdata").style.visibility = "hidden";
            val = true;
          }
        } else {
          document.getElementById("empdata").style.visibility = "visible";
          document.getElementById("empdata").innerText = "*Invalid Length";
          val = false;
        }
        return val;
      }

      function checkcaps(empid) {
        var valindex;
        var empindex = empid.substring(0, 2);

        outer: for (i = 0; i < empindex.length; i++) {
          let index = empid.charAt(empindex[0]);
          let asciivalue = empid.charCodeAt(index);
          if (asciivalue >= 65 && asciivalue <= 90) {
            valindex = true;
          } else {
            valindex = false;
            break outer;
          }
        }

        return valindex;

      }

      function checknums(empid){
        var valindex;

        console.log("empid--- ",empid);

        outer: for(let i=0; i < empid.length;i++){

          var checkindex= empid.charAt(empid[i]);
          console.log(checkindex);
          var getascii= empid.charCodeAt(checkindex);
        
          if(getascii >= 48 && getascii <=57){
              valindex = true;
          }else{
            valindex=false;
            break outer;
          }

        }

        return valindex;
      }
    
      async function sendformdata(url, method, obj) {

          return new Promise((resolve, reject) => {
            const a = {
              method: method,
              headers: {
                'Content-Type': 'application/json'
              },
              body: obj ? JSON.stringify(obj) : undefined,
            }

            fetch(url, a)
              .then(response => {
                if (!response.ok) {
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


    
    </script>
</body>
</html>