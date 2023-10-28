package springs.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmpRepo {
	
	@Autowired
	private JdbcTemplate template;
	
	@Autowired
	private HttpSession session;

	public List<Map<String, Object>> loginvalid(String log) {
		String sql="select * from employees where eid=?";
		return template.queryForList(sql,log);
	}

	public List<Map<String, Object>> givedash(List<Map<String, Object>> li) {
		
		String sql="select e.name,r.rolename,mo.moduleinfo,mo.url from module_map m inner join employees e on e.role_id=m.eid "
				+ "join modules mo on m.mid=mo.mid "
				+ "join roles r on r.rid=e.role_id where e.role_id= ? and e.active = true"
				+ " and mo.active= true and r.active= true and m.active = true ";
	
		return template.queryForList(sql,li.get(0).get("role_id"));
	}

	public List<Map<String, Object>> giveuserdetails(List<Map<String, Object>> li) {
		String sql="select e.name,r.rolename from employees e inner join roles r on e.role_id=r.rid where e.role_id=?"
				+ " and e.active=? and r.active=? ";
		return template.queryForList(sql,li.get(0).get("role_id"),true,true);
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
		
		String sql="select aid,date,starttime from dailyattendance where date=? and emp_id=?"
				+ " and endtime is null order by date desc limit 1;";
		return template.queryForList(sql,LocalDate.now(),li.get(0).get("eid"));
	}

	public List<Map<String, Object>> checkpresentabsent(int monthno, int year) {
		
		List<Map<String,Object>> li=(List<Map<String, Object>>) session.getAttribute("userData");

		String sql="select distinct(date) from dailyattendance where emp_id = ? "
				+ "  AND EXTRACT(YEAR FROM date) = ?"
				+ "  AND EXTRACT(MONTH FROM date) = ?";
		return template.queryForList(sql, li.get(0).get("eid"),year,monthno);
	}

}
