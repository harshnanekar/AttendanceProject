package springs.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import springs.repository.EmpRepo;

@RestController
@RequestMapping("/EmpCtrl")
public class EmpCtrl2 {
	
	@Autowired
	private EmpRepo repo;
	
	@Autowired
	private EmpCtrl ctrl;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private BCryptPasswordEncoder encodes;
	
	@PostMapping("/logcheck")
	public String checklogin(@RequestBody String data) {
		
		String s="";
		
		Gson g=new Gson();
		JsonObject j=g.fromJson(data, JsonObject.class);
		String log=j.get("logerid").getAsString();
		String pass=j.get("password").getAsString();
		try {
		
		List<Map<String,Object>> li =repo.loginvalid(log);
		if(li.isEmpty()) {
			s="{\"auth\":\"Invalid username\"}";
		}else {
			
			boolean val=encodes.matches(pass, (String) li.get(0).get("password"));
		    if(val==true) {
		    	List<Map<String,Object>> obj=repo.givedash(li);
                List<Map<String,Object>> userdata=repo.giveuserdetails(li);
                
                System.out.println("Obj---> " + obj);
                System.out.println("UserData--->" + userdata);
                
		    	session.setAttribute("userObj", obj);
		    	session.setAttribute("userdata", userdata);
		    	session.setAttribute("userData", li);
		    	
		      	s="{\"auth\":\"Valid\"}";
		    }else {
		    	s="{\"auth\":\"Invalid password\"}";
		    }
			
		}
		
		return s;
		}catch(Exception e) {
			s="{\"auth\":\"error\"}";
			System.out.print(e.getMessage());
			return s;
		}
		
	}
	
	@GetMapping("/addattendance")
	public String addattendance() {
		
		String s="";
		System.out.println("Method called for get");
		System.out.println(LocalTime.now());
		repo.addattendance();
		s="{\"attendance\":\"success\"}";
		return s;
	}
	

	
	@PostMapping("/signout")
	public String signout(@RequestBody String data) {
		Gson g=new Gson();
		JsonObject j=g.fromJson(data, JsonObject.class);
		String id=j.get("aid").getAsString();
		
		
		String s="";
		System.out.println("Method called for signout");
		System.out.println(id);
		
	    repo.signout(id);
		s="{\"signout\":\"signoutted\"}";
		return s;
	}

	@GetMapping("/logout")
	public String logedout(){
		String s="";
          
		session.invalidate();
		s="{\"logout\":\"success\"}";
		return s;
	}

	@GetMapping("/aftersignout")
	public String aftersignout(){
		Gson g=new Gson();
		String s="";
        List<Map<String,Object>> li=repo.checkdatepresent();
		if(li.isEmpty()){
			System.out.println("is empty");
          s="{\"buttobj\":\"invalid\"}";                    
		}else{
   s="{\"buttobj\":\"valid\"}";    
		}
		return s;
	}
	
	@PostMapping("/nextmonth")
	public String nextmonth(@RequestBody String data) {
		Gson g=new Gson();
		JsonObject j=g.fromJson(data, JsonObject.class);
		 String month= j.get("month").getAsString();
		 String year= j.get("year").getAsString(); 
		 System.out.println(month);
		 System.out.println(year);
		 
		int getmonth=Integer.parseInt(month);
		
		 int getyearno=Integer.parseInt(year);
		 
		 List<Map<String,Object>> getabdate= repo.checkpresentabsent(getmonth,getyearno);
		 System.out.println("Json--->" + getabdate);
		 String json= g.toJson(getabdate);
		 
		return json;
	}
	
}
