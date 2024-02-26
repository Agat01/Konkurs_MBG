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

import mbg.javaee.encje.Szkola;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/AjaxHandler")
public class AjaxHandler extends HttpServlet {
private static final long serialVersionUID = 1L;
public AjaxHandler() {
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
  String nazwa="";
  int id_szkola=0;
  List<Szkola> szkoly = new ArrayList<Szkola>();
	 try {
		 Connection conn = DatabaseConnectionManager.getConnection();
			Statement stmt = conn.createStatement();
			
			String sql="select sz.id_szkola, sz.nazwa || ', ' || sz.miejscowosc \r\n"
					+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
					+ "               join klasa_region kr on(k.id_klasa=kr.id_klasa)\r\n"
					+ "               join region r on(r.id_region=kr.id_region)\r\n"
					+ "where r.nazwa='"+reg+"' and sz.active='1' \r\n"
					+ "group by sz.id_szkola, sz.nazwa, sz.miejscowosc \r\n"
					+ "order by sz.id_szkola";
			stmt.executeQuery(sql);
			ResultSet rs=stmt.getResultSet();
				while(rs.next()) {
					id_szkola=rs.getInt(1);
					nazwa=rs.getString(2);
					Szkola sz=new Szkola(id_szkola,nazwa);
					szkoly.add(sz);

				}
				
				Gson gson = new Gson();
		        String json = gson.toJson(szkoly);
		
		        out.println(json);
				
				conn.close();
				
		    } catch (SQLException e) {
				e.printStackTrace();
		    }
}
}