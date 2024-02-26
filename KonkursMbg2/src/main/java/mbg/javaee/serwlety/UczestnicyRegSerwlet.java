package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mbg.javaee.encje.Szkola;
import mbg.javaee.utils.DatabaseConnectionManager;

@WebServlet("/uczestnicyReg")
public class UczestnicyRegSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		String nazwaEdycji = request.getParameter("edycja");
		String wybranyReg = request.getParameter("region");
		int liczbaKlas = 0;
		String nazwa = "";
		String imienia = "";
		String miejscowosc = "";
		int idSzkola = 0;
		String nazwaKlasy = "";
		String jezyk = "";
		String tytul = "";
		String imie = "";
		String nazwisko = "";

		try {
		Connection conn = DatabaseConnectionManager.getConnection();

		if (wybranyReg != null) {
			if (wybranyReg.equals("1")) {

				ArrayList<Szkola> szkoly = new ArrayList<Szkola>();
				String sql = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
						+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
						+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'"
						+ "group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n" 
						+ "order by sz.miejscowosc";
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {
					liczbaKlas = rs.getInt(1);
					nazwa = rs.getString(2);
					imienia = rs.getString(3);
					miejscowosc = rs.getString(4);
					idSzkola = rs.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs.close();
				stmt.close();
				if(!szkoly.isEmpty()) {
					out.println("<center><h3>Szkoły podstawowe - klasy V i VI</h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th><th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly.size(); i++) {
					out.println("<tr id='trSzkola'>");
					// tutaj szkoly.get(i).getId_dyrektor() zwracją liczbę klas w szkole
					out.println("<td id='kolor' rowspan=" + szkoly.get(i).getId_dyrektor() + ">"
							+ szkoly.get(i).getNazwa() + "<br>" + szkoly.get(i).getImienia() + "<br>"
							+ szkoly.get(i).getMiejscowosc() + "</td>");

					Statement stmt2 = conn.createStatement();
					stmt2.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+ "join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+ "join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+ "join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+ "join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and k.id_szkola="+szkoly.get(i).getId_szkola()+" and e.nazwa='"+nazwaEdycji+"'");
					ResultSet rs2 = stmt2.getResultSet();
					while (rs2.next()) {
						nazwaKlasy = rs2.getString(1);
						jezyk = rs2.getString(2);
						tytul = rs2.getString(3);
						imie = rs2.getString(4);
						nazwisko = rs2.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs2.close();
					stmt2.close();
				}
				out.println("</table>");
				}

				ArrayList<Szkola> szkoly2 = new ArrayList<Szkola>();
				String sql2 = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+ "join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
						+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
						+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"' \r\n"
						+ "group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n" 
						+ "order by sz.miejscowosc";
				Statement stmt3 = conn.createStatement();
				ResultSet rs3 = stmt3.executeQuery(sql2);
				while (rs3.next()) {
					liczbaKlas = rs3.getInt(1);
					nazwa = rs3.getString(2);
					imienia = rs3.getString(3);
					miejscowosc = rs3.getString(4);
					idSzkola = rs3.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly2.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs3.close();
				stmt3.close();
				if(!szkoly2.isEmpty()) {
					out.println("<center><h3>Szkoły podstawowe - klasy VIII </h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th><th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly2.size(); i++) {
					out.println("<tr id='trSzkola'>");
					out.println(
							"<td rowspan=" + szkoly2.get(i).getId_dyrektor() + ">" + szkoly2.get(i).getNazwa() + "<br>"
									+ szkoly2.get(i).getImienia() + "<br>" + szkoly2.get(i).getMiejscowosc() + "</td>");

					Statement stmt4 = conn.createStatement();
					stmt4.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+" join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+ "join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+ "join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+ "join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n" 
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+ "where k.id_typ_klasy=3 and e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+ szkoly2.get(i).getId_szkola());
					ResultSet rs4 = stmt4.getResultSet();
					while (rs4.next()) {
						nazwaKlasy = rs4.getString(1);
						jezyk = rs4.getString(2);
						tytul = rs4.getString(3);
						imie = rs4.getString(4);
						nazwisko = rs4.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs4.close();
					stmt4.close();
				}
				out.println("</table>");
				}
				
				ArrayList<Szkola> szkoly3 = new ArrayList<Szkola>();
				String sql3 = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+ "join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
						+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
						+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' \r\n"
						+ "group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n" 
						+ "order by sz.miejscowosc";
				Statement stmt5 = conn.createStatement();
				ResultSet rs5 = stmt5.executeQuery(sql3);
				while (rs5.next()) {
					liczbaKlas = rs5.getInt(1);
					nazwa = rs5.getString(2);
					imienia = rs5.getString(3);
					miejscowosc = rs5.getString(4);
					idSzkola = rs5.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly3.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs5.close();
				stmt5.close();
				if(!szkoly3.isEmpty()) {
					out.println("<center><h3>Licea i technika - klasy I</h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th> <th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly3.size(); i++) {
					out.println("<tr id='trSzkola'>");
					out.println(
							"<td rowspan=" + szkoly3.get(i).getId_dyrektor() + ">" + szkoly3.get(i).getNazwa() + "<br>"
									+ szkoly3.get(i).getImienia() + "<br>" + szkoly3.get(i).getMiejscowosc() + "</td>");

					Statement stmt6 = conn.createStatement();
					stmt6.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+ "join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+ "join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+ "join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+ "join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+ szkoly3.get(i).getId_szkola());
					ResultSet rs6 = stmt6.getResultSet();
					while (rs6.next()) {
						nazwaKlasy = rs6.getString(1);
						jezyk = rs6.getString(2);
						tytul = rs6.getString(3);
						imie = rs6.getString(4);
						nazwisko = rs6.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs6.close();
					stmt6.close();
				}

				out.println("</table>");
				}
			} else {
				int id=Integer.parseInt(wybranyReg);
				int idRegion= id-1;

				ArrayList<Szkola> szkoly = new ArrayList<Szkola>();
				String sql = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+ "join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
				        + "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
				+"where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and kr.id_region="+idRegion+" \r\n"
				+"group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {
					liczbaKlas = rs.getInt(1);
					nazwa = rs.getString(2);
					imienia = rs.getString(3);
					miejscowosc = rs.getString(4);
					idSzkola = rs.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs.close();
				stmt.close();
				if(!szkoly.isEmpty()) {
					out.println("<center><h3>Szkoły podstawowe - klasy V i VI</h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th><th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly.size(); i++) {
					out.println("<tr id='trSzkola'>");
					// tutaj szkoly.get(i).getId_dyrektor() zwracją liczbę klas w szkole
					out.println("<td id='kolor' rowspan=" + szkoly.get(i).getId_dyrektor() + ">"
							+ szkoly.get(i).getNazwa() + "<br>" + szkoly.get(i).getImienia() + "<br>"
							+ szkoly.get(i).getMiejscowosc() + "</td>");

					Statement stmt2 = conn.createStatement();
					stmt2.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+"join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+"join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+"join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
							+"join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+"where kr.id_region="+idRegion+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+szkoly.get(i).getId_szkola());
						
					ResultSet rs2 = stmt2.getResultSet();
					while (rs2.next()) {
						nazwaKlasy = rs2.getString(1);
						jezyk = rs2.getString(2);
						tytul = rs2.getString(3);
						imie = rs2.getString(4);
						nazwisko = rs2.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs2.close();
					stmt2.close();
				}
				out.println("</table>");
				}

				ArrayList<Szkola> szkoly2 = new ArrayList<Szkola>();
				String sql2 = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
				        + "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
				+"where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and kr.id_region="+idRegion+" \r\n"
				+"group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola";
				Statement stmt3 = conn.createStatement();
				ResultSet rs3 = stmt3.executeQuery(sql2);
				while (rs3.next()) {
					liczbaKlas = rs3.getInt(1);
					nazwa = rs3.getString(2);
					imienia = rs3.getString(3);
					miejscowosc = rs3.getString(4);
					idSzkola = rs3.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly2.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs3.close();
				stmt3.close();
				if(!szkoly2.isEmpty()) {
					out.println("<center><h3>Szkoły podstawowe - klasy VIII </h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th><th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly2.size(); i++) {
					out.println("<tr id='trSzkola'>");
					out.println(
							"<td rowspan=" + szkoly2.get(i).getId_dyrektor() + ">" + szkoly2.get(i).getNazwa() + "<br>"
									+ szkoly2.get(i).getImienia() + "<br>" + szkoly2.get(i).getMiejscowosc() + "</td>");

					Statement stmt4 = conn.createStatement();
					stmt4.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+"join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+"join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+"join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+"where kr.id_region="+idRegion+" and k.id_typ_klasy=3 and e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+szkoly2.get(i).getId_szkola());
					ResultSet rs4 = stmt4.getResultSet();
					while (rs4.next()) {
						nazwaKlasy = rs4.getString(1);
						jezyk = rs4.getString(2);
						tytul = rs4.getString(3);
						imie = rs4.getString(4);
						nazwisko = rs4.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs4.close();
					stmt4.close();
				}

				out.println("</table>");
				}

				ArrayList<Szkola> szkoly3 = new ArrayList<Szkola>();
				String sql3 = "select COUNT(*),sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola \r\n"
						+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
						+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
				        + "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
				+"where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and kr.id_region="+idRegion+" \r\n"
				+"group by sz.nazwa,sz.imienia,sz.miejscowosc,sz.id_szkola";
				Statement stmt5 = conn.createStatement();
				ResultSet rs5 = stmt5.executeQuery(sql3);
				while (rs5.next()) {
					liczbaKlas = rs5.getInt(1);
					nazwa = rs5.getString(2);
					imienia = rs5.getString(3);
					miejscowosc = rs5.getString(4);
					idSzkola = rs5.getInt(5);

					if(imienia==null) {
						imienia=" ";
					}
					
					szkoly3.add(new Szkola(liczbaKlas, nazwa, imienia, miejscowosc, idSzkola));
				}
				rs5.close();
				stmt5.close();
				if(!szkoly3.isEmpty()) {
					out.println("<center><h3>Licea i technika - klasy I</h3></center>");
					out.println("<table id='uczestnicy'>");
					out.println("<tr><th>Szkoła/Patron/Miasto</th> <th>Klasa</th><th>Język</th><th>Nauczyciel</th></tr>");
				for (int i = 0; i < szkoly3.size(); i++) {
					out.println("<tr id='trSzkola'>");
					out.println(
							"<td rowspan=" + szkoly3.get(i).getId_dyrektor() + ">" + szkoly3.get(i).getNazwa() + "<br>"
									+ szkoly3.get(i).getImienia() + "<br>" + szkoly3.get(i).getMiejscowosc() + "</td>");

					Statement stmt6 = conn.createStatement();
					stmt6.execute("select k.nazwa,j.nazwa, n.tytul,n.imie,n.nazwisko \r\n"
							+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
							+"join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+"join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
							+"join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+"join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+"where kr.id_region="+idRegion+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+szkoly3.get(i).getId_szkola());
					ResultSet rs6 = stmt6.getResultSet();
					while (rs6.next()) {
						nazwaKlasy = rs6.getString(1);
						jezyk = rs6.getString(2);
						tytul = rs6.getString(3);
						imie = rs6.getString(4);
						nazwisko = rs6.getString(5);

						out.println("<td>" + nazwaKlasy + "</td>");
						out.println("<td>" + jezyk + "</td>");
						out.println("<td>" + tytul + " " + imie + " " + nazwisko + "</td>");
						out.println("</tr>");
					}
					rs6.close();
					stmt6.close();
				}

				out.println("</table>");
				}
			}
		} 
		conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
