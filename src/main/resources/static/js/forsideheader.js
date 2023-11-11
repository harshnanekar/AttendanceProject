  var elements= document.querySelector(".aside");
  
  if(elements){
 elements.addEventListener('click',function(){

    console.log("button clicked");
    var style = getComputedStyle(document.body);
    let asideVAlue = style.getPropertyValue("--sidenav");
    console.log(asideVAlue);
    if(asideVAlue == '350px'){

        document.documentElement.style.setProperty("--sidenav", "0px");

    }else{
        document.documentElement.style.setProperty("--sidenav", "350px");
    }
});
  }

  document.getElementById("logoutbutt").addEventListener("click",()=>{
      window.location.href = "/Emp/logout";
  });
