package mbg.javaee.serwlety;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.google.gson.Gson;

import mbg.javaee.encje.Dyrektor;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/dyrektor")
public class DyrektorSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Dyrektor> dyrektorzy = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dyrektorzy.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String tytul="";
		String imie="";
		String nazwisko="";
		String email="";
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_dyrektor,tytul,imie,nazwisko,email from dyrektor";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					tytul=rs.getString(2);
					imie=rs.getString(3);
					nazwisko=rs.getString(4);
					email=rs.getString(5);
					dyrektorzy.add(new Dyrektor(id,tytul,imie,nazwisko,email));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(dyrektorzy);
        
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
		String id_dyrektor = request.getParameter("id_dyrektor");
		String tytul = request.getParameter("tytul");
		String imie = request.getParameter("imie");
        String nazwisko = request.getParameter("nazwisko");
        String email = request.getParameter("email");

        int id=0;
        
        if(id_dyrektor!=null) {
        	id=Integer.parseInt(id_dyrektor);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        	
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into dyrektor values(null,?,?,?,?)");
		stmt.setString(1, tytul);
		stmt.setString(2, imie);
		stmt.setString(3, nazwisko);
		stmt.setString(4, email);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/dyrektorzy.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update dyrektor set tytul=?, imie=?, nazwisko=?, email=? where id_dyrektor=?");
    		stmt.setString(1, tytul);
    		stmt.setString(2, imie);
    		stmt.setString(3, nazwisko);
    		stmt.setString(4, email);
    		stmt.setInt(5, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/dyrektorzy.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from dyrektor where id_dyrektor=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/dyrektorzy.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
