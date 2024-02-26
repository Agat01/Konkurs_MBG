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

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/wprowadzanieWynikow")
public class WprowadzanieWynikow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/wprowadzanieWynikow.jsp");
			dispatcher.forward(request, response);	
		*/	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain");
		PrintWriter out = res.getWriter();
		int idKlasa=0;
		int idZadanie=0;
		int idWynik=0;
		
		String klasa = req.getParameter("klasa");
		out.println(klasa);
		String[] parts = klasa.split(", ");
		String id_klasa = parts[0];
		idKlasa=Integer.parseInt(id_klasa); 
//		String nazwa = parts[1]; 
		String zadanie = req.getParameter("zadanie");
		if(zadanie!=null) {
			idZadanie=Integer.parseInt(zadanie);
		}
		String wynikS = req.getParameter("wynik");
		int wynik=0;
		if(wynikS!=null) {
		wynik=Integer.parseInt(wynikS);
		}
		out.println(idKlasa);
		out.println(zadanie);
		out.println(wynik);
		try {
			Connection conn = DatabaseConnectionManager.getConnection();
			Statement id_w = conn.createStatement();
		
			id_w.execute("select id_wynik from wynik \r\n"
					+ "where id_zadanie="+idZadanie+" and id_klasa="+idKlasa);
			ResultSet rs2 = id_w.getResultSet();
			while (rs2.next()) {
				idWynik = rs2.getInt(1);
				out.println(idWynik);
			}
			if(idWynik==0) {
				out.println(idWynik);
			
			PreparedStatement stmt = conn.prepareStatement("Insert into wynik values(null,?,?,?)");
			
			stmt.setInt(1, wynik);
			stmt.setInt(2,idZadanie);
			stmt.setInt(3, idKlasa);
				if (stmt.executeUpdate() > 0) {
					req.setAttribute("success", true);
				} 
				else  {
					 req.setAttribute("success", false);
				}
			}
			else {
				 req.setAttribute("success", false);
			}
			conn.close();
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("/wprowadzanieWynikow.jsp");
		dispatcher.forward(req, res);
	}
}
