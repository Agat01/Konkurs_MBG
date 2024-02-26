package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mbg.javaee.encje.Wynik;
import mbg.javaee.encje.Zadanie;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/AjaxHandler3")
public class AjaxHandler3 extends HttpServlet {
private static final long serialVersionUID = 1L;
public AjaxHandler3() {
  super();
}
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  doPost(request, response);
}
protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	res.setContentType("text/plain; charset=utf-8");
	req.setCharacterEncoding("UTF-8");
	res.setContentType("application/json");
    res.setCharacterEncoding("UTF-8");
	PrintWriter out=res.getWriter(); 
	String klasa = req.getParameter("klasa");
	String[] parts = klasa.split(", ");
	String idKlasa = parts[0];
	int id_klasa=Integer.parseInt(idKlasa);
	int id_zadanie=0;
	int max_liczba_pkt=0;
	String zadanie="";
  List<Zadanie> zadania = new ArrayList<Zadanie>();
	 try {
		 Connection conn = DatabaseConnectionManager.getConnection();
			Statement stmt = conn.createStatement();
			
			String sql="SELECT z.id_zadanie, z.zadanie \r\n"
					+ "FROM klasa k\r\n"
					+ "CROSS JOIN zadanie z\r\n"
					+ "LEFT JOIN wynik w ON k.id_klasa = w.id_klasa AND z.id_zadanie = w.id_zadanie\r\n"
					+ "WHERE w.id_wynik IS NULL and z.id_typ_klasy=k.id_typ_klasy and k.id_klasa="+id_klasa;
			stmt.executeQuery(sql);
			ResultSet rs=stmt.getResultSet();
				while(rs.next()) {
					id_zadanie=rs.getInt(1);
					zadanie=rs.getString(2);
			//		max_liczba_pkt=rs.getInt(3);
					zadania.add(new Zadanie(id_zadanie,zadanie));
				}
				
				Gson gson = new Gson();
		        String json = gson.toJson(zadania);
		
		        out.println(json);
				
				conn.close();
				
		    } catch (SQLException e) {
				e.printStackTrace();
		    }
}
}