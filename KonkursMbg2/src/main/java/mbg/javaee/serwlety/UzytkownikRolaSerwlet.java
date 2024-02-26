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

import mbg.javaee.encje.UzytkownikRola;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/uzytkownikRola")
public class UzytkownikRolaSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<UzytkownikRola> uzytkownicyRole = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		uzytkownicyRole.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		int id_uzytkownik=0;
		int id_rola=0;
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_uzytkownik_rola, id_uzytkownik, id_rola from uzytkownik_rola";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					id_uzytkownik=rs.getInt(2);
					id_rola=rs.getInt(3);
					uzytkownicyRole.add(new UzytkownikRola(id, id_uzytkownik,id_rola));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(uzytkownicyRole);
        
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
		String id_uzytkownik_rola = request.getParameter("id_uzytkownik_rola");
		String id_rola1 = request.getParameter("rola");
		String id_uzytkownik1 = request.getParameter("uzytkownik");
//		out.println(id_uzytkownik1);
//		out.println(id_rola1);
		int id_uzytkownik=0;
		int id_rola=0;
		if(id_uzytkownik1!=null) {
		String uzytkownik=id_uzytkownik1.split(", ", 2)[0];
        id_uzytkownik=Integer.parseInt(uzytkownik);
		 }
		if(id_rola1!=null) {
        String rola=id_rola1.split(", ", 2)[0];
        id_rola=Integer.parseInt(rola);
		}
        int id=0;
        
        if(id_uzytkownik_rola!=null) {
        	id=Integer.parseInt(id_uzytkownik_rola);
        }
        
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into uzytkownik_rola values(null,?,?)");
		stmt.setInt(1, id_uzytkownik);
		stmt.setInt(2, id_rola);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/uzytkownicyRole.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update uzytkownik_rola set id_uzytkownik=?, id_rola=? where id_uzytkownik_rola=?");
			stmt.setInt(1, id_uzytkownik);
			stmt.setInt(2, id_rola);
    		stmt.setInt(3, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/uzytkownicyRole.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from uzytkownik_rola where id_uzytkownik_rola=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/uzytkownicyRole.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
