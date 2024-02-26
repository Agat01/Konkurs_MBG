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

import mbg.javaee.encje.TypKlasy;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/typKlasy")
public class TypKlasySerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<TypKlasy> typyKlas = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		typyKlas.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		int id_rodzaj=0;
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			
			String sql="select id_typ_klasy,nazwa,id_rodzaj from typ_klasy order by id_typ_klasy";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					id_rodzaj=rs.getInt(3);
					typyKlas.add(new TypKlasy(id, nazwa,id_rodzaj));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(typyKlas);
        
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
		String id_typ_klasy = request.getParameter("id_typ_klasy");
		String nazwa = request.getParameter("nazwa");
		String id_rodzaj1 = request.getParameter("rodzaj");

		int id_rodzaj=0;
		if(id_rodzaj1!=null) {
	        String rodzaj=id_rodzaj1.split(", ", 2)[0];
	        id_rodzaj=Integer.parseInt(rodzaj);
			}
        int id=0;
        
        if(id_typ_klasy!=null) {
        	id=Integer.parseInt(id_typ_klasy);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into typ_klasy values(null,?,?)");
		stmt.setString(1, nazwa);
		stmt.setInt(2, id_rodzaj);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/typyKlas.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update typ_klasy set nazwa=?, id_rodzaj=? where id_typ_klasy=?");
    		stmt.setString(1, nazwa);
    		stmt.setInt(2, id_rodzaj);
    		stmt.setInt(3, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/typyKlas.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from typ_klasy where id_typ_klasy=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/typyKlas.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
