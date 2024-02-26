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

import mbg.javaee.encje.KlasaRegion;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/klasaRegion")
public class KlasaRegionSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<KlasaRegion> klasyRegion = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		klasyRegion.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		int id_klasa=0;
		int id_region=0;
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_klasa_region, id_klasa, id_region from klasa_region";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					id_klasa=rs.getInt(2);
					id_region=rs.getInt(3);
					klasyRegion.add(new KlasaRegion(id, id_klasa,id_region));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(klasyRegion);
        
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
		String id_klasa_region = request.getParameter("id_klasa_region");
		String id_region1 = request.getParameter("region");
		String id_klasa1 = request.getParameter("klasa");
//		out.println(id_klasa1);
//		out.println(id_region1);
		int id_klasa=0;
		int id_region=0;
		if(id_klasa1!=null) {
		String klasa=id_klasa1.split(", ", 4)[0];
        id_klasa=Integer.parseInt(klasa);
		 }
		if(id_region1!=null) {
        String region=id_region1.split(", ", 2)[0];
        id_region=Integer.parseInt(region);
		}
        int id=0;
        
        if(id_klasa_region!=null) {
        	id=Integer.parseInt(id_klasa_region);
        }
        
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into klasa_region values(null,?,?)");
		stmt.setInt(1, id_klasa);
		stmt.setInt(2, id_region);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/klasyRegion.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update klasa_region set id_klasa=?, id_region=? where id_klasa_region=?");
			stmt.setInt(1, id_klasa);
			stmt.setInt(2, id_region);
    		stmt.setInt(3, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/klasyRegion.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from klasa_region where id_klasa_region=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/klasyRegion.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}

