package mbg.javaee;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.util.Properties;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.io.File;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class WyslijEmailzZalacznikiem {
	/*
	public static Date parseDate(String date) {
	     try {
	         return new SimpleDateFormat("yyyy-MM-dd").parse(date);
	     } catch (ParseException e) {
	         return null;
	     }
	  }
	  */
	
	public static void sendEmail(String host, String port,
            final String userName, final String password, String[] toAddresses,
            String subject, String message, List<File> attachedFiles) throws AddressException,
            MessagingException, ParseException {
 
        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
 
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
 
        Session session = Session.getInstance(properties, auth);
        
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
    	String dateInString = "06-03-2023 20:48:01";
    	Date sentDate = sdf.parse(dateInString);
 
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] recipients = new InternetAddress[toAddresses.length];
        for (int i = 0; i < toAddresses.length; i++) {
            recipients[i] = new InternetAddress(toAddresses[i]);
        }
        msg.setRecipients(Message.RecipientType.BCC, recipients);

        msg.setSubject(subject);
        msg.setSentDate(sentDate);
        
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
 
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
 
        // adds attachments
        if (attachedFiles != null && attachedFiles.size() > 0) {
            for (File aFile : attachedFiles) {
                MimeBodyPart attachPart = new MimeBodyPart();
 
                try {
                    attachPart.attachFile(aFile);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
 
                multipart.addBodyPart(attachPart);
            }
        }
 
        // sets the multi-part as e-mail's content
        msg.setContent(multipart);
    	
        // sends the e-mail
        Transport.send(msg);
 
 
    }
}
