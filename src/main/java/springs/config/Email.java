package springs.config;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import java.util.Date;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

@Component
public class Email {

   
    private JavaMailSender mails;
    
    @Autowired
    Email(JavaMailSender mails){
    	this.mails=mails;
    }

    @Value("${spring.mail.username}")
    private String mailid;

	public void sendmail(String emails, String pass, String empname, String eid) {
	
	MimeMessagePreparator mime=new MimeMessagePreparator() {

		@Override
		public void prepare(MimeMessage mimeMessage) throws Exception {
			MimeMessageHelper message =new MimeMessageHelper(mimeMessage,false,"utf-8") ;
			message.setSubject("LoginId and Password for portal");
			message.setSentDate(new Date());
			message.setFrom(mailid);
			message.setTo(emails);
			message.setText("Hello.. " + empname + " your loginid for portal logging is " + eid   );
			
			
		
			}
		};
		this.mails.send(mime);
	
	
	}
  
}

