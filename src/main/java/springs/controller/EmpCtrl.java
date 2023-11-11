package springs.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		ModelAndView m = null;
		if (session.getAttribute("userdata") != null) {

			m = new ModelAndView("Dashboard");

			List<Map<String, Object>> li = repo.checkdatepresent();

			System.out.println("LI data : " + li);
			m.addObject("gkey", session.getAttribute("userObj"));
			m.addObject("userobj", session.getAttribute("userdata"));
			m.addObject("userattendance", li);
		} else {
			m = new ModelAndView("404");
		}
		return m;
	}

	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		return "login";
	}

	@GetMapping("/calendar")
	public String calendar(Model m) {

		List<Map<String, Object>> userobj = (List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);

		List<Map<String, Object>> li = repo.checkdatepresent();

		// List<Map<String,Object>> absentdata = repo.checkpresentabsent();

		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		return "calendar";
	}

	@GetMapping("/viewinfo")
	public String viewinfo(Model m) {
	

		List<Map<String, Object>> li = repo.checkdatepresent();
		List<Map<String,Object>> empid= (List<Map<String,Object>>)session.getAttribute("usernewobj");
		String emp=(String)empid.get(0).get("eid");
		List<Map<String,Object>> emprecord = repo.loginvalid(emp);

		
	
	
		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("emprecord", emprecord);
		m.addAttribute("eid", emprecord.get(0).get("eid"));
		m.addAttribute("photo", emprecord.get(0).get("photo"));

		System.out.println("view info data-- " + session.getAttribute("userdata"));


		return "viewinfo";
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
	public String registerEmps(Model m) {
		List<Map<String, Object>> userobj = (List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);

		List<Map<String, Object>> li = repo.checkdatepresent();
		List<Map<String, Object>> roles = repo.getallroles();

		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("roles", roles);
		return "registerEmp";
	}

	@GetMapping("/approveEmp")
	public String approveEmp(Model m){
      List<Map<String, Object>> userobj = (List<Map<String, Object>>) session.getAttribute("userdata");
		System.out.println("User Data for sidebar---> " + userobj);

		List<Map<String, Object>> li = repo.checkdatepresent();

		List<Map<String,Object>> emprecord = repo.fetchforapprove();
	
		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		

		return "approveEmp";
	}

	@GetMapping("/approving")
	public String approvedEmp(Model m){
	    List<Map<String, Object>> li = repo.checkdatepresent();
		List<Map<String,Object>> emprecord = repo.fetchforapprove();

	    m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("emprecord", emprecord);
       return "approvelist";
	}

	@GetMapping("/pending")
	public String rejected(Model m){
		 List<Map<String, Object>> li = repo.checkdatepresent();
        List<Map<String,Object>> emprecord = repo.fetchforpending();

	    m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("emprecord", emprecord);
		       return "pending";
	}

	@GetMapping("/regularizations")
	public String regularizations(Model m){

		List<Map<String, Object>> li = repo.checkdatepresent();

		List<Map<String,Object>> empid= (List<Map<String,Object>>)session.getAttribute("usernewobj");
	String emp=(String)empid.get(0).get("eid");
	
		System.out.println("Empid for regularizations---- " + empid);
		List<Map<String,Object>> emprecord = repo.fetchempapprovedata(emp);
	
		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("emprecord", emprecord);

		return "empregularizations";
	}

	@GetMapping("/editprofile")
	public String editprofile(@RequestParam int id,Model m){
        List<Map<String, Object>> li = repo.checkdatepresent();
        List<Map<String,Object>> emp = repo.findbyId(id);


		m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("empdetails", emp);
        return "editprofile";
	}

	@GetMapping("/rejected")
	public String rejectedemps(Model m){
	    List<Map<String, Object>> li = repo.checkdatepresent();
		List<Map<String,Object>> emprecord = repo.rejectedstatus();

	    m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		m.addAttribute("emprecord", emprecord);
       return "rejected";
	}

	@GetMapping("/empapplication")
	public String empapplications(@RequestParam String status,Model m){
System.out.println("status--- for emp " + status);

       List<Map<String,Object>> empid= (List<Map<String,Object>>)session.getAttribute("usernewobj");
		String emp=(String)empid.get(0).get("eid");
		System.out.println("Empid for regulization--- " + emp);

   List<Map<String, Object>> li = repo.checkdatepresent();
         List<Map<String,Object>> lis =repo.empapplication(emp,status);

		 System.out.println("Application--- " + lis);

	    m.addAttribute("gkey", session.getAttribute("userObj"));
		m.addAttribute("userobj", session.getAttribute("userdata"));
		m.addAttribute("userattendance", li);
		 m.addAttribute("emprecord", lis);

		 return "regularizations";
	}



}
