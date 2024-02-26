<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href="style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Statystyki</title>
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

<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=utf-8");

String nazwaEdycji = request.getParameter("edycja");

String id_czytelnik=request.getParameter("id_czytelnik");
String email=request.getParameter("email");

Connection conn = DatabaseConnectionManager.getConnection();
	
	int id=0;
	String wojewodztwo="";
	int liczba=0;
	int suma1=0;
	int suma2=0;
	int suma3=0;
	double liczba2=0;
%>
<h2>Bieżące statystyki - <%= nazwaEdycji %></h2>
<table id="statystyki">
   <tr>
      <th rowspan="2">Województwo</th><th colspan="5">podstawowe (klasy V i VI)	</th> <th  colspan="5">8 klasy (gimnazja do 30 edycji)</th> <th colspan="5">licea i technika (klasy I)</th> <th colspan="5">Razem</th>
   </tr>
   <tr>
      <th>L.szkół</th><th>L.klas</th><th>L.uczniów</th><th>Śr. wynik</th><th>Max. wynik</th>  <th>L.szkół</th><th>L.klas</th><th>L.uczniów</th><th>Śr. wynik</th><th>Max. wynik</th>  <th>L.szkół</th><th>L.klas</th><th>L.uczniów</th><th>Śr. wynik</th><th>Max. wynik</th>  <th>L.szkół</th><th>L.klas</th><th>L.uczniów</th><th>Śr. wynik</th><th>Max. wynik</th>
   </tr>

      <%
