package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/rejestracjaZgloszen")
public class RejestracjaZgloszenSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		String id_szkola = request.getParameter("id_szkola");
		int id=Integer.parseInt(id_szkola);
		 try {
	       Connection conn = DatabaseConnectionManager.getConnection();
	       PreparedStatement stmt = conn.prepareStatement("Update szkola set active=1 where id_szkola=?");
			stmt.setInt(1, id);
			if (stmt.executeUpdate() > 0) {
				request.setAttribute("success", true);  	        
	    	} else
	    		request.setAttribute("success", false);
	} catch (SQLException e) {
		e.printStackTrace();
	} 
	RequestDispatcher dispatcher = request.getRequestDispatcher("/rejestracjaZgloszen.jsp");
	dispatcher.forward(request, response);
	}
}
