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

import mbg.javaee.encje.Klasa;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/AjaxHandler2")
public class AjaxHandler2 extends HttpServlet {
private static final long serialVersionUID = 1L;
public AjaxHandler2() {
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
	String szkola = req.getParameter("szkola");
	String reg = req.getParameter("reg");
	String[] parts = szkola.split(", ");
	String nazwaSz = parts[0];
	String miejscowosc = parts[1]; 
  String nazwa="";
  int id_klasa=0;
  List<Klasa> klasy = new ArrayList<Klasa>();
	 try {
		 Connection conn = DatabaseConnectionManager.getConnection();
			Statement stmt = conn.createStatement();
			
			String sql="select k.id_klasa, k.id_klasa || ', ' || k.nazwa\r\n"
					+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
					+ "				join klasa_region kr on(k.id_klasa=kr.id_klasa)\r\n"
					+ "             join region r on(r.id_region=kr.id_region)\r\n"
					+ "where sz.nazwa='"+nazwaSz+"' and sz.miejscowosc='"+miejscowosc+"' and r.nazwa='"+reg+"'";
			stmt.executeQuery(sql);
			ResultSet rs=stmt.getResultSet();
				while(rs.next()) {
					id_klasa=rs.getInt(1);
					nazwa=rs.getString(2);
					Klasa k=new Klasa(id_klasa,nazwa);
					klasy.add(k);
				}
				
				Gson gson = new Gson();
		        String json = gson.toJson(klasy);
		
		        out.println(json);
				
				conn.close();
				
		    } catch (SQLException e) {
				e.printStackTrace();
		    }

}
}