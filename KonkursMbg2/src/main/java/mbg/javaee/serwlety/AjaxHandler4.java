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
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/AjaxHandler4")
public class AjaxHandler4 extends HttpServlet {
private static final long serialVersionUID = 1L;
public AjaxHandler4() {
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
	String reg = req.getParameter("reg");
	int wynik=0;
	String zadanie="";
  String nazwa="";
  int id_klasa=0;
  String nazwaSz="";
  String miejscowosc="";
  List<Wynik> wyniki = new ArrayList<Wynik>();
	 try {
		 Connection conn = DatabaseConnectionManager.getConnection();
			Statement stmt = conn.createStatement();
			
			String sql="select wynik, zadanie, k.id_klasa, k.nazwa, sz.nazwa, sz.miejscowosc\r\n"
					+ "from wynik w join klasa k on(w.id_klasa=k.id_klasa)\r\n"
					+ "             join szkola sz on(sz.id_szkola=k.id_szkola)\r\n"
					+ "             join zadanie z on(z.id_zadanie=w.id_zadanie)\r\n"
					+ "				join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
					+ "				join region r on(r.id_region=kr.id_region)\r\n"
					+ "where r.nazwa='"+reg+"'\r\n"
					+ "order by id_wynik desc";
			stmt.executeQuery(sql);
			ResultSet rs=stmt.getResultSet();
				while(rs.next()) {
					wynik=rs.getInt(1);
					zadanie=rs.getString(2);
					id_klasa=rs.getInt(3);
					nazwa=rs.getString(4);
					nazwaSz=rs.getString(5);
					miejscowosc=rs.getString(6);
					Wynik sz=new Wynik(id_klasa,nazwaSz,miejscowosc,nazwa,zadanie,wynik);
					wyniki.add(sz);
				
			//		out.println("<option value='"+nazwa+"'>"+nazwa+"</option>");
				}
				
				Gson gson = new Gson();
		        String json = gson.toJson(wyniki);
		
		        out.println(json);
				
				conn.close();
				
		    } catch (SQLException e) {
				e.printStackTrace();
		    }
}
}