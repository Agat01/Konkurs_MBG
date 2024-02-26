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

import mbg.javaee.encje.Szkola;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/szkolaT")
public class SzkolaTSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Szkola> szkoly = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		szkoly.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String miejscowosc="";
		String nazwa="";
		String nazwa_zespolu_szkol="";
		String imienia="";
		String nr_tel="";
		String email="";
		int id_dyrektor=0;
		int id_powiat=0;
		String ulica="";
		String nr_domu="";
		String kod_pocztowy="";
		String miejscowosc2="";
		String active="";
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			
			String sql="select * from szkola";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					miejscowosc=rs.getString(2);
					nazwa_zespolu_szkol=rs.getString(3);
					nazwa=rs.getString(4);
					imienia=rs.getString(5);
					nr_tel=rs.getString(6);
					email=rs.getString(7);
					id_dyrektor=rs.getInt(8);
					id_powiat=rs.getInt(9);
					ulica=rs.getString(10);
					nr_domu=rs.getString(11);
					kod_pocztowy=rs.getString(12);
					miejscowosc2=rs.getString(13);
					active=rs.getString(14);
					szkoly.add(new Szkola(id,miejscowosc,nazwa_zespolu_szkol,nazwa,imienia,nr_tel,email,id_dyrektor,id_powiat,ulica,nr_domu,kod_pocztowy,miejscowosc2,active));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(szkoly);
        
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
		String id_szkola = request.getParameter("id_szkola");
		String miejscowosc=request.getParameter("miejscowosc");
		String nazwa_zespolu_szkol=request.getParameter("nazwa_zespolu_szkol");
		String nazwa=request.getParameter("nazwa");
		String imienia=request.getParameter("imienia");
		String nr_tel=request.getParameter("nr_tel");
		String email=request.getParameter("email");
		String dyrektor=request.getParameter("dyrektor");
		String powiat=request.getParameter("powiat");
		String ulica=request.getParameter("ulica");
		String nr_domu=request.getParameter("nr_domu");
		String kod_pocztowy=request.getParameter("kod_pocztowy");
		String miejscowosc2=request.getParameter("miejscowosc2");
		String active=request.getParameter("act");
    /*    
		out.println(metoda);
		out.println(id_szkola);
		out.println(miejscowosc);
		out.println(nazwa);
		out.println(dyrektor);
		out.println(powiat);
    */  
   //     String[] arrOfStr = nauczyciel.split(", ", 2);
		
		
        String dyr=dyrektor.split(", ", 2)[0];
        int id_dyrektor=Integer.parseInt(dyr);
    //    out.println(id_dyrektor);
        String pow=powiat.split(", ", 2)[0];
        int id_powiat=Integer.parseInt(pow);
    //    out.println(id_powiat);
        int id=0;
        
        if(id_szkola!=null) {
        	id=Integer.parseInt(id_szkola);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
        	
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into szkola values(null,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		stmt.setString(1, miejscowosc);
		stmt.setString(2, nazwa_zespolu_szkol);
		stmt.setString(3, nazwa);
		stmt.setString(4, imienia);
		stmt.setString(5, nr_tel);
		stmt.setString(6, email);
		stmt.setInt(7, id_dyrektor);
		stmt.setInt(8, id_powiat);
		stmt.setString(9, ulica);
		stmt.setString(10, nr_domu);
		stmt.setString(11, kod_pocztowy);
		stmt.setString(12, miejscowosc2);
		stmt.setString(13, active);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/szkoly.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update szkola set miejscowosc=?, nazwa_zespolu_szkol=?, nazwa=?, imienia=?, nr_tel=?, email=?, id_dyrektor=?, id_powiat=?, ulica=?, nr_domu=?, kod_pocztowy=?, miejscowosc2=?, active=? where id_szkola=?");
			stmt.setString(1, miejscowosc);
			stmt.setString(2, nazwa_zespolu_szkol);
			stmt.setString(3, nazwa);
			stmt.setString(4, imienia);
			stmt.setString(5, nr_tel);
			stmt.setString(6, email);
			stmt.setInt(7, id_dyrektor);
			stmt.setInt(8, id_powiat);
			stmt.setString(9, ulica);
			stmt.setString(10, nr_domu);
			stmt.setString(11, kod_pocztowy);
			stmt.setString(12, miejscowosc2);
			stmt.setString(13, active);
    		stmt.setInt(14, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/szkoly.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from szkola where id_szkola=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/szkoly.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}
