package springs.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import springs.repository.EmpRepo;

@Controller
@RequestMapping("/Emp")
public class EmpCtrl {
	
	@Autowired
	private HttpSession session;
	

	@Autowired
	private EmpRepo repo;
	

	@GetMapping("/login")
	public String getform() {
		return "login";
	}
	
	@GetMapping("/error")
	public String error() {
		return "500";
	}
	
	@GetMapping("/getview")
	public ModelAndView getdata() {
		ModelAndView m=null;
		if(session.getAttribute("userdata")!=null) {
		
		
		m= new ModelAndView("Dashboard");
		
		List<Map<String,Object>> li=repo.checkdatepresent();
		
		System.out.println("LI data : "+li);
		m.addObject("gkey",session.getAttribute("userObj"));
		m.addObject("userobj",session.getAttribute("userdata"));
		m.addObject("userattendance",li);
		}else {
			m=new ModelAndView("404");
		}
		return m;
	}
	
	@GetMapping("/logout")
	public String logout(){
		session.invalidate();
       return "login";
	}

	@GetMapping("/calendar")
	public String calendar(Model m){
		
		List<Map<String,Object>> userobj=(List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);
		
		List<Map<String,Object>> li=repo.checkdatepresent();
		
//List<Map<String,Object>> absentdata = repo.checkpresentabsent();
		
		m.addAttribute("gkey",session.getAttribute("userObj"));
		m.addAttribute("userobj",session.getAttribute("userdata"));
		m.addAttribute("userattendance",li);
		return "calendar";
	}

	@GetMapping("/view-info")
	public String viewinfo(Model m){
		List<Map<String,Object>> userobj=(List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);
		
		List<Map<String,Object>> li=repo.checkdatepresent();
		
	
		
		m.addAttribute("gkey",session.getAttribute("userObj"));
		m.addAttribute("userobj",session.getAttribute("userdata"));
		m.addAttribute("userattendance",li);
		
		return "newsidebar";
	}
	
	@GetMapping("/viewcalendar")
	public String viewcalendar(Model m) {
		

//		List<Map<String,Object>> absentdata = repo.checkpresentabsent();
		
	//	System.out.println("Absent Data----> " + absentdata); 
		
		return "calendar";
	}
	
	@GetMapping("/header")
    public String header() {
    	return "header";
    }
	@GetMapping("/sidebar")
    public String sidebar() {
    	return "combine";
    }

	@GetMapping("/registerEmp")
	public String registerEmps(Model m){
		List<Map<String,Object>> userobj=(List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);
		
		List<Map<String,Object>> li=repo.checkdatepresent();
		
	
		
		m.addAttribute("gkey",session.getAttribute("userObj"));
		m.addAttribute("userobj",session.getAttribute("userdata"));
		m.addAttribute("userattendance",li);
      return "registerEmp";
	}

	
}