String sql1 = "select id_wojewodztwo, nazwa from wojewodztwo order by nazwa asc";
Statement stmt1 = conn.createStatement();
ResultSet rs1=stmt1.executeQuery(sql1);
while(rs1.next()){
	id=rs1.getInt(1);
	wojewodztwo=rs1.getString(2);
	
	out.println("<tr class='kolor'>"); 
	out.println("<td>"+wojewodztwo+"</td>");
	
	String sql="select count(DISTINCT sz.id_szkola) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt = conn.createStatement();
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		liczba=rs.getInt(1);
		suma1=suma1+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs.close();
	stmt.close();
	
	String sql2="select count(k.id_klasa) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt2 = conn.createStatement();
	ResultSet rs2=stmt2.executeQuery(sql2);
	while(rs2.next()){
		liczba=rs2.getInt(1);
		suma2=suma2+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs2.close();
	stmt2.close();
	
	String sql3="select sum(k.liczba_uczniow) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt3 = conn.createStatement();
	ResultSet rs3=stmt3.executeQuery(sql3);
	while(rs3.next()){
		liczba=rs3.getInt(1);
		suma3=suma3+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs3.close();
	stmt3.close();
	
	String sql3s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt3s = conn.createStatement();
	ResultSet rs3s=stmt3s.executeQuery(sql3s);
	while(rs3s.next()){
		String liczbaS=rs3s.getString(1);
	//	liczba2 = Double.parseDouble(liczbaS);
		if(liczbaS == null){
			liczbaS="0";
		}
		out.println("<td>"+liczbaS+"</td>");
	}
	rs3s.close();
	stmt3s.close();
	
	String sql3m="select max(wynik)\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt3m = conn.createStatement();
	ResultSet rs3m=stmt3m.executeQuery(sql3m);
	while(rs3m.next()){
		liczba=rs3m.getInt(1);
		out.println("<td>"+liczba+"</td>");
	}
	rs3m.close();
	stmt3m.close();
	
	String sql4="select count(DISTINCT sz.id_szkola) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt4 = conn.createStatement();
	ResultSet rs4=stmt4.executeQuery(sql4);
	while(rs4.next()){
		liczba=rs4.getInt(1);
		suma1=suma1+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs4.close();
	stmt4.close();
	
	String sql5="select count(k.id_klasa) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt5 = conn.createStatement();
	ResultSet rs5=stmt5.executeQuery(sql5);
	while(rs5.next()){
		liczba=rs5.getInt(1);
		suma2=suma2+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs5.close();
	stmt5.close();
	
	String sql6="select sum(k.liczba_uczniow) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt6 = conn.createStatement();
	ResultSet rs6=stmt6.executeQuery(sql6);
	while(rs6.next()){
		liczba=rs6.getInt(1);
		suma3=suma3+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs6.close();
	stmt6.close();
	
	String sql6s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt6s = conn.createStatement();
	ResultSet rs6s=stmt6s.executeQuery(sql6s);
	while(rs6s.next()){
		String liczbaS=rs6s.getString(1);
	//	liczba2 = Double.parseDouble(liczbaS);
		if(liczbaS == null){
			liczbaS="0";
		}
		out.println("<td>"+liczbaS+"</td>");
	}
	rs6s.close();
	stmt6s.close();
	
	String sql6m="select max(wynik)\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt6m = conn.createStatement();
	ResultSet rs6m=stmt6m.executeQuery(sql6m);
	while(rs6m.next()){
		liczba=rs6m.getInt(1);
		out.println("<td>"+liczba+"</td>");
	}
	rs6m.close();
	stmt6m.close();
	
	String sql7="select count(DISTINCT sz.id_szkola) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt7 = conn.createStatement();
	ResultSet rs7=stmt7.executeQuery(sql7);
	while(rs7.next()){
		liczba=rs7.getInt(1);
		suma1=suma1+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs7.close();
	stmt7.close();
	
	String sql8="select count(k.id_klasa) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt8 = conn.createStatement();
	ResultSet rs8=stmt8.executeQuery(sql8);
	while(rs8.next()){
		liczba=rs8.getInt(1);
		suma2=suma2+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs8.close();
	stmt8.close();
	
	String sql9="select sum(k.liczba_uczniow) \r\n"
			+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt9 = conn.createStatement();
	ResultSet rs9=stmt9.executeQuery(sql9);
	while(rs9.next()){
		liczba=rs9.getInt(1);
		suma3=suma3+liczba;
		out.println("<td>"+liczba+"</td>");
	}
	rs9.close();
	stmt9.close();
	
	String sql9s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt9s = conn.createStatement();
	ResultSet rs9s=stmt9s.executeQuery(sql9s);
	while(rs9s.next()){
		String liczbaS=rs9s.getString(1);
	//	liczba2 = Double.parseDouble(liczbaS);
	if(liczbaS == null){
		liczbaS="0";
	}
		out.println("<td>"+liczbaS+"</td>");
	}
	rs9s.close();
	stmt9s.close();
	
	String sql9m="select max(wynik)\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt9m = conn.createStatement();
	ResultSet rs9m=stmt9m.executeQuery(sql9m);
	while(rs9m.next()){
		liczba=rs9m.getInt(1);
		out.println("<td>"+liczba+"</td>");
	}
	rs9m.close();
	stmt9m.close();
	
	out.println("<td>"+suma1+"</td>");
	out.println("<td>"+suma2+"</td>");
	out.println("<td>"+suma3+"</td>");
	
	String sql10="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt10 = conn.createStatement();
	ResultSet rs10=stmt10.executeQuery(sql10);
	while(rs10.next()){
		String liczbaS=rs10.getString(1);
		if(liczbaS == null){
			liczbaS="0";
		}
		out.println("<td>"+liczbaS+"</td>");
	}
	rs10.close();
	stmt10.close();
	
	String sql11="select max(wynik)\r\n"
    		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
    		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
    		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
    		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
    		+ "where id_wojewodztwo="+id+" and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
	Statement stmt11 = conn.createStatement();
	ResultSet rs11=stmt11.executeQuery(sql11);
	while(rs11.next()){
		liczba=rs11.getInt(1);
		out.println("<td>"+liczba+"</td>");
	}
	rs11.close();
	stmt11.close();
	
	suma1=0;
	suma2=0;
	suma3=0;
    out.println("</tr>"); 
}
out.println("<tr>"); 
int sumaSz=0;
int sumaK=0;
int sumaU=0;
String sql="select count(DISTINCT sz.id_szkola) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	int suma=rs.getInt(1);
	sumaSz=sumaSz+suma;
	out.println("<td>Razem: </td>"+"<td>"+suma+"</td>");
}
rs.close();
stmt.close();

String sql2="select count(k.id_klasa) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	int suma=rs2.getInt(1);
	sumaK=sumaK+suma;
	out.println("<td>"+suma+"</td>");
}
rs2.close();
stmt2.close();

String sql3="select sum(k.liczba_uczniow) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt3 = conn.createStatement();
ResultSet rs3=stmt3.executeQuery(sql3);
while(rs3.next()){
	int suma=rs3.getInt(1);
	sumaU=sumaU+suma;
	out.println("<td>"+suma+"</td>");
}
rs3.close();
stmt3.close();

String sql3s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt3s = conn.createStatement();
ResultSet rs3s=stmt3s.executeQuery(sql3s);
while(rs3s.next()){
	String liczbaS=rs3s.getString(1);
	if(liczbaS == null){
		liczbaS="0";
	}
	out.println("<td>"+liczbaS+"</td>");
}
rs3s.close();
stmt3s.close();

String sql3m="select max(wynik)\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt3m = conn.createStatement();
ResultSet rs3m=stmt3m.executeQuery(sql3m);
while(rs3m.next()){
	liczba=rs3m.getInt(1);
	out.println("<td>"+liczba+"</td>");
}
rs3m.close();
stmt3m.close();

String sql4="select count(DISTINCT sz.id_szkola) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt4 = conn.createStatement();
ResultSet rs4=stmt4.executeQuery(sql4);
while(rs4.next()){
	int suma=rs4.getInt(1);
	sumaSz=sumaSz+suma;
	out.println("<td>"+suma+"</td>");
}
rs4.close();
stmt4.close();

String sql5="select count(k.id_klasa) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt5 = conn.createStatement();
ResultSet rs5=stmt5.executeQuery(sql5);
while(rs5.next()){
	int suma=rs5.getInt(1);
	sumaK=sumaK+suma;
	out.println("<td>"+suma+"</td>");
}
rs5.close();
stmt5.close();

String sql6="select sum(k.liczba_uczniow) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt6 = conn.createStatement();
ResultSet rs6=stmt6.executeQuery(sql6);
while(rs6.next()){
	int suma=rs6.getInt(1);
	sumaU=sumaU+suma;
	out.println("<td>"+suma+"</td>");
}
rs6.close();
stmt6.close();

String sql6s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt6s = conn.createStatement();
ResultSet rs6s=stmt6s.executeQuery(sql6s);
while(rs6s.next()){
	String liczbaS=rs6s.getString(1);
//	liczba2 = Double.parseDouble(liczbaS);
	if(liczbaS == null){
		liczbaS="0";
	}
	out.println("<td>"+liczbaS+"</td>");
}
rs6s.close();
stmt6s.close();

String sql6m="select max(wynik)\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where k.id_typ_klasy=3 and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt6m = conn.createStatement();
ResultSet rs6m=stmt6m.executeQuery(sql6m);
while(rs6m.next()){
	liczba=rs6m.getInt(1);
	out.println("<td>"+liczba+"</td>");
}
rs6m.close();
stmt6m.close();

String sql7="select count(DISTINCT sz.id_szkola) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt7 = conn.createStatement();
ResultSet rs7=stmt7.executeQuery(sql7);
while(rs7.next()){
	int suma=rs7.getInt(1);
	sumaSz=sumaSz+suma;
	out.println("<td>"+suma+"</td>");
}
rs7.close();
stmt7.close();

String sql8="select count(k.id_klasa) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt8 = conn.createStatement();
ResultSet rs8=stmt8.executeQuery(sql8);
while(rs8.next()){
	int suma=rs8.getInt(1);
	sumaK=sumaK+suma;
	out.println("<td>"+suma+"</td>");
}
rs8.close();
stmt8.close();

String sql9="select sum(k.liczba_uczniow) \r\n"
		+ "from szkola sz join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt9 = conn.createStatement();
ResultSet rs9=stmt9.executeQuery(sql9);
while(rs9.next()){
	int suma=rs9.getInt(1);
	sumaU=sumaU+suma;
	out.println("<td>"+suma+"</td>");
}
rs9.close();
stmt9.close();

String sql9s="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt9s = conn.createStatement();
ResultSet rs9s=stmt9s.executeQuery(sql9s);
while(rs9s.next()){
	String liczbaS=rs9s.getString(1);
//	liczba2 = Double.parseDouble(liczbaS);
if(liczbaS == null){
	liczbaS="0";
}
	out.println("<td>"+liczbaS+"</td>");
}
rs9s.close();
stmt9s.close();

String sql9m="select max(wynik)\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where (k.id_typ_klasy=4 or k.id_typ_klasy=5) and sz.active='1' and e.nazwa='"+nazwaEdycji+"'";
Statement stmt9m = conn.createStatement();
ResultSet rs9m=stmt9m.executeQuery(sql9m);
while(rs9m.next()){
	liczba=rs9m.getInt(1);
	out.println("<td>"+liczba+"</td>");
}
rs9m.close();
stmt9m.close();

out.println("<td>"+sumaSz+"</td>"+"<td>"+sumaK+"</td>"+"<td>"+sumaU+"</td>");

String sql10="select TO_CHAR(ROUND(sum(wynik)/count(k.id_klasa), 2))\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where e.nazwa='"+nazwaEdycji+"' and sz.active='1'";
Statement stmt10 = conn.createStatement();
ResultSet rs10=stmt10.executeQuery(sql10);
while(rs10.next()){
	String liczbaS=rs10.getString(1);
	if(liczbaS == null){
		liczbaS="0";
	}
	out.println("<td>"+liczbaS+"</td>");
}
rs10.close();
stmt10.close();

String sql11="select max(wynik)\r\n"
		+ "from szkola sz join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
		+ "join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
		+ "join wynik w on(w.id_klasa=k.id_klasa)\r\n"
		+ "where e.nazwa='"+nazwaEdycji+"' and sz.active='1'";
Statement stmt11 = conn.createStatement();
ResultSet rs11=stmt11.executeQuery(sql11);
while(rs11.next()){
	liczba=rs11.getInt(1);
	out.println("<td>"+liczba+"</td>");
}
rs11.close();
stmt11.close();

out.println("</tr>"); 
rs1.close();
stmt1.close();
%>
</table>
<script type="text/javascript">
var $rows = $('#tabela tr');
$('#szukaj').keyup(function() {
	    
	    var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
	        reg = RegExp(val, 'i'),
	        text;
	    
	    $rows.show().filter(function() {
	        text = $(this).text().replace(/\s+/g, ' ');
	        return !reg.test(text);
	    }).hide();
	});
</script>
<br>
<br>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>
</body>
</html>