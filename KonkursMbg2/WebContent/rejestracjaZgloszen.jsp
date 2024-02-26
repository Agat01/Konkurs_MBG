<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rejestracja zgłoszeń</title>

<link rel="stylesheet" href="style.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="kontener">
<div id="left">
 <jsp:include page="menu2.jsp"></jsp:include>
</div>
<div id="right">
<div class="header" id="header">
Panel administratora<br/>
Międzynarodowego Konkursu<br/>
&quot;<i>Matematyka Bez Granic</i>&quot;
</div>

<div class="mainContent">

<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*"%>
<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%@ page import="mbg.javaee.config.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
Connection conn = DatabaseConnectionManager.getConnection();

Uzytkownik zalogowanyU = AppUtils.getLoginedUser(request.getSession());
String nazwa_uzytkownika = zalogowanyU.getNazwa_uzytkownika();
String rola="";
List<String> role = new ArrayList<String>();

String sql2 = "select r.nazwa \r\n"
		+ "from uzytkownik_rola ur join uzytkownik u on(ur.id_uzytkownik=u.id_uzytkownik)\r\n"
		+"							join rola r on(r.id_rola=ur.id_rola)\r\n"
		+ "where u.nazwa_uzytkownika='"+nazwa_uzytkownika+"'";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
	while(rs2.next()){
		rola=rs2.getString(1);
		role.add(rola);
	}
	rs2.close();
	stmt2.close();
	
	String nazwaEdycji="";
	Statement id_e = conn.createStatement();
	id_e.execute("SELECT nazwa FROM edycja WHERE id_edycja = (SELECT MAX(id_edycja) FROM edycja where active='1')");
	ResultSet rsE = id_e.getResultSet();
	while (rsE.next()) {
		nazwaEdycji = rsE.getString(1);
	}	
	
int idSzkola=0;
String nazwaSz="";
String miejscowosc="";
String region="";
int liczbaKlas=0;

int idKlasa = 0;
String nazwaKlasy = "";
String tytul = "";
String imie = "";
String nazwisko = "";

List<Szkola2> szkoly = new ArrayList<Szkola2>();

String sql = "select COUNT(*),sz.id_szkola, sz.nazwa, sz.miejscowosc, r.nazwa\r\n"
		+ "from szkola sz join klasa k on(sz.id_szkola=k.id_szkola)\r\n"
		+ "             join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
		+ "             join region r on(r.id_region=kr.id_region)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where sz.active=1 and e.nazwa='"+nazwaEdycji+"' and r.nazwa IN (";
for (int i = 0; i < role.size(); i++) {
	if (i > 0) {
		sql += ", ";
	}
	sql += "'" + role.get(i) + "'";
}
sql += ") "
	+"group by sz.id_szkola,sz.nazwa,sz.miejscowosc,r.nazwa \r\n"
	+ "ORDER BY sz.id_szkola DESC";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	liczbaKlas = rs.getInt(1);
	idSzkola=rs.getInt(2);
	nazwaSz=rs.getString(3);
	miejscowosc=rs.getString(4);
	region=rs.getString(5);
	szkoly.add(new Szkola2(liczbaKlas,idSzkola,nazwaSz,miejscowosc,region));
}
rs.close();
stmt.close();


%>
    <h2>Rejestracja zgłoszeń</h2>

<form name="formularz" method="post" action="http://localhost:8090/KonkursMbg/rejestracjaZgloszen">
      <div>
            <label for="id_szkola">Wprowadź id szkoły (nr kodu zgłoszenia):</label>
            <input type="text" id="id_szkola" name="id_szkola">
        </div>
        <div>
            <input type="submit" value="Zapisz">
        </div>
  </form>
<br>
<h3>Szkoły zarejestrowane</h3>
<table id="szkoly">
  <thead>
    <tr>
    <th>Region</th>
      <th>Id szkoły</th>
      <th>Nazwa szkoły</th>
      <th>Miejscowość</th>
      <th>Nazwa Klasy</th>
      <th>Nauczyciel</th>
    </tr>
  </thead>
  <tbody>
<%  
for(int i=0;i<szkoly.size();i++) {
	liczbaKlas=szkoly.get(i).getLiczbaKlas();
   	idSzkola=szkoly.get(i).getId_szkola();
   	nazwaSz=szkoly.get(i).getNazwa();
   	miejscowosc=szkoly.get(i).getMiejscowosc();
   	region=szkoly.get(i).getRegion();
   	%>
   	<tr>
   	<td rowspan=<%=liczbaKlas %>><%=region %></td>
   	<td rowspan=<%=liczbaKlas %>><%=idSzkola %></td>
   	<td rowspan=<%=liczbaKlas %>><%=nazwaSz %></td>
   	<td rowspan=<%=liczbaKlas %>><%=miejscowosc %></td>
 <% 
	String sql4="select k.nazwa,n.tytul,n.imie,n.nazwisko \r\n"
			+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join typ_klasy t on(t.id_typ_klasy=k.id_typ_klasy)\r\n"
			+ "join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
			+ " join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
			+ " join region r on(r.id_region=kr.id_region)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where e.nazwa='"+nazwaEdycji+"' and k.id_szkola="+ szkoly.get(i).getId_szkola()+" and r.nazwa='"+region+"'";
				   	Statement stmt4 = conn.createStatement();
					ResultSet rs4 = stmt4.executeQuery(sql4);
					while (rs4.next()) {
						nazwaKlasy = rs4.getString(1);
						tytul = rs4.getString(2);
						imie = rs4.getString(3);
						nazwisko = rs4.getString(4);
   	%>
   	<td><%=nazwaKlasy %></td>
   	<td><%=tytul + " " + imie + " " + nazwisko %></td>
   	</tr>
   	<% } 
   	rs4.close();
	stmt4.close();
   
    }
	%>
  </tbody>
</table>     

</div>
</div>
</div>
<script>
    var success = <%= request.getAttribute("success") %>;
    if (success === true) {
        alert('Zgłoszenie zostało zarejestrowane');
    } else if (success === false) {
        alert('Niepowodzenie rejestracji zgłoszenia');
    }
</script>
</body>
</html>