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

import mbg.javaee.encje.Wynik2;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/wynik")
public class WynikSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Wynik2> wyniki = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		wyniki.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		int wynik=0;
		int id_zadanie=0;
		int id_klasa=0;
		
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			String sql="select id_wynik, wynik, id_zadanie,id_klasa from wynik";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					wynik=rs.getInt(2);
					id_zadanie=rs.getInt(3);
					id_klasa=rs.getInt(4);
					wyniki.add(new Wynik2(id, wynik,id_zadanie,id_klasa));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(wyniki);
        
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
		String id_wynik = request.getParameter("id_wynik");
		String wynik1 = request.getParameter("wynik");
		String id_zadanie1 = request.getParameter("zadanie");
		String id_klasa1 = request.getParameter("klasa");
//		out.println(id_zadanie1);
//		out.println(id_region1);
		int wynik=0;
		if(wynik1!=null) {
		wynik=Integer.parseInt(wynik1);
		}
		int id_zadanie=0;
		if(id_zadanie1!=null) {
		String zadanie=id_zadanie1.split(", ", 2)[0];
		id_zadanie=Integer.parseInt(zadanie);
		 }
		int id_klasa=0;
		if(id_klasa1!=null) {
		String klasa=id_klasa1.split(", ", 2)[0];
		id_klasa=Integer.parseInt(klasa);
		 }
		
        int id=0;
        
        if(id_wynik!=null) {
        	id=Integer.parseInt(id_wynik);
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
        	conn = DatabaseConnectionManager.getConnection();
        
		if(metoda.equals("add")) {
		stmt = conn.prepareStatement("Insert into wynik values(null,?,?,?)");
		stmt.setInt(1, wynik);
		stmt.setInt(2, id_zadanie);
		stmt.setInt(3, id_klasa);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/wyniki.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			stmt = conn.prepareStatement("Update wynik set wynik=?, id_zadanie=?, id_klasa=? where id_wynik=?");
			stmt.setInt(1, wynik);
			stmt.setInt(2, id_zadanie);
			stmt.setInt(3, id_klasa);
    		stmt.setInt(4, id);
    		
    		if (stmt.executeUpdate() > 0) {
    			response.sendRedirect(request.getContextPath() + "/wyniki.jsp");  
    			conn.close();
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			stmt = conn.prepareStatement("Delete from wynik where id_wynik=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/wyniki.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} finally {
            // Zamknięcie połączenia
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
       
	}
}
