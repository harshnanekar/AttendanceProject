package springs.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Timestamp;
import java.sql.Time;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonSerializable.Base;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import springs.config.EmailReset;
import springs.config.Validate;
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

	@Autowired
	private Validate valid;

	@Autowired
	private EmailReset email;
	
 
    
    
	@PostMapping("/logcheck")
	public String checklogin(@RequestBody String data) {

		String s = "";

		Gson g = new Gson();
		JsonObject j = g.fromJson(data, JsonObject.class);
		String log = j.get("logerid").getAsString();
		String pass = j.get("password").getAsString();
		try {

			List<Map<String, Object>> li = repo.loginvalid(log);
			if (li.isEmpty()) {
				s = "{\"auth\":\"Invalid username\"}";
			} else {

				boolean val = encodes.matches(pass, (String) li.get(0).get("password"));
				if (val == true) {
					List<Map<String, Object>> obj = repo.givedash(li);
					List<Map<String, Object>> userdata = repo.giveuserdetails(li);

					System.out.println("New Obj---> " + obj);
					System.out.println("New UserData--->" + userdata);

					session.setAttribute("userObj", obj);
					session.setAttribute("userdata", userdata);
					session.setAttribute("userData", li);

					s = "{\"auth\":\"Valid\"}";
				} else {
					s = "{\"auth\":\"Invalid password\"}";
				}

			}

			return s;
		} catch (Exception e) {
			s = "{\"auth\":\"error\"}";
			System.out.print(e.getMessage());
			return s;
		}

	}

	@GetMapping("/addattendance")
	public String addattendance() {

		String s = "";
		System.out.println("Method called for get");
		System.out.println(LocalTime.now());
		repo.addattendance();
		s = "{\"attendance\":\"success\"}";
		return s;
	}

	@PostMapping("/signout")
	public String signout(@RequestBody String data) {
		Gson g = new Gson();
		JsonObject j = g.fromJson(data, JsonObject.class);
		String id = j.get("aid").getAsString();

		String s = "";
		System.out.println("Method called for signout");
		System.out.println(id);

		repo.signout(id);
		s = "{\"signout\":\"signoutted\"}";
		return s;
	}

	@GetMapping("/logout")
	public String logedout() {
		String s = "";

		session.invalidate();
		s = "{\"logout\":\"success\"}";
		return s;
	}

	@GetMapping("/aftersignout")
	public String aftersignout() {
		Gson g = new Gson();
		String s = "";
		List<Map<String, Object>> li = repo.checkdatepresent();
		if (li.isEmpty()) {
			System.out.println("is empty");
			s = "{\"buttobj\":\"invalid\"}";
		} else {
			s = "{\"buttobj\":\"valid\"}";
		}
		return s;
	}

	@PostMapping("/nextmonth")
	public String nextmonth(@RequestBody String data) {
		Gson g = new Gson();
		JsonObject j = g.fromJson(data, JsonObject.class);
		String month = j.get("month").getAsString();
		String year = j.get("year").getAsString();
		System.out.println(month);
		System.out.println(year);

		int getmonth = Integer.parseInt(month);

		int getyearno = Integer.parseInt(year);

		List<Map<String, Object>> getabdate = repo.checkpresentabsent(getmonth, getyearno);
		System.out.println("Json--->" + getabdate);
		String json = g.toJson(getabdate);

		return json;
	}

	@PostMapping("/registerEmpdata")
	public String registerEmpdata(@RequestBody String data) {
		String s = "";
		Gson g = new Gson();
		JsonObject json = g.fromJson(data, JsonObject.class);
		String empname = json.get("empname").getAsString();
		String email = json.get("email").getAsString();
		String eid = json.get("eid").getAsString();
		String role = json.get("role").getAsString();
		String pass = json.get("pass").getAsString();

		System.out.println("Empname----  " + empname);

		try {

			boolean checkval = valid.checkvalidation(empname, email, eid);

			if (checkval == true) {

				int count = repo.findById(eid);
				if (count == 0) {
					List<Map<String, Object>> li = repo.findrole(role);
					repo.addEmpByhr(empname, email, eid, li, pass);
					s = "{\"registerEmp\":\"valid\"}";
				} else {
					s = "{\"registerEmp\":\"invalidid\"}";
				}
			} else {
				System.out.println("Validations false");
				s = "{\"registerEmp\":\"invalid\"}";
			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		return s;
	}

	@PostMapping("/approval")
	public String sendapproval(@RequestBody String data) throws ParseException {

		String s = "";
		Gson g = new Gson();
		JsonArray j = g.fromJson(data, JsonArray.class);
		System.out.println("Method called");
		try {

			for (int i = 0; i < j.size(); i++) {
				JsonObject json = j.get(i).getAsJsonObject();

				String starttime = json.get("startime").getAsString();
				;
				String endtime = json.get("endtime").getAsString();
				String reason = json.get("reason").getAsString();

				System.out.println("startime--- " + starttime.substring(0, 10));
				System.out.println("endtime--- " + endtime);
				System.out.println("reason--- " + reason);

				LocalTime sTime = LocalTime.parse(starttime.substring(11, starttime.length()));
				LocalTime etime = LocalTime.parse(endtime.substring(11, endtime.length()));

				List<Map<String, Object>> userdata = (List<Map<String, Object>>) session.getAttribute("userData");

				String eid = (String) userdata.get(0).get("eid");
				List<Map<String, Object>> obj = repo.loginvalid(eid);

				System.out.println("Approval obj --- " + obj.get(0).get("id"));
				long id = (long) obj.get(0).get("id");

				int k = repo.insertforapproval(sTime, etime, reason, starttime.substring(0, 10), id, eid);

				if (k > 0) {
					s = "{\"approvalresponse\":\"datagot\"}";
				}

			}
		} catch (Exception e) {
			s = "{\"approvalresponse\":\"error\"}";
		}

		return s;
	}

	@PostMapping("/approveddata")
	public String approveddata(@RequestBody String data) {
		String s = "";
		Gson g = new Gson();
		JsonArray json = g.fromJson(data, JsonArray.class);
		System.out.println("data got " + data);
		try {
			for (int i = 0; i < json.size(); i++) {
				JsonObject j = json.get(i).getAsJsonObject();

				String empid = j.get("empid").getAsString();
				String reason = j.get("reason").getAsString();
				LocalDate date = LocalDate.parse(j.get("dates").getAsString().trim());
				LocalTime start = LocalTime.parse(j.get("sttime").getAsString());
				LocalTime end = LocalTime.parse(j.get("edtime").getAsString());
				String status = j.get("status").getAsString();

				System.out.println("Hr approval data--- " + empid + reason + date + start + end + status);

				int count= repo.findcount(date, empid);

				System.out.println("show count---- " + count);

            if(status.equals("Pending")){
				if(count > 0){
		
		          repo.hrupdaterecord(empid, start, end, date);
		           repo.approvedupdate(date,empid);
				   s = "{\"approved\":\"success\"}";
				}else{
					repo.addapprovedattendance(empid, date, start, end);
					repo.approvedupdate(date,empid);
					s = "{\"approved\":\"success\"}";
				}

				System.out.println(empid + reason);
			}
			}
		} catch (Exception e) {
			s = "{\"approved\":\"error\"}";
		}

		return s;
	}

	@PostMapping("/empinfo")
	public String empinfo(@RequestBody String data) throws IOException{
       String s="";

	   	Gson g = new Gson();
		JsonObject json = g.fromJson(data, JsonObject.class);
		String phone= json.get("phone").getAsString();
		String email= json.get("email").getAsString();
		String adhar= json.get("adhar").getAsString();
		String eid = json.get("eid").getAsString();
		String ename = json.get("ename").getAsString();
		String place = json.get("place").getAsString();
		String b64image = json.get("base64img").getAsString();
		
		String base64Data = b64image.split(",")[1];
        System.out.println("b64img--- " + base64Data);
		byte[] img = Base64.getDecoder().decode(base64Data);

		String randomString = generateRandomString();
		String imagePath = "src/main/resources/static/files/profile" + randomString + ".jpg";

		Path path = Paths.get(imagePath);
        Files.write(path, img);
	
		String newimagepath= "/files/profile" + randomString + ".jpg";

		  System.out.println("img--- " + img);
	     LocalDate dates = LocalDate.parse(json.get("date").getAsString());

		 boolean val= valid.checkprofilevalidation(phone,email,adhar,ename,place);

		 if(val == true){
	     List<Map<String,Object>> logdetail= repo.loginvalid(eid);
		 long emp_id = (long)logdetail.get(0).get("id");

		 repo.updateEmp(emp_id,phone,email,adhar,ename,place,newimagepath,dates);

		 	s = "{\"empinfo\":\"success\"}";	
		 }else{
			s = "{\"empinfo\":\"invalid\"}";	
		 }
	
		
		return s;
	}

	private String generateRandomString() {
	return UUID.randomUUID().toString().replaceAll("-", "");
	}

	@PostMapping("/resetpass")
	public String empresetpass(@RequestBody String data){
		String s="";
          
		Gson g=new Gson();
		JsonObject json= g.fromJson(data,JsonObject.class);
		String user= json.get("user").getAsString();

		List<Map<String,Object>> li = repo.loginvalid(user);
		System.out.println("User List for reset " + li);
        if(!li.isEmpty()){
			long id=(long) li.get(0).get("id");
			String emails = (String)li.get(0).get("email");
              email.sendotp(id,emails);
			System.out.println("sucess");
			s = "{\"userpresent\":\"success\"}";
		}else{
         s = "{\"userpresent\":\"invalid\"}";
		}
		return s;	
	}
	
		@PostMapping("/checkotp")
	public String checkotp(@RequestBody String data){
		String s="";

		Gson g = new Gson();
		JsonObject json = g.fromJson(data, JsonObject.class);
		String users = json.get("user").getAsString();
		String otp = json.get("otp").getAsString();

		System.out.println("otp--- " + users + otp);

		List<Map<String,Object>> userdata = repo.loginvalid(users);
		int user= (int)userdata.get(0).get("id");
          
		int count;
		boolean otpval = valid.checkotpval(otp);
		if(otpval){
         List<Map<String,Object>> li = repo.checkotppresent(user,otp);  
		  if(li!=null){
				 int realotp =(int) li.get(0).get("count");
			if(realotp < 5 ){
				String otpmessage= (String)li.get(0).get("otp_status");
				if(otpmessage.equals("Expired")){
					  s = "{\"otp\":\"expired\"}";
				}else{
					 s = "{\"otp\":\"success\"}";
                 count=0;
                 repo.updatecountforotp(user,otp,count);
				}
            
			}else{

               
			}

		 } else{
			
				List<Map<String,Object>> otps= repo.getlatestotp(user);
				if(otps!=null){

					int getcount = (int)otps.get(0).get("count");
					if(otps.get(0).get("count") == null){
						getcount=0;
						
					}
					
				}
		 }   
		 
		}else{
         s = "{\"checkotp\":\"invalid\"}";
		}

		return s;
	}

	@PostMapping("/rejectdata")
	public String rejectdata(@RequestBody String data) {
		String s = "";
		Gson g = new Gson();
		JsonArray json = g.fromJson(data, JsonArray.class);

		System.out.println("rejected--- " + json);

		for (int i = 0; i < json.size(); i++) {
			JsonObject js = json.get(i).getAsJsonObject();
			String empid = js.get("empid").getAsString();
			String reason = js.get("reason").getAsString();
			LocalDate date = LocalDate.parse(js.get("dates").getAsString().trim());
			LocalTime start = LocalTime.parse(js.get("sttime").getAsString());
			LocalTime end = LocalTime.parse(js.get("edtime").getAsString());
			String status = js.get("status").getAsString();

			repo.rejecteddata(empid, date);

		}

		s = "{\"rejectemp\":\"valid\"}";
		return s;
	}

	@PostMapping("/automatesignout")
	public String automatesignout(@RequestBody String data) {
		String s="";
		Gson g=new Gson();

		JsonObject json= g.fromJson(data,JsonObject.class);
	

	//	LocalDate d= LocalDate.parse(json.get("date").getAsString());
		LocalTime t= LocalTime.parse(json.get("time").getAsString());
		
		List<Map<String,Object>> empid=
		(List<Map<String,Object>>)session.getAttribute("usernewobj");


		String emp=(String)empid.get(0).get("eid");

		try {
		repo.addautomatesignout(t,emp);
		
		s = "{\"automatesignout\":\"valid\"}";
		
		} catch (Exception e) {
			e.printStackTrace();

		s = "{\"automatesignout\":\"error\"}";
		}
		return s;
	}


	
		
	}


