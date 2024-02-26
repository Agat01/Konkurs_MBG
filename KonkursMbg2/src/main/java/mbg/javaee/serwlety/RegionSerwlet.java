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

import mbg.javaee.encje.Region;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/region")
public class RegionSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Region> regiony = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		regiony.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		String adres1="";
		String ulica="";
		String nr_domu="";
		String kod_pocztowy="";
		String miejscowosc="";
		String przewodniczacy="";
		String email="";
		String nr_tel="";
		String www="";
		String z_dopiskiem="";
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_region,nazwa,adres1,ulica,nr_domu,kod_pocztowy,miejscowosc,przewodniczacy,email,nr_tel,www,z_dopiskiem from region";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					adres1=rs.getString(3);
					ulica=rs.getString(4);
					nr_domu=rs.getString(5);
					kod_pocztowy=rs.getString(6);
					miejscowosc=rs.getString(7);
					przewodniczacy=rs.getString(8);
					email=rs.getString(9);
					nr_tel=rs.getString(10);
					www=rs.getString(11);
					z_dopiskiem=rs.getString(12);
					regiony.add(new Region(id, nazwa,adres1,ulica,nr_domu,kod_pocztowy,miejscowosc,przewodniczacy,email,nr_tel,www,z_dopiskiem));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(regiony);
        
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
		String id_region = request.getParameter("id_region");
		String nazwa = request.getParameter("nazwa");
		String adres1=request.getParameter("adres1");
		String ulica=request.getParameter("ulica");
		String nr_domu=request.getParameter("nr_domu");
		String kod_pocztowy=request.getParameter("kod_pocztowy");
		String miejscowosc=request.getParameter("miejscowosc");
		String przewodniczacy=request.getParameter("przewodniczacy");
		String email=request.getParameter("email");
		String nr_tel=request.getParameter("nr_tel");
		String www=request.getParameter("www");
		String z_dopiskiem=request.getParameter("z_dopiskiem");

        int id=0;
        
        if(id_region!=null) {
        	id=Integer.parseInt(id_region);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into region values(null,?,?,?,?,?,?,?,?,?,?,?)");
		stmt.setString(1, nazwa);
		stmt.setString(2, adres1);
		stmt.setString(3, ulica);
		stmt.setString(4, nr_domu);
		stmt.setString(5, kod_pocztowy);
		stmt.setString(6, miejscowosc);
		stmt.setString(7, przewodniczacy);
		stmt.setString(8, email);
		stmt.setString(9, nr_tel);
		stmt.setString(10, www);
		stmt.setString(11, z_dopiskiem);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/regiony.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update region set nazwa=?, adres1=?, ulica=?, nr_domu=?, kod_pocztowy=?, miejscowosc=?, przewodniczacy=?, email=?, nr_tel=?, www=?, z_dopiskiem=? where id_region=?");
    		stmt.setString(1, nazwa);
    		stmt.setString(2, adres1);
			stmt.setString(3, ulica);
			stmt.setString(4, nr_domu);
			stmt.setString(5, nr_tel);
			stmt.setString(6, miejscowosc);
			stmt.setString(7, przewodniczacy);
			stmt.setString(8, email);
			stmt.setString(9, nr_tel);
			stmt.setString(10, www);
			stmt.setString(11, z_dopiskiem);
    		stmt.setInt(12, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/regiony.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from region where id_region=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/regiony.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}

