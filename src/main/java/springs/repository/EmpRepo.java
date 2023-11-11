package springs.repository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import springs.config.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

@Repository
public class EmpRepo {
	
	@Autowired
	private JdbcTemplate template;

	@Autowired
	private Email email;
	
	@Autowired
	private BCryptPasswordEncoder encode;
	
	@Autowired
	private HttpSession session;

	public List<Map<String, Object>> loginvalid(String log) {
		String sql="select * from employees where eid=?";
		return template.queryForList(sql,log);
	}

	public List<Map<String, Object>> givedash(List<Map<String, Object>> li) {
		
		String sql="select e.name,r.rolename,mo.moduleinfo,mo.url from module_map m inner join employees e on e.role_id=m.eid "
				+ "join modules mo on m.mid=mo.mid "
				+ "join roles r on r.rid=e.role_id where e.role_id= ? and e.eid=? and e.active = true"
				+ " and mo.active= true and r.active= true and m.active = true ";
	
		return template.queryForList(sql,li.get(0).get("role_id"),li.get(0).get("eid"));
	}

	public List<Map<String, Object>> giveuserdetails(List<Map<String, Object>> li) {
		String sql="select e.name,r.rolename from employees e inner join roles r on e.role_id=r.rid where e.role_id=? and e.eid=?"
				+ " and e.active=? and r.active=? ";
		return template.queryForList(sql,li.get(0).get("role_id"),li.get(0).get("eid"),true,true);
	}

