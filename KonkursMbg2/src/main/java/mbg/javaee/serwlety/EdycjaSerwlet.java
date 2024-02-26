package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

import mbg.javaee.encje.Edycja;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/edycja")
public class EdycjaSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Edycja> edycje = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		edycje.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		String url="";
		String active="";
		String wszystkieWyniki="";
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_edycja,nazwa,url,active,wszystkieWyniki from edycja";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					url=rs.getString(3);
					active=rs.getString(4);
					wszystkieWyniki=rs.getString(5);
					edycje.add(new Edycja(id, nazwa,url,active,wszystkieWyniki));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(edycje);
        
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
		String id_edycja = request.getParameter("id_edycja");
		String nazwa = request.getParameter("nazwa");
		String url = request.getParameter("url");
        String active = request.getParameter("active");
        String wszystkieWyniki = request.getParameter("wszystkieWyniki");

        int id=0;
    
        if(id_edycja!=null) {
        	id=Integer.parseInt(id_edycja);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        	
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into edycja values(null,?,?,?,?)");
		stmt.setString(1, nazwa);
		stmt.setString(2, url);
		stmt.setString(3, active);
		stmt.setString(4, wszystkieWyniki);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/edycje.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update edycja set nazwa=?, url=?, active=?, wszystkieWyniki=? where id_edycja=?");
			stmt.setString(1, nazwa);
			stmt.setString(2, url);
			stmt.setString(3, active);
			stmt.setString(4, wszystkieWyniki);
			stmt.setInt(5, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/edycje.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from edycja where id_edycja=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/edycje.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
	
	}
}