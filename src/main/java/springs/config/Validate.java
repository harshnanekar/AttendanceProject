package springs.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Validate {

    @Autowired
    private Validate v;
  
    public boolean checkvalidation(String fname,String email,String empid){
    boolean valid=false;
     
    boolean fnamevalid = v.fnamevalid(fname);
    boolean employeeid= v.checkempid(empid);
    boolean mailvalid= v.checkmailvalidity(email);

    if(fnamevalid == true && employeeid==true && mailvalid == true){
        valid=true;
    }

    return valid;
    }

    public boolean fnamevalid(String fname){
        boolean valid=true;
      outer:  for(int i=0;i<fname.length();i++){
            int j= (int)fname.charAt(i);
            if(j >= 65 && j<=90 || j>=97 && j<=122 || j == 32){
              valid=true;
            }else{
             valid=false;
             break outer;
            }
        }

        return valid;
    }

    public boolean checkempid(String empid){
        boolean valid=false;

        String num= empid.substring(2,empid.length());
        String caps= empid.substring(0, 2);
        boolean fornum= v.checknum(num);
        boolean forcaps= v.checkcaps(caps);

        if(fornum==true && forcaps==true){
            valid=true;
        }
        
        return valid;
    }

    public boolean checknum(String num){
        boolean val=true;
      outer: for(int i=0;i<num.length();i++){
         int j= (int)num.charAt(i);
        if(j >=48 && j<=57){
           val=true;
        }else{
          val=false;
          break outer;
        }
       }
        return val;
    }

     public boolean checkcaps(String num){
      boolean val=true;
      outer: for(int i=0;i<num.length();i++){
         int j= (int)num.charAt(i);
        if(j >=65 && j<=90){
           val=true;
        }else{
          val=false;
          break outer;
        }
       }

     return val;
     }

     public boolean checkmailvalidity(String email) {
         boolean valid = true;
         int count = 0;

         for (int i = 0; i < email.length(); i++) {
             if (count <= 1) {
                 if ("@".equals("" + email.charAt(i))) {
                     count++;
                 }
             }
         }
         if (count == 0 && count > 1) {
             valid = false;
         } else {
             int attherateindex = email.indexOf("@");
             int countdot = 0;
             for (int j = attherateindex; j < email.length(); j++) {
                 if (countdot <= 1) {
                     if (".".equals("" + email.charAt(j))) {
                        countdot++;
                     }
                 }
             }

             if(countdot==0 && countdot>1){
                int dotindex=email.indexOf(".");

                if(attherateindex + 1 == dotindex){
                    valid=false;
                }else{
                    valid=true;
                }

                if(attherateindex == 0){
                    valid=false;
                }else{
                    valid=true;
                }

                if(dotindex == email.length()-1){
                    valid=false;
                }else{
                    valid=true;
                }
            
            }

         }

        return valid;
     }

    public boolean checkprofilevalidation(String phone, String email, String adhar, String ename, String place) {
       boolean valid=false;

       boolean nameval = fnamevalid(ename);
       boolean placeval= fnamevalid(place);
       boolean adharval= checkadhar(adhar);
       boolean phoneval = checkphone(phone);
       boolean emailval= checkmailvalidity(email);

       if(nameval==true && placeval==true && adharval==true && phoneval==true && emailval==true){
        valid=true;
       }


        return valid;
    }

    private boolean checkphone(String phone) {
        boolean val=false;
        
        if(phone.length() == 10){
         boolean valid = checknum(phone);
         val = valid;
        }
        return val;
    }

    private boolean checkadhar(String adhar) {
        boolean val=false;
        
        if(adhar.length() == 12){
         boolean valid = checknum(adhar);
         val = valid;
        }
        return val;
    }

    public boolean checkotpval(String otp) {
        boolean valid=checknum(otp);

        return valid;
    }

}