	public void addattendance() {
		

		
		List<Map<String, Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");
		
		try {
		
		String sql="insert into dailyattendance(date,starttime,createdby,modifiedby,modifieddate,"
				+ " createddate,active,emp_id) values (?,?,?,?,?,?,?,?)";
		template.update(sql, LocalDate.now(),LocalTime.now(),li.get(0).get("id"),li.get(0).get("id"), LocalDate.now(),
				 LocalDate.now(), true ,li.get(0).get("eid"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	public void signout(String id) {
		List<Map<String, Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");
		
		try {
			
		String sql="update dailyattendance set endtime=? where aid=? ";
		template.update(sql,LocalTime.now(),Integer.parseInt(id));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	public List<Map<String, Object>> checkdatepresent() {
		
		List<Map<String,Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");
		System.out.println("Obj---> " + li);
		session.setAttribute("usernewobj",li);
		
		String sql="select aid,date,starttime from dailyattendance where date=? and emp_id=?"
				+ " and endtime is null order by date desc limit 1;";
		return template.queryForList(sql,LocalDate.now(),li.get(0).get("eid"));
	}

	public List<Map<String, Object>> checkpresentabsent(int monthno, int year) {
		
		List<Map<String,Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");

		String sql="select distinct date,starttime,endtime from dailyattendance where emp_id = ? "
				+ "  AND EXTRACT(YEAR FROM date) = ?"
				+ "  AND EXTRACT(MONTH FROM date) = ?";
		return template.queryForList(sql, li.get(0).get("eid"),year,monthno);
	}

	public List<Map<String, Object>> getallroles() {
		String sql="select rolename from roles where active=true ";
		return template.queryForList(sql);
	}

	public List<Map<String, Object>> findrole(String role) {

		System.out.println("Specific role--- " + role);
		String sql="select rid from roles where rolename=? and active=true ";
		return template.queryForList(sql,role);
	}

	public void addEmpByhr(String empname,String emails,String eid,List<Map<String, Object>> li,String pass){
		
   List<Map<String,Object>> lis= (List<Map<String,Object>> )session.getAttribute("userData");
    System.out.println("User list object-----" + lis);

   int rolekey= (int)lis.get(0).get("role_id");
    
	  
	   System.out.println("getrole---> " + lis);
	  
		String passencode= encode.encode(pass);

		System.out.println("This method called--- " + li.get(0).get("rid"));
		String sql= "insert into employees(name,email,eid,role_id,password,createdby,modifiedby,createddate,modifieddate,active) values (?,?,?,?,?,?,?,?,?,?)";
      template.update(sql,empname, emails,eid,li.get(0).get("rid"),passencode,rolekey,rolekey,LocalDate.now(),LocalDate.now(),true);
	    email.sendmail(emails,pass,empname,eid);
	}

	public int findById(String eid){
		String sql="select count(*) from employees where eid=? and active= true";
		return  template.queryForObject(sql, Integer.class, eid);
	}

    public int insertforapproval(LocalTime sTime, LocalTime etime, String reason, String reasondate,long id,String eid) throws ParseException {
    LocalDate d=LocalDate.parse(reasondate,DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
	String sql="insert into approval(empid,date,starttime,endtime,reason,createddate,modifieddate,createdby,modifiedby,active,status) values (?,?,?,?,?,?,?,?,?,?,'Pending') ";
 return template.update(sql, eid,d, sTime,etime,reason,LocalDate.now(),LocalDate.now(),id,id,true);
   
    }

	public List<Map<String,Object>> fetchforapprove(){
	String sql="select date,empid,starttime,endtime,reason,status from approval where status='Completed' and active= true";
	return template.queryForList(sql);
	}

	public void addapprovedattendance(String empid, LocalDate date, LocalTime start, LocalTime end) {

			List<Map<String, Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");

		String sql="insert into dailyattendance(date,starttime,endtime,createdby,modifiedby,modifieddate,"
				+ " createddate,active,emp_id) values (?,?,?,?,?,?,?,?,?)";
      template.update(sql, date,start,end,li.get(0).get("id"),li.get(0).get("id"),LocalDate.now(),LocalDate.now(),
      true,empid);
	}

	public void approvedupdate(LocalDate date, String empid) {
    String sql="update approval set status='Completed' where date=? and empid=?";
	template.update(sql,date,empid);
	
	}

	public List<Map<String, Object>> fetchempapprovedata(String empid) {
		String sql="select empid,date,starttime,endtime,reason,status from approval where empid=? and active=true";
		return template.queryForList(sql,empid);
	}

    public List<Map<String, Object>> findbyId(int id) {
        String sql="select id,name,email,eid,phone,dob,place,adharno,photo from employees where id=?";
		return template.queryForList(sql,id);
    }

	public int findcount(LocalDate date, String empid) {

		String sql="select count(*) from dailyattendance where emp_id=? and date= ? ";
		return template.queryForObject(sql,Integer.class,empid,date);
	}

	public void hrupdaterecord(String empid, LocalTime start, LocalTime end, LocalDate date) {
			System.out.println("update method called");
		String sql="update dailyattendance set starttime=?,endtime=?,modifieddate=? where emp_id=? and date=?";
		template.update(sql,start,end,LocalDate.now(),empid,date);
	}

	public void updateotp(long id, String newotp) {
		String sql="insert into otp(otp,otptime,createdby,modifiedby,createddate,modifieddate,active,empid)" +
		" values (?,?,?,?,?,?,?,?)";
		template.update(sql,newotp,LocalTime.now(),id,id,LocalDate.now(),LocalDate.now(),true,id);
	}

	public List<Map<String, Object>> fetchforpending() {
		String sql="select date,empid,starttime,endtime,reason,status from approval where status='Pending' and active= true";
	return template.queryForList(sql);
	}

	public void rejecteddata(String empid, LocalDate date) {
		 String sql="update approval set status='Rejected' where date=? and empid=?";
	template.update(sql,date,empid);
	
	}

	public List<Map<String, Object>> rejectedstatus() {
		String sql="select date,empid,starttime,endtime,reason,status from approval where status='Rejected' and active= true";
	return template.queryForList(sql);
	}

    public List<Map<String, Object>> empapplication(String emp, String status) {

		System.out.println("dao --- " + status + emp);
		String sql="select * from approval where status=? and empid=?";
        return template.queryForList(sql,status,emp);
    }

	public void addautomatesignout(LocalTime t,String emp) {

		String sql="update dailyattendance set endtime=? where emp_id=? and date=?";
		template.update(sql,t,emp,LocalDate.now());
	}

	public void updateEmp(long emp_id, String phone, String email2, String adhar, String ename, String place,
			String imagePath, LocalDate date) {
      String sql="update employees set name=?,email=?,phone=?,dob=?,place=?,adharno=?,photo=?,modifieddate=? where id=?";

	  template.update(sql, ename,email2,phone,date,place,adhar,imagePath,LocalDate.now(),emp_id);

	}

	public List<Map<String, Object>> checkotppresent(int user, String otp) {
		String sql="select * CASE WHEN TIMESTAMPDIFF(MINUTE, otptime, NOW()) <= 5 THEN 'Valid'	ELSE 'Expired' END AS otp_status FROM otp WHERE empid = ? and otp=? and createddate=? order by otptime desc limit 1";
		return template.queryForList(sql, user, otp, LocalDate.now());
	}

	public void updatecountforotp(int user, String otp, int count) {
     String sql="update otp set count=? where empid=? and otp=?";
	 template.update(sql, count,user,otp);
	}

	public List<Map<String, Object>> getlatestotp(int user) {
		String sql="select * from otp where empid=? and createddate='2023-11-11' order by otptime desc limit 1";
		return template.queryForList(sql,user);
	}

}
