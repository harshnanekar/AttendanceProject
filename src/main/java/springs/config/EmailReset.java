package springs.config;

import java.util.Date;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import springs.repository.EmpRepo;

@Component
public class EmailReset {

 
    private JavaMailSender mails;
    
    @Autowired
    EmailReset(JavaMailSender mails){
    	this.mails=mails;
    }

     @Autowired
    private EmpRepo repo;

    @Value("${spring.mail.username}")
    private String mailid;

   

    public void sendotp(long id, String emails) {

     Random r=new Random();
    int otpnum= r.nextInt(99999);

        MimeMessagePreparator mime=new MimeMessagePreparator() {

		@Override
		public void prepare(MimeMessage mimeMessage) throws Exception {
			MimeMessageHelper message =new MimeMessageHelper(mimeMessage,false,"utf-8") ;
			message.setSubject("Reset Password Otp for portal");
			message.setSentDate(new Date());
			message.setFrom(mailid);
			message.setTo(emails);
			message.setText("Your otp for password reset is: " +   otpnum );
			
		
		
			}
		};


		this.mails.send(mime);

        System.out.println(otpnum + "new otp generated");

        String newotp= String.valueOf(otpnum);

        System.out.println(newotp + "string otp generated");
        repo.updateotp(id,newotp);
	
    }
    
}
