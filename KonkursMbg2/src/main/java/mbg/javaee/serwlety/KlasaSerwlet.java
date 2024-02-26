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

import mbg.javaee.encje.Klasa2;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/klasa")
public class KlasaSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
private List<Klasa2> klasy = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		klasy.clear();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		int id=0;
		String nazwa="";
		int liczba_uczniow=0;
		int pref_jezyk=0;
		int id_szkola=0;
		int id_typ_klasy=0;
		int id_nauczyciel=0;
		int id_edycja=0;
		try {
			
			Connection conn = DatabaseConnectionManager.getConnection();
			
			String sql="select id_klasa,nazwa,liczba_uczniow,pref_jezyk,id_szkola, id_typ_klasy, id_nauczyciel, id_edycja from klasa";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()) {
					id=rs.getInt(1);
					nazwa=rs.getString(2);
					liczba_uczniow=rs.getInt(3);
					pref_jezyk=rs.getInt(4);
					id_szkola=rs.getInt(5);
					id_typ_klasy=rs.getInt(6);
					id_nauczyciel=rs.getInt(7);
					id_edycja=rs.getInt(8);
					klasy.add(new Klasa2(id, nazwa,liczba_uczniow,pref_jezyk,id_szkola,id_typ_klasy,id_nauczyciel,id_edycja));
				}
			
		Gson gson = new Gson();
        String json = gson.toJson(klasy);
        
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
		String id_klasa = request.getParameter("id_klasa");
		String nazwa = request.getParameter("nazwa");
		String liczba_uczniow1 = request.getParameter("liczba_uczniow");
        String pref_jezyk1 = request.getParameter("pref_jezyk");
        String id_szkola1 = request.getParameter("szkola");
        String id_typ_klasy1 = request.getParameter("typ_klasy");
        String nauczyciel = request.getParameter("nauczyciel");
        String id_edycja1 = request.getParameter("edycja");
        
        int liczba_uczniow=Integer.parseInt(liczba_uczniow1);
        
   //     String[] arrOfStr = nauczyciel.split(", ", 2);
		  
        String jezyk=pref_jezyk1.split(", ", 2)[0];
        int pref_jezyk=Integer.parseInt(jezyk);
        
        String szkola=id_szkola1.split(", ", 2)[0];
        int id_szkola=Integer.parseInt(szkola);
        
        String typ=id_typ_klasy1.split(", ", 2)[0];
        int id_typ_klasy=Integer.parseInt(typ);
        
		String id_naucz=nauczyciel.split(", ", 2)[0];
		int id_nauczyciel=Integer.parseInt(id_naucz);
		
		String edycja=id_edycja1.split(", ", 2)[0];
        int id_edycja=Integer.parseInt(edycja);
		
        int id=0;
        
        if(id_klasa!=null) {
        	id=Integer.parseInt(id_klasa);
        }
        
        try {
        	Connection conn = DatabaseConnectionManager.getConnection();
		if(metoda.equals("add")) {
		PreparedStatement stmt = conn.prepareStatement("Insert into klasa values(null,?,?,?,?,?,?,?)");
		stmt.setString(1, nazwa);
		stmt.setInt(2, liczba_uczniow);
		stmt.setInt(3, pref_jezyk);
		stmt.setInt(4, id_szkola);
		stmt.setInt(5, id_typ_klasy);
		stmt.setInt(6, id_nauczyciel);
		stmt.setInt(7, id_edycja);
		if (stmt.executeUpdate() > 0) {
	        response.sendRedirect(request.getContextPath() + "/klasy.jsp");     
		} else
			response.getWriter().println("nie udało się");
		}
		else if(metoda.equals("edit")) {
			PreparedStatement stmt = conn.prepareStatement("Update klasa set nazwa=?, liczba_uczniow=?, pref_jezyk=?, id_szkola=?, id_typ_klasy=?, id_nauczyciel=?, id_edycja=? where id_klasa=?");
    		stmt.setString(1, nazwa);
    		stmt.setInt(2, liczba_uczniow);
    		stmt.setInt(3, pref_jezyk);
    		stmt.setInt(4, id_szkola);
    		stmt.setInt(5, id_typ_klasy);
    		stmt.setInt(6, id_nauczyciel);
    		stmt.setInt(7, id_edycja);
    		stmt.setInt(8, id);
    		
    		if (stmt.executeUpdate() > 0) {
    		//	doGet(request, response);
    			response.sendRedirect(request.getContextPath() + "/klasy.jsp");  	        
    		} else
    			response.getWriter().println("nie udało się");	
		}
		else if(metoda.equals("delete")) {
			PreparedStatement stmt = conn.prepareStatement("Delete from klasa where id_klasa=?");
    		stmt.setInt(1, id);
    		
    		if (stmt.executeUpdate() > 0) {
    	        response.sendRedirect(request.getContextPath() + "/klasy.jsp");	        
    		} else
    			response.getWriter().println("nie udało się");
		}
		
        } catch (SQLException e) {
			e.printStackTrace();
		} 
		
	}
}

