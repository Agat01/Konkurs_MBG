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

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mbg.javaee.encje.Nauczyciel;
import mbg.javaee.encje.Uzytkownik;
import mbg.javaee.utils.AppUtils;
import mbg.javaee.utils.DatabaseConnectionManager;
import mbg.javaee.utils.UzytkownikDAO;

@WebServlet("/rejestracja")
public class RejestracjaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public RejestracjaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/strona.jsp");
		dispatcher.forward(request, response);
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
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		
		String[] rola = req.getParameterValues("rola");
		int liczba=rola.length;
		String nazwa_uzytkownika = req.getParameter("nazwa_uzytkownika");
		String haslo = req.getParameter("haslo");
		String haslo2 = req.getParameter("haslo2");
		String hashHaslo="";
		int idRola=0;
		int idUzytkownik=0;
		hashHaslo=getMd5(haslo);
		
		ArrayList<Integer> role = new ArrayList<Integer>();
		try {
			Connection conn = DatabaseConnectionManager.getConnection();
			
			Statement id_r = conn.createStatement();
			Statement id_u = conn.createStatement();
			
			for (int i = 0; i < liczba; i++) {
			id_r.execute("SELECT id_rola FROM rola where nazwa='" + rola[i] + "'");
			ResultSet rs = id_r.getResultSet();
			while (rs.next()) {
				idRola = rs.getInt(1);
				role.add(idRola);
			}
			}
			id_u.execute("SELECT uzytkownik_seq.NEXTVAL+1 as idUzytkownik FROM DUAL");
			ResultSet rs2 = id_u.getResultSet();
			while (rs2.next()) {
				idUzytkownik = rs2.getInt(1);
			}
			if (haslo.equals(haslo2)) {
				PreparedStatement stmt = conn.prepareStatement("Insert into uzytkownik values(null,?,?)");
				hashHaslo=getMd5(haslo);
				stmt.setString(1, nazwa_uzytkownika);
				stmt.setString(2, hashHaslo);
		//		stmt.setInt(3, idRola);
	
				if (stmt.executeUpdate() > 0) {

					res.getWriter().println("Dane logowania:");
					out.println(nazwa_uzytkownika);
					out.println(haslo);
					out.println(haslo2);
					out.println("hashHaslo:"+hashHaslo);
				} else
					res.getWriter().println("nie udało się");
				
				for (int i = 0; i < liczba; i++) {	
				PreparedStatement stmt2 = conn.prepareStatement("Insert into uzytkownik_rola values(null,?,?)");
				stmt2.setInt(1, idUzytkownik);
				stmt2.setInt(2, role.get(i));

				if (stmt2.executeUpdate() > 0) {
					res.sendRedirect(req.getContextPath() + "/admin.jsp");  
				} else
					res.getWriter().println("nie udało się");
				}
				
				
				conn.close();
		}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
}
