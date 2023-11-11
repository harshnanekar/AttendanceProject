<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.util.Map" %>
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

            </head>

            <body style="padding:0; margin:0;">
                <jsp:include page="newsidebar.jsp" />
                <jsp:include page="newheader.jsp" />
                <main id="main">

                    <div class="mainbody">
                        <div>
                        </div>
                        <!--    
        <c:forEach var="dao" items="${li}">
            <li>${dao.date}</li>
        </c:forEach> -->

                        <div class="buttons">
                            <button id="prev-year">Previous Year</button>
                            <button id="prev-month">Previous Month</button>
                            <span id="nmonth-year"></span>
                            <button id="next-month">Next Month</button>
                            <button id="next-year">Next Year</button>
                        </div>

                        <div>
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
                                <tbody id="calendar-body">
                                </tbody>
                            </table>
                        </div>
                    </div>





                </main>
                <script src="/js/forsideheader.js"></script>
                <script>
                    let currentYear = 2023;
                    let currentMonth = 9; // October (0-based)

                    var data;
                    var monthfinalNames;
                    var getmonthno;
        
                    currentmonthdata();

                    function currentmonthdata() {

                        var calendar = [{ 1: "January" }, { 2: "February" }, { 3: "March" }, { 4: "April" }, { 5: "May" }, { 6: "June" },
                        { 7: "July" }, { 8: "August" }, { 9: "September" }, { 10: "October" }, { 11: "November" }, { 12: "December" }];
                         
                        var forabsentdata ;
                        var date = new Date();
                        var ncurrentm = date.getMonth();
                        var ncurrentyear = date.getFullYear();
                      
                        monthfinalNames = [
                            "January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December"
                        ];

                           generateCalendar(currentYear, currentMonth,data);

                        outer: for (i = 0; i < calendar.length; i++) {
                            if (i == currentMonth) {
                                getmonthno = Object.keys(calendar[i]);
                                break outer;
                            }
                        }

                        var obj = {
                            "year": currentYear,
                            "month": getmonthno

                        }

                        getdates('/EmpCtrl/nextmonth', 'POST', obj).then(responseData => {
                            data = responseData;

                            generateCalendar(ncurrentyear, ncurrentm, data);
                        })

                    }


                    var calendar = [{ 1: "January" }, { 2: "February" }, { 3: "March" }, { 4: "April" }, { 5: "May" }, { 6: "June" },
                    { 7: "July" }, { 8: "August" }, { 9: "September" }, { 10: "October" }, { 11: "November" }, { 12: "December" }];

                    const monthYear = document.getElementById("month-year");

                    function generateCalendar(year, month, data) {


                        const calendarBody = document.getElementById("calendar-body");
                        calendarBody.innerHTML = '';

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

                                    console.log("data got in calendar", data);
                                    if (data != null) {
                                        for (k = 0; k < data.length; k++) {
                                            var dateforab = data[k].date;
                                            var dayab = dateforab.substring(3, 6);
                                            var yearab = dateforab.substring(7, dateforab.length);
                                    
                                            var checkday = dayab.split(",");
                                            var dates = new Date(dateforab);


                                            monthfinalNames = [
                                                "January", "February", "March", "April", "May", "June",
                                                "July", "August", "September", "October", "November", "December"
                                            ];


                                            var months = monthfinalNames[date.getMonth()];
                                            var mindex = monthfinalNames.indexOf(months);


                                            if (currentYear == yearab && currentMonth == mindex && day == checkday[0]) {
                                                const tagp = document.createElement("h5");
                                                cell.textContent = day;
                                                // cell.style.fontSize = "20px";
                                                // const butt = document.createElement("button");
                                                // cell.textContent = day;
                                                // butt.textContent = "+";
                                                // butt.style.float = "right";
                                                // butt.style.backgroundColor = "white";
                                                // butt.style.border = "none";

                                                // tagp.textContent = "P";
                                                // cell.appendChild(tagp);
                                                // cell.appendChild(butt);
                                            }

                                    }
                                   


                                    // var forpday = new Date(currentYear, currentMonth, day).getDay();
                                    // if (forpday == 0) {
                                       
                                    //             cell.textContent = day;
                                    //             cell.style.backgroundColor= "lightblue";
                                    
                                    // }

                                
                                  if(!cell.textContent){
                                   cell.textContent = day;
                                  }
                                    day++;
                                    


                                }

                                row.appendChild(cell);
                            }

                            calendarBody.appendChild(row);

                            // if (day > lastDay) {
                            //     break;
                            // }
                        }

                        const monthNames = [
                            "January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December"
                        ];

                        //    monthYear.textContent = `${monthNames[month]} ${year}`;
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
                            "year": currentYear,
                            "month": getmonthno

                        }

                        getdates('/EmpCtrl/nextmonth', 'POST', obj).then(responseData => {
                            data = responseData;

                            generateCalendar(currentYear, currentMonth, data);
                        })

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
                            "year": currentYear,
                            "month": getmonthno

                        }

                        getdates('/EmpCtrl/nextmonth', 'POST', obj).then(responseData => {
                            data = responseData;

                            generateCalendar(currentYear, currentMonth, data);
                        })


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
                            "year": currentYear,
                            "month": getmonthno

                        }
                        var forabsent;
                        getdates('/EmpCtrl/nextmonth', 'POST', obj).then(responseData => {
                            forabsent = responseData;

                            useForAbsentData(forabsent);
                        })

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
                            "year": currentYear,
                            "month": getmonthno

                        }

                        getdates('/EmpCtrl/nextmonth', 'POST', obj).then(responseData => {
                            data = responseData;

                            generateCalendar(currentYear, currentMonth, data);
                        })

                    });

                    function getdates(url, method, obj) {

                        return new Promise((resolve, reject) => {
                            const a = {
                                method: method || 'GET',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: obj ? JSON.stringify(obj) : undefined,
                            }

                            fetch(url, a)
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error("Error Ocuured");
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

                    }
                </script>
            </body>

            </html>