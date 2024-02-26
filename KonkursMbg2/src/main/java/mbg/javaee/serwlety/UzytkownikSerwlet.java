package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mbg.javaee.encje.Uzytkownik;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/uzytkownik")
public class UzytkownikSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Uzytkownik> uzytkownicy = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		uzytkownicy.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		String haslo="";
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_uzytkownik,nazwa_uzytkownika,haslo from uzytkownik";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					haslo=rs.getString(3);
					uzytkownicy.add(new Uzytkownik(id, nazwa,haslo));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(uzytkownicy);
        
        out.print(json);
        out.flush();
	} catch (SQLException e) {
		e.printStackTrace();
	}	
	}
	
	public static String getMd5(String input)
    {
        try {
 
            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
 
            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());
 
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
 
            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
 
        // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		String metoda=request.getParameter("metoda");
		String id_uzytkownik = request.getParameter("id_uzytkownik");
		String nazwa = request.getParameter("nazwa");
		String haslo = request.getParameter("haslo");
		String hashHaslo="";
		if(haslo!=null) {
		hashHaslo=getMd5(haslo);
		}
        int id=0;
        
        if(id_uzytkownik!=null) {
        	id=Integer.parseInt(id_uzytkownik);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into uzytkownik values(null,?,?)");
		stmt.setString(1, nazwa);
		stmt.setString(2, hashHaslo);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/uzytkownicy.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update uzytkownik set nazwa_uzytkownika=?, haslo=? where id_uzytkownik=?");
    		stmt.setString(1, nazwa);
    		stmt.setString(2, hashHaslo);
    		stmt.setInt(3, id);
    		
    		if (stmt.executeUpdate() > 0) {
    			response.sendRedirect(request.getContextPath() + "/uzytkownicy.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from uzytkownik where id_uzytkownik=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/uzytkownicy.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
