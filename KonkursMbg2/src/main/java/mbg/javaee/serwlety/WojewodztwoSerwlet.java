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
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mbg.javaee.encje.Wojewodztwo;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/wojewodztwo")
public class WojewodztwoSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Wojewodztwo> wojewodztwa = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		wojewodztwa.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_wojewodztwo,nazwa from wojewodztwo";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					wojewodztwa.add(new Wojewodztwo(id, nazwa));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(wojewodztwa);
        
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
		String id_wojewodztwo = request.getParameter("id_wojewodztwo");
		String nazwa = request.getParameter("nazwa");

        int id=0;
        
        if(id_wojewodztwo!=null) {
        	id=Integer.parseInt(id_wojewodztwo);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into wojewodztwo values(null,?)");
		stmt.setString(1, nazwa);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/wojewodztwa.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update wojewodztwo set nazwa=? where id_wojewodztwo=?");
    		stmt.setString(1, nazwa);
    		stmt.setInt(2, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/wojewodztwa.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from wojewodztwo where id_wojewodztwo=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/wojewodztwa.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
