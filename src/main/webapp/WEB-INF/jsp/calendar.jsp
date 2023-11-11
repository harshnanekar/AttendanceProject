<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
import="java.util.List" %> <%@ page import="java.util.Map" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
  <head>
    <meta charset="UTF-8" />

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
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
    <style>
      #userlogdata {
        display: none;
       
        background-color: #ffffff;
       width: 90%;
        font-family: "Secular One", sans-serif;
        box-shadow: 0px 0px 10px lightblue;
        box-sizing: border-box;
        padding: 40px;
        border-radius: 20px;
        margin-top:100px;
      }
      input[type="text"] {
        margin-top: 18px;
        margin-bottom: 20px;
      }
      input[type="time"] {
       width:100px;
      }
      #submitbutt {
        background-color: navy;
        color: white;
        padding: 3px;
        width: 100px;
        margin-left: 20px;
        border-radius: 10px;
      }
      #leavedate {
        margin-top: 20px;
      }
      #scrollspy {
        padding: 10px;
        box-shadow: 0px 0px 8px gray;
        border-radius: 20px;
        margin-top: 30px;
      }
#regularize{
width:30%;
margin-left:35%;
margin-top: 20px;
background-color: navy;
color:white;
border-radius:10px;
padding:3px;

}

#reasonmessage{
  text-align: center;
  background-color: lightgreen;
  width:50%;
  margin-bottom:50px;
  border-radius:10px;
  font-size:20px;
  font-family: "Secular One", sans-serif;
  padding:10px;
  display:none;
  overflow:hidden;
  position:relative;
  left:400px;

}
#newmonthname{
  font-family: "Secular One", sans-serif;
 font-size:20px;
 color:navy;
 padding:20px;
}
#prev-year , #prev-month , #next-month , #next-year{
    padding:10px;
    border:0;
    margin-bottom:20px;
    font-size:20px;
  font-family: "Secular One", sans-serif;
  border-radius:10px;
  margin-right:10px;
}
#prev-year:hover , #prev-month:hover ,#next-year:hover ,#next-month:hover{
   background-color: navy;
   color:white;
   font-size:20px;
  font-family: "Secular One", sans-serif;
}
thead{
  text-align:center;
  background-color: navy;
  color:white;
  font-size:20px;
  font-family: "Secular One", sans-serif;
}

    
    </style>
  </head>

  <body style="padding: 0; margin: 0">
    <jsp:include page="newsidebar.jsp" />

    <jsp:include page="newheader.jsp" />

    <main id="main">
      <div class="mainbody">
        <div></div>
       <div class="rmessage"> <span id="reasonmessage"></span></div>
      
        <div class="buttons">
          <button id="prev-year">Previous Year</button>

          <button id="prev-month">Previous Month</button>

          <span id="newmonthname"></span>

          <button id="next-month">Next Month</button>

          <button id="next-year">Next Year</button>
         
        </div>
       
        <div>
          <span id="reasonmessage"></span>
          <table>
            <thead>
              <tr>
                <th>Sun</th>

                <th>Mon</th>

                <th>Tue</th>

                <th>Wed</th>

                <th>Thu</th>

                <th>Fri</th>

                <th>Sat</th>
              </tr>
            </thead>

            <tbody id="calendar-body"></tbody>
          </table>
        </div>
 
      </div>
      <div id="userlogdata">
        <div id="userlogging" ></div>
        <button id="regularize">Regularize</button>
      </div>
    </main>

  

    <script src="/js/forsideheader.js"></script>

    <script>
      var getnewdates =new Date();
      var showmecurryear = getnewdates.getFullYear();
      var showmecurrmonth = getnewdates.getMonth();
      let currentYear = showmecurryear;

      let currentMonth= showmecurrmonth; // October (0-based)

      var data;

      var monthfinalNames;

      var getmonthno;

      var butts;

      var buttondata;

      currentmonthdata();

      function currentmonthdata() {
        var calendar = [
          { 1: "January" },
          { 2: "February" },
          { 3: "March" },
          { 4: "April" },
          { 5: "May" },
          { 6: "June" },

          { 7: "July" },
          { 8: "August" },
          { 9: "September" },
          { 10: "October" },
          { 11: "November" },
          { 12: "December" },
        ];

        var date = new Date();

        var ncurrentm = date.getMonth();

        var ncurrentyear = date.getFullYear();

        var printmonth;

        monthfinalNames = [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",

          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ];

        // generateCalendar(currentYear, currentMonth,data);

        outer: for (i = 0; i < calendar.length; i++) {
          if (i == currentMonth) {
            console.log("currentmonth -- ", currentMonth);

            console.log("i---- ", i);

            getmonthno = Object.keys(calendar[i]);

            break outer;
          }
        }

        var obj = {
          year: ncurrentyear,

          month: getmonthno,
        };

        getdates("/EmpCtrl/nextmonth", "POST", obj).then((responseData) => {
          data = responseData;

          generateCalendar(ncurrentyear, ncurrentm, data);
        });
      }

      var calendar = [
        { 1: "January" },
        { 2: "February" },
        { 3: "March" },
        { 4: "April" },
        { 5: "May" },
        { 6: "June" },

        { 7: "July" },
        { 8: "August" },
        { 9: "September" },
        { 10: "October" },
        { 11: "November" },
        { 12: "December" },
      ];

      const monthYear = document.getElementById("month-year");

      function generateCalendar(year, month, data) {
        const calendarBody = document.getElementById("calendar-body");

        calendarBody.innerHTML = "";

        const date = new Date(year, month, 1);

        const lastDay = new Date(year, month + 1, 0).getDate();

        const firstDay = date.getDay();

        let day = 1;

        for (let i = 0; i < 6; i++) {
          const row = document.createElement("tr");

          for (let j = 0; j < 7; j++) {
            const cell = document.createElement("td");

            if (i === 0 && j < firstDay) {
              cell.textContent = "";
            } else if (day > lastDay) {
              break;
            } else {
              var absentdata;
              console.log("data got in calendar", data);

              if (data != null) {

                //For Present Loop
                for (k = 0; k < data.length; k++) {
                  var dateforab = data[k].date;

                  console.log("Dateab-- ", data);

                  var yearab = dateforab.substring(7, dateforab.length);

                  var dateab = dateforab.substring(0, 4);

                  var dayab = dateforab.substring(3, 6);

                  var checkday = dayab.split(",");

                  var dates = new Date(dateforab);

                  monthfinalNames = [
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",

                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December",
                  ];

                  var months = monthfinalNames[date.getMonth()];

                  var mindex = monthfinalNames.indexOf(months);
                  console.log("present day error occuring--- ", yearab , mindex , checkday[0]);
                  console.log("present day error occuring--- ", currentYear , currentMonth , day);
                  if (
                    currentYear == yearab &&
                    currentMonth == mindex &&
                    day == checkday[0]
                  ) {

                  

                    const tagp = document.createElement("h5");
                    cell.textContent = day;
                    cell.style.fontSize = "20px";
                    const butt = document.createElement("button");

                    butt.textContent = "+";
                    butt.style.float = "right";
                    butt.style.backgroundColor = "white";
                    butt.style.border = "none";

                    tagp.textContent = "P";
                    cell.appendChild(tagp);
                    cell.appendChild(butt);

                    ///for present reason
                   
                    const buttonIds =
                      "presentdataid_" + currentYear + "_" + mindex + "_" + day;
                    butt.setAttribute("id", buttonIds);

                    console.log(
                      "Days for absent---- ",
                      currentYear,
                      mindex,
                      day
                    );
                    console.log("buttonIds ---- ", buttonIds);

                    var forcombinedvalues;

                    for (let fs = 0; fs < calendar.length; fs++) {
                      if (mindex == fs) {
                        console.log("mindex--- ", mindex);
                        console.log("f--- ", fs);
                        forcombinedvalues = Object.keys(calendar[fs]);
                      }
                    }

                    var combinedvalues =
                      currentYear + "-" + forcombinedvalues + "-" + day;
                    console.log("data-Id ---- ", combinedvalues);

                    butt.setAttribute("data-present", combinedvalues); 



                    (function (button) {
                      button.addEventListener("click", function () {
                        getclickdatas = button.getAttribute("data-present");
                        localStorage.setItem("date", getclickdatas);
                        console.log("getclickdata ----- ", getclickdatas);
                      });
                    })(butt);

                    butt?.addEventListener("click", function () {
                      console.log(
                        "date for printing--- ",
                        currentYear + `-` + mindex + `-` + day
                      );
                      let dateNews = localStorage.getItem("date");
                      document.getElementById("userlogdata").style.display =
                        "block";
                      var headertext =
                        `<div id="scrollspy"><h4 id="leavedate">` +
                        dateNews +
                        `</h4></br>
                     Start time: <input id="Starttime" type="datetime-local" />
                        &ensp;End time: <input  id="Endtime"  type="datetime-local" />
                        </br>Enter the reason: <input  id="reason" type="text" />&nbsp;</div>`;

                      document
                        .getElementById("userlogging")
                        .insertAdjacentHTML("beforeend", headertext);
                    });
                  } 
                  
                
                }

                
                //console.log("absentdata--- " + absentdata);
              }

              
              var forpday = new Date(currentYear, currentMonth, day).getDay();

              if (forpday == 0) {
                const tagp = document.createElement("h5");
                cell.textContent = day;
                cell.style.fontSize ="20px";
                  tagp.textContent = "R";
                  cell.appendChild(tagp);

              }

              var gettoday = new Date();
              var getdayfortoday = gettoday.getDay();
              var getcurrmonth = gettoday.getMonth();
              var getcurryear = gettoday.getFullYear();

              if (!cell.textContent) {
                cell.textContent = day;

                for(let mo=1 ; mo <=lastDay ; mo++){
               
                if(currentYear <= getcurryear &&  currentMonth <= getcurrmonth && mo <=getdayfortoday ){

                  console.log("current month--- ", getcurrmonth , "current month--- " , currentMonth);
                  console.log("current year--- ", getcurryear , "current year--- " , currentYear);
                  console.log("current day--- ", getdayfortoday , "current day--- " , day);
              
                const tagp = document.createElement("h5");
                    cell.textContent = day;
                    cell.style.fontSize = "20px";
                    butts = document.createElement("button");

                    butts.textContent = "+";
                    butts.style.float = "right";
                    butts.style.backgroundColor = "white";
                    butts.style.border = "none";

                    const buttonId =
                      "absentdataid_" + currentYear + "_" + mindex + "_" + day;
                    butts.setAttribute("id", buttonId);

                    console.log(
                      "Days for absent---- ",
                      currentYear,
                      mindex,
                      day
                    );
                    console.log("buttonId ---- ", buttonId);

                    var forcombinedvalue;

                    for (let f = 0; f < calendar.length; f++) {
                      if (mindex == f) {
                        console.log("mindex--- ", mindex);
                        console.log("f--- ", f);
                        forcombinedvalue = Object.keys(calendar[f]);
                      }
                    }

                    var combinedvalue =
                      currentYear + "-" + forcombinedvalue + "-" + day;
                    console.log("data-Id ---- ", combinedvalue);

                    butts.setAttribute("data-id", combinedvalue);

                    tagp.textContent = "A";
                    cell.appendChild(tagp);
                    cell.appendChild(butts);

                    (function (button) {
                      button.addEventListener("click", function () {
                        getclickdata = button.getAttribute("data-id");
                        localStorage.setItem("dates", getclickdata);
                        console.log("getclickdata ----- ", getclickdata);
                      });
                    })(butts);

                    butts?.addEventListener("click", function () {
                      console.log(
                        "date for printing--- ",
                        currentYear + `-` + mindex + `-` + day
                      );
                      let dateNew = localStorage.getItem("dates");
                      document.getElementById("userlogdata").style.display =
                        "block";
                      var headertext =
                        `<div id="scrollspy"><h4 id="leavedate">` +
                        dateNew +
                        `</h4></br>
                     Start time: <input id="Starttime" type="datetime-local" />
                        &ensp;End time: <input  id="Endtime"  type="datetime-local" />
                        </br>Enter the reason: <input  id="reason" type="text" />&nbsp;</div>`;

                      document
                        .getElementById("userlogging")
                        .insertAdjacentHTML("beforeend", headertext);
                    });

                  }
                }


              }

              day++;
            }

            row.appendChild(cell);
          }

          calendarBody.appendChild(row);

          if (day > lastDay) {
            break;
          }
        }

        const monthNames = [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",

          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ];

        // monthYear.textContent = `${monthNames[month]} ${year}`;
        document.getElementById("newmonthname").innerText = monthNames[currentMonth];
      }

      generateCalendar(currentYear, currentMonth, data);

      document.getElementById("prev-year").addEventListener("click", () => {
        currentYear--;

        generateCalendar(currentYear, currentMonth);

        outer: for (i = 0; i < calendar.length; i++) {
          if (i == currentMonth) {
            console.log("currentmonth -- ", currentMonth);

            console.log("i---- ", i);

            getmonthno = Object.keys(calendar[i]);

            break outer;
          }
        }

        var obj = {
          year: currentYear,

          month: getmonthno,
        };

        getdates("/EmpCtrl/nextmonth", "POST", obj).then((responseData) => {
          data = responseData;

          generateCalendar(currentYear, currentMonth, data);
        });
      });

      document.getElementById("prev-month").addEventListener("click", () => {
        if (currentMonth === 0) {
          currentYear--;

          currentMonth = 11;
        } else {
          currentMonth--;
        }

        generateCalendar(currentYear, currentMonth, data);

        outer: for (i = 0; i < calendar.length; i++) {
          if (i == currentMonth) {
            console.log("currentmonth -- ", currentMonth);

            console.log("i---- ", i);

            getmonthno = Object.keys(calendar[i]);

            break outer;
          }
        }

        var obj = {
          year: currentYear,

          month: getmonthno,
        };

        getdates("/EmpCtrl/nextmonth", "POST", obj).then((responseData) => {
          data = responseData;

          generateCalendar(currentYear, currentMonth, data);
        });
      });

      document.getElementById("next-month").addEventListener("click", () => {
        if (currentMonth === 11) {
          currentYear++;

          currentMonth = 0;
        } else {
          currentMonth++;
        }

        generateCalendar(currentYear, currentMonth, data);

        outer: for (i = 0; i < calendar.length; i++) {
          if (i == currentMonth) {
            console.log("currentmonth -- ", currentMonth);

            console.log("i---- ", i);

            getmonthno = Object.keys(calendar[i]);

            break outer;
          }
        }

        console.log("month", getmonthno);

        var obj = {
          year: currentYear,

          month: getmonthno,
        };

        var forabsent;

        getdates("/EmpCtrl/nextmonth", "POST", obj).then((responseData) => {
          forabsent = responseData;

          useForAbsentData(forabsent);
        });
      });

      function useForAbsentData(data) {
        console.log("date got ", data);

        generateCalendar(currentYear, currentMonth, data);
      }

      document.getElementById("next-year").addEventListener("click", () => {
        currentYear++;

        generateCalendar(currentYear, currentMonth, data);

        outer: for (i = 0; i < calendar.length; i++) {
          if (i == currentMonth) {
            console.log("currentmonth -- ", currentMonth);

            console.log("i---- ", i);

            getmonthno = Object.keys(calendar[i]);

            break outer;
          }
        }

        var obj = {
          year: currentYear,

          month: getmonthno,
        };

        getdates("/EmpCtrl/nextmonth", "POST", obj).then((responseData) => {
          data = responseData;

          generateCalendar(currentYear, currentMonth, data);
        });
      });

      function getdates(url, method, obj) {
        return new Promise((resolve, reject) => {
          const a = {
            method: method || "GET",

            headers: {
              "Content-Type": "application/json",
            },

            body: obj ? JSON.stringify(obj) : undefined,
          };

          fetch(url, a)
            .then((response) => {
              if (!response.ok) {
                throw new Error("Error Ocuured");
              }

              return response.json();
            })

            .then((data) => {
              resolve(data);
            })

            .catch((error) => {
              reject(error);
            });
        });
      }

      document.getElementById("regularize")?.addEventListener("click",function(){
        console.log("button print");
        var obj = [];

        var divElement = document.getElementById("userlogging");
        for(let i=0; i < divElement.children.length; i++){
          var startime = divElement.children[i].querySelector("#Starttime").value;
          var endtime = divElement.children[i].querySelector("#Endtime").value;
          var reason = divElement.children[i].querySelector("#reason").value;

          let tempObj = {
            startime,endtime,reason
          }

          obj.push(tempObj);
        }
        console.log("date obj--- " , obj);
      
       sendapprovaldata('/EmpCtrl/approval','POST',obj).then(responseObj =>{
             console.log("approval-- " , responseObj.approvalresponse);
           
             if(responseObj.approvalresponse === "datagot"){
             document.getElementById("userlogdata").style.display = "none";
             document.getElementById("reasonmessage").innerText = "Hurray, Action Completed Successfully!!";
             document.getElementById("reasonmessage").style.display = "block";
            
             setTimeout(() =>{
              console.log("settimeout called");
       document.getElementById("reasonmessage").style.display = "none";
             },3000);

             }

             if(responseObj.approvalresponse === "error"){
             window.location.href = "/Emp/error";
             }

      
       });

        }
      );

      async function sendapprovaldata(url,method,obj){

        try{
        const a= {
          method: method,
          headers:{
            'Content-Type' : 'application/json'
          },
          body:obj ? JSON.stringify(obj) : undefined,
         } 
  
               const response= await fetch(url,a);
          
              if(!response.ok){
                 return new Error("Error Ocuured");
                }

            const data= await response.json();
            return data;
        } catch (error) {
          return new Error("Error Ocuured in catched");
        };

      }
    

    </script>
  </body>
</html>
