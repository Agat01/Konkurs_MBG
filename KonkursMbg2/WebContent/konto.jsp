<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel = "stylesheet" href="style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Konto</title>
</head>
<body>
<div id="kontener">
<div id="left">
 <jsp:include page="menu.jsp"></jsp:include>
</div>
<div id="right">
<div class="header" id="header">
<a href="http://www.wmie.uz.zgora.pl/"> <img src="wmie_logo.png" height="100px" align="left" border="0" alt="Przejdź do strony głównej WMIiE"></a>
 <a href="http://www.uz.zgora.pl/"> <img src="uz_logo.png" border="0" align="right" height="100px"  alt="Przejdź do strony głównej UZ"></a>

Krajowy Komitet Organizacyjny<br/>
Międzynarodowego Konkursu<br/>
&quot;<i>Matematyka Bez Granic</i>&quot;
</div>

<div class="mainContent">
      <h3>Witaj: ${zalogowanyU.nazwa_uzytkownika}</h3>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=utf-8");

Connection conn = DatabaseConnectionManager.getConnection();
	Uzytkownik zalogowanyU = AppUtils.getLoginedUser(request.getSession());
	String nazwa_uzytkownika = zalogowanyU.getNazwa_uzytkownika();
	String wojewodztwo="";
	String powiat = "";
	String miejscowosc = "";
	String nazwaZespolu = "";
	String nazwa = "";
	String imienia = "";
	String ulica = "";
	String nrDomu = "";
	String kodPocztowy = "";
	String miejscowosc2 = "";
	String telefon = "";
	String email = "";
	
	String tytul = "";
	String imie = "";
	String nazwisko = "";

	String ktytul = "";
	String kimie = "";
	String knazwisko = "";
	String kemail = "";

	int idSzkola=0;
	
	String typ = "";
	String nazwaKlasy = "";
	String ntytul = "";
	String nimie = "";
	String nnazwisko = "";
	int liczbaUczniow = 0;
	String jezyk = "";
	
	String sql = "select sz.nazwa_zespolu_szkol, sz.nazwa, sz.imienia, sz.nr_tel, sz.email, w.nazwa, \r\n"
			+"p.nazwa, sz.miejscowosc, sz.ulica, sz.nr_domu, sz.kod_pocztowy, sz.miejscowosc2, d.tytul, \r\n"
			+"d.imie, d.nazwisko, n1.tytul, n1.imie, n1.nazwisko, n1.email, sz.id_szkola \r\n"
			+"from szkola sz join dyrektor d on(d.id_dyrektor = sz.id_dyrektor)\r\n"
			+"             join nauczyciel n1 on(n1.id_szkola=sz.id_szkola)\r\n"
			+"             join powiat p on(p.id_powiat=sz.id_powiat)\r\n"
			+"             join wojewodztwo w on(w.id_wojewodztwo=p.id_wojewodztwo)\r\n"
			+"where n1.email='"+nazwa_uzytkownika+"'";
	Statement stmt = conn.createStatement();
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		nazwaZespolu=rs.getString(1);
		nazwa=rs.getString(2);
		imienia=rs.getString(3);
		telefon=rs.getString(4);
		email=rs.getString(5);
		wojewodztwo=rs.getString(6);
		powiat=rs.getString(7);
		miejscowosc=rs.getString(8);
		ulica=rs.getString(9);
		nrDomu=rs.getString(10);
		kodPocztowy=rs.getString(11);
		miejscowosc2=rs.getString(12);
		tytul=rs.getString(13);
		imie=rs.getString(14);
		nazwisko=rs.getString(15);
		ktytul=rs.getString(16);
		kimie=rs.getString(17);
		knazwisko=rs.getString(18);
		kemail=rs.getString(19);
		idSzkola=rs.getInt(20);	
	}
	rs.close();
	stmt.close();
	
	if(nazwaZespolu==null) nazwaZespolu=" ";
	if(imienia==null) imienia=" ";
%>
<h3>Dane szkoły:</h3>
<table id="dane">
<% 
out.println("<tr><th>Nazwa zespołu szkół: </th><td>"+nazwaZespolu+"</td></tr>");
out.println("<tr><th>Nazwa szkoły: </th><td>"+nazwa+"</td></tr>");  
out.println("<tr><th>Patron: </th><td>"+imienia+"</td></tr>");
out.println("<tr><th>Numer telefonu: </th><td>"+telefon+"</td></tr>"); 
out.println("<tr><th>Adres e-mail: </th><td>"+email+"</td></tr>"); 
out.println("<tr><th>Województwo: </th><td>"+wojewodztwo+"</td></tr>");
out.println("<tr><th>Powiat: </th><td>"+powiat+"</td></tr>"); 
out.println("<tr><th>Miejscowosc: </th><td>"+miejscowosc+"</td></tr>"); 
out.println("<tr><th>Adres: </th><td>"+ulica+" "+nrDomu+"<br>"+kodPocztowy+" "+miejscowosc2+"</td></tr>"); 
out.println("<tr><th>Dyrektor: </th><td>"+tytul+" "+imie+" "+nazwisko+"</td></tr>"); 
out.println("<tr><th>Nauczyciel koordynujący: </th><td>"+ktytul+" "+kimie+" "+knazwisko+"</td></tr>"); 
out.println("<tr><th>Adres e-mail nauczyciela koordynującego: </th><td>"+kemail+"</td></tr>"); 
%>
</table>
<h3>Dane klas przystępujących do konkursu:</h3>
<table id="klasy">
			<tr>
				<th rowspan="2">Typ klasy</th>
				<th rowspan="2">Nazwa klasy</th>
				<th colspan="3">Nauczyciel</th>
				<th rowspan="2">Liczba uczniów</th>
				<th rowspan="2">Preferowany język</th>
			</tr>
			<tr>
				<th>Tytuł</th>
				<th>Imie</th>
				<th>Nazwisko</th>
			</tr>
<% Statement stmt2 = conn.createStatement();
stmt2.execute("select t.nazwa, k.nazwa, k.liczba_uczniow, j.nazwa, n2.tytul,n2.imie, n2.nazwisko \r\n"
		+"from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
        +"join nauczyciel n2 on (n2.id_nauczyciel=k.id_nauczyciel)\r\n"
        +"join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
        +"join jezyk j on(j.id_jezyk=k.pref_jezyk)\r\n"
+"where n2.czy_koordynuje=0 and k.id_szkola="+idSzkola);
	ResultSet rs2=stmt2.getResultSet();
        	while(rs2.next()) {
        		typ=rs2.getString(1);
        		nazwaKlasy=rs2.getString(2);
        		liczbaUczniow=rs2.getInt(3);
        		jezyk=rs2.getString(4);
        		tytul=rs2.getString(5);
        		imie=rs2.getString(6);
        		nazwisko=rs2.getString(7);
        	
        		out.println("<tr>"); 
        		out.println("<td>"+typ+"</td><td>"+nazwaKlasy+"</td>");
                out.println("<td>"+tytul+"</td><td>"+imie+"</td><td>"+nazwisko+"</td>");
                out.println("<td>"+liczbaUczniow+"</td><td>"+jezyk+"</td>");
                out.println("</tr>"); 
            }
        	rs2.close();
        	stmt2.close(); 		   	
%>
</table>
<br>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>
</body>
</html>