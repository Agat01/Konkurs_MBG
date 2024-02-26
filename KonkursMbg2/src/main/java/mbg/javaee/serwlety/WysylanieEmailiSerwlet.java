package mbg.javaee.serwlety;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.ParseException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import mbg.javaee.WyslijEmailzZalacznikiem;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/wysylanieEmaili")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
maxFileSize = 1024 * 1024 * 10,         // 10MB
maxRequestSize = 1024 * 1024 * 50)		// 50MB
public class WysylanieEmailiSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String host;
    private String port;
    private String user;
    private String pass;

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		/*
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/wysylanieEmaili.jsp");
		dispatcher.forward(req, res);
		*/
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String data=req.getParameter("data");
        String godzina=req.getParameter("godzina");
        Timer timer = new Timer();

		Calendar date = Calendar.getInstance();
		date.set(Calendar.YEAR, Integer.parseInt(data.substring(0, 4)));
		date.set(Calendar.MONTH, Integer.parseInt(data.substring(5, 7)) - 1);
		date.set(Calendar.DATE, Integer.parseInt(data.substring(8)));
		date.set(Calendar.HOUR_OF_DAY, Integer.parseInt(godzina.substring(0, 2)));
		date.set(Calendar.MINUTE, Integer.parseInt(godzina.substring(3)));
		date.set(Calendar.SECOND, 0);
		date.set(Calendar.MILLISECOND, 0);
		
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		String host = "smtp.gmail.com";
		  final String user = "konkurs@email.com";// change accordingly
		  final String pass = "xxx";// change accordingly
		  String port = "000";
		  
		List<File> uploadedFiles = saveUploadedFiles(req);
		String lista = req.getParameter("lista").trim();
        String subject = req.getParameter("temat");
        String content = req.getParameter("tresc");

        String recipients = req.getParameter("lista").trim();
        String[] recipientsArray = recipients.split(",");
        
        
        timer.scheduleAtFixedRate(
    		    new TimerTask() {
    		        @Override
    		        public void run() {
    		        	try {
							WyslijEmailzZalacznikiem.sendEmail(host, port, user, pass, recipientsArray, subject,
							        content, uploadedFiles);
						} catch (AddressException e) {
							e.printStackTrace();
						} catch (MessagingException e) {
							e.printStackTrace();
						} catch (java.text.ParseException e) {
							e.printStackTrace();
						}
    		    		out.println("task is running........"+new Date());
    		        }
    		    },
    		    date.getTime(),
    		    1000 * 60 * 60 * 24);
    	
    	deleteUploadFiles(uploadedFiles);
 //      req.setAttribute("message", resultMessage);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/wysylanieEmaili.jsp");
		dispatcher.forward(req, res);
    }
    
	private List<File> saveUploadedFiles(HttpServletRequest request)
            throws IllegalStateException, IOException, ServletException {
        List<File> listFiles = new ArrayList<File>();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        Collection<Part> multiparts = request.getParts();
        if (multiparts.size() > 0) {
            for (Part part : request.getParts()) {
                // creates a file to be saved
                String fileName = extractFileName(part);
                if (fileName == null || fileName.equals("")) {
                    // not attachment part, continue
                    continue;
                }
                String savePath = "C:/mbg";
                File saveFile = new File(savePath + File.separator + fileName); 

                System.out.println("saveFile: " + saveFile.getAbsolutePath());
                FileOutputStream outputStream = new FileOutputStream(saveFile);
                 
                // saves uploaded file
                InputStream inputStream = part.getInputStream();
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.close();
                inputStream.close();
                 
                listFiles.add(saveFile);
            }
        }
        return listFiles;
    }
 
    /**
     * Retrieves file name of a upload part from its HTTP header
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
     
    /**
     * Deletes all uploaded files, should be called after the e-mail was sent.
     */
    private void deleteUploadFiles(List<File> listFiles) {
        if (listFiles != null && listFiles.size() > 0) {
            for (File aFile : listFiles) {
                aFile.delete();
            }
        }
    }
}
