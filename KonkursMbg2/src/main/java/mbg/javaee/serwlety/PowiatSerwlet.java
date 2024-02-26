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

import mbg.javaee.encje.Powiat;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/powiat")
public class PowiatSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Powiat> powiaty = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		powiaty.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		int id_wojewodztwo=0;
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection(); 
			String sql="select id_powiat, nazwa, id_wojewodztwo from powiat";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					id_wojewodztwo=rs.getInt(3);
					powiaty.add(new Powiat(id, nazwa,id_wojewodztwo));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(powiaty);
        
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
		String id_powiat = request.getParameter("id_powiat");
		String nazwa = request.getParameter("nazwa");
		String id_wojewodztwo1 = request.getParameter("wojewodztwo");
//		out.println(id_wojewodztwo1);
//		out.println(id_region1);
		
		int id_wojewodztwo=0;
		if(id_wojewodztwo1!=null) {
		String wojewodztwo=id_wojewodztwo1.split(", ", 2)[0];
		id_wojewodztwo=Integer.parseInt(wojewodztwo);
		 }
		
        int id=0;
        
        if(id_powiat!=null) {
        	id=Integer.parseInt(id_powiat);
        }
        
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        	
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into powiat values(null,?,?)");
		stmt.setString(1, nazwa);
		stmt.setInt(2, id_wojewodztwo);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/powiaty.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update powiat set nazwa=?, id_wojewodztwo=? where id_powiat=?");
			stmt.setString(1, nazwa);
			stmt.setInt(2, id_wojewodztwo);
    		stmt.setInt(3, id);
    		
    		if (stmt.executeUpdate() > 0) {
    			response.sendRedirect(request.getContextPath() + "/powiaty.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from powiat where id_powiat=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/powiaty.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
