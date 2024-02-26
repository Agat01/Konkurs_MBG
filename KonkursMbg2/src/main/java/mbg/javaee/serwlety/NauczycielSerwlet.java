package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
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

import mbg.javaee.encje.Nauczyciel;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/nauczyciel")
public class NauczycielSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Nauczyciel> nauczyciele = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		nauczyciele.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String tytul="";
		String imie="";
		String nazwisko="";
		String email="";
		int id_szkola=0;
		String czy_koordynuje="";
		String nr_tel="";
		String komisja="";
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_nauczyciel,tytul,imie,nazwisko,email,id_szkola,czy_koordynuje,nr_tel,komisja from nauczyciel";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					tytul=rs.getString(2);
					imie=rs.getString(3);
					nazwisko=rs.getString(4);
					email=rs.getString(5);
					id_szkola=rs.getInt(6);
					czy_koordynuje=rs.getString(7);
					nr_tel=rs.getString(8);
					komisja=rs.getString(9);
					nauczyciele.add(new Nauczyciel(id, tytul,imie,nazwisko,email,id_szkola,czy_koordynuje,nr_tel,komisja));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(nauczyciele);
        
        out.print(json);
        out.flush();
	} catch (SQLException e) {
		e.printStackTrace();
	}	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		String metoda=request.getParameter("metoda");
		String id_nauczyciel = request.getParameter("id_nauczyciel");
		String tytul = request.getParameter("tytul");
		String imie = request.getParameter("imie");
        String nazwisko = request.getParameter("nazwisko");
        String email = request.getParameter("email");
        String id_szkola1 = request.getParameter("szkola");
        String czy_koordynuje = request.getParameter("czy_koordynuje");
        String nr_tel = request.getParameter("nr_tel");
        String komisja = request.getParameter("komisja");
  
        String szkola=id_szkola1.split(", ", 2)[0];
        int id_szkola=Integer.parseInt(szkola);
   //     out.println(id_szkola);
        int id=0;
    
        if(id_nauczyciel!=null) {
        	id=Integer.parseInt(id_nauczyciel);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        	
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into nauczyciel values(null,?,?,?,?,?,?,?,?)");
		stmt.setString(1, tytul);
		stmt.setString(2, imie);
		stmt.setString(3, nazwisko);
		stmt.setString(4, email);
		stmt.setInt(5, id_szkola);
		stmt.setString(6, czy_koordynuje);
		stmt.setString(7, nr_tel);
		stmt.setString(8, komisja);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/nauczyciele.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update nauczyciel set tytul=?, imie=?, nazwisko=?,email=?, id_szkola=?, czy_koordynuje=?, nr_tel=?,komisja=? where id_nauczyciel=?");
			stmt.setString(1, tytul);
			stmt.setString(2, imie);
			stmt.setString(3, nazwisko);
			stmt.setString(4, email);
			stmt.setInt(5, id_szkola);
			stmt.setString(6, czy_koordynuje);
			stmt.setString(7, nr_tel);
			stmt.setString(8, komisja);
			stmt.setInt(9, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/nauczyciele.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from nauczyciel where id_nauczyciel=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/nauczyciele.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
	
	}
}