<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>Wysyłanie E-maili</title>
<link rel="website icon" type="png" href="http://www.mbg.uz.zgora.pl/logo.php">
<link rel = "stylesheet" href="style.css"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
</head>
<body>
<div id="kontener">
<div id="left">
 <jsp:include page="menu2.jsp"></jsp:include>
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
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
try{
Connection conn = DatabaseConnectionManager.getConnection();

List<String> emaile5 = new ArrayList<String>();
List<String> emaile6 = new ArrayList<String>();
List<String> emaile8 = new ArrayList<String>();
List<String> emaile1l = new ArrayList<String>();
List<String> emaile1t = new ArrayList<String>();
String email="";
String emailS="";

int idEdycja=0;
Statement id_e = conn.createStatement();
id_e.execute("SELECT id_edycja FROM edycja WHERE id_edycja = (SELECT MAX(id_edycja) FROM edycja where active='1')");
ResultSet rsE = id_e.getResultSet();
while (rsE.next()) {
	idEdycja = rsE.getInt(1);
}

String sql = "select n.email || ', ' || k.id_klasa || ', ' || k.nazwa || ', ' || sz.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from nauczyciel n join szkola sz on(sz.id_szkola=n.id_szkola)\r\n"
		+ "                join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "where n.czy_koordynuje=1 and k.id_typ_klasy=1 and k.id_edycja="+idEdycja;
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	email=rs.getString(1);
	emaile5.add(email);
}
rs.close();
stmt.close();

String sql2 = "select n.email || ', ' || k.id_klasa || ', ' || k.nazwa || ', ' || sz.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from nauczyciel n join szkola sz on(sz.id_szkola=n.id_szkola)\r\n"
		+ "                join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "where n.czy_koordynuje=1 and k.id_typ_klasy=2 and k.id_edycja="+idEdycja;
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	email=rs2.getString(1);
	emaile6.add(email);
}
rs2.close();
stmt2.close();

String sql3 = "select n.email || ', ' || k.id_klasa || ', ' || k.nazwa || ', ' || sz.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from nauczyciel n join szkola sz on(sz.id_szkola=n.id_szkola)\r\n"
		+ "                join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "where n.czy_koordynuje=1 and k.id_typ_klasy=3 and k.id_edycja="+idEdycja;
Statement stmt3 = conn.createStatement();
ResultSet rs3=stmt3.executeQuery(sql3);
while(rs3.next()){
	email=rs3.getString(1);
	emaile8.add(email);
}
rs3.close();
stmt3.close();

String sql4 = "select n.email || ', ' || k.id_klasa || ', ' || k.nazwa || ', ' || sz.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from nauczyciel n join szkola sz on(sz.id_szkola=n.id_szkola)\r\n"
		+ "                join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "where n.czy_koordynuje=1 and k.id_typ_klasy=4 and k.id_edycja="+idEdycja;
Statement stmt4 = conn.createStatement();
ResultSet rs4=stmt4.executeQuery(sql4);
while(rs4.next()){
	email=rs4.getString(1);
	emaile1l.add(email);
}
rs4.close();
stmt4.close();

String sql5 = "select n.email || ', ' || k.id_klasa || ', ' || k.nazwa || ', ' || sz.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from nauczyciel n join szkola sz on(sz.id_szkola=n.id_szkola)\r\n"
		+ "                join klasa k on(k.id_szkola=sz.id_szkola)\r\n"
		+ "where n.czy_koordynuje=1 and k.id_typ_klasy=5 and k.id_edycja="+idEdycja;
Statement stmt5 = conn.createStatement();
ResultSet rs5=stmt5.executeQuery(sql5);
while(rs5.next()){
	email=rs5.getString(1);
	emaile1t.add(email);
}
rs5.close();
stmt5.close();
%>
<form method="post" action="http://localhost:8090/KonkursMbg/wysylanieEmaili" enctype="multipart/form-data" onsubmit="get_data()">
        <table border="0" width="75%" align="center">
            <caption><h3>Wyślij E-mail</h3></caption>
            <tr>
                <td width="20%">Odbiorcy: </td>
                <td> 
<select id="odbiorcy" name="odbiorcy" multiple class="select2" style="width: 100%;">
  <optgroup label="Klasy 5">
    	<%
	        for(int i=0;i<emaile5.size();i++) {
	        	emailS=emaile5.get(i).toString();
	        %>
	        <option value="<%=emailS %>"><%=emailS %></option>
	    <%} %>
  </optgroup>
  <optgroup label="Klasy 6">
    <%
	        for(int i=0;i<emaile6.size();i++) {
	        	emailS=emaile6.get(i).toString();
	        %>
	        <option value="<%=emailS %>"><%=emailS %></option>
	    <%} %>
  </optgroup>
  <optgroup label="Klasy 8">
    <%
	        for(int i=0;i<emaile8.size();i++) {
	        	emailS=emaile8.get(i).toString();
	        %>
	        <option value="<%=emailS %>"><%=emailS %></option>
	    <%} %>
  </optgroup>
  <optgroup label="Klasy 1 - licea">
    <%
	        for(int i=0;i<emaile1l.size();i++) {
	        	emailS=emaile1l.get(i).toString();
	        %>
	        <option value="<%=emailS %>"><%=emailS %></option>
	    <%} %>
  </optgroup>
  <optgroup label="Klasy 1 - technika">
    <%
	        for(int i=0;i<emaile1t.size();i++) {
	        	emailS=emaile1t.get(i).toString();
	        %>
	        <option value="<%=emailS %>"><%=emailS %></option>
	    <%} %>
  </optgroup>
  <%  } catch (SQLException e) {
		e.printStackTrace();
  } %>
</select>
			<input type="hidden" id="lista" name="lista" value=""></td>
            </tr>
            <tr>
                <td>Temat: </td>
                <td><input type="text" name="temat" size="100"/></td>
            </tr>
            <tr>
                <td>Treść: </td>
                <td><textarea rows="10" cols="39" name="tresc"></textarea> </td>
            </tr>
            <tr>
            <td><label for="pliki"> </label></td>
 			 <td><input type="file" id="plik" name="plik" multiple><br><br></td>
             </tr>
             <tr>
             <td>Data wysłania:</td>
             <td>
             <input type="date" id="data" name="data">
             </td>
             </tr>
              <tr>
             <td>Godzina wysłania:</td>
             <td>
             <input type="time" id="godzina" name="godzina">
             </td>
             </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Wyślij"/></td>
            </tr>
        </table>
         
    </form>
<br>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<script>
$(document).ready(function() {
  $('.select2').select2({
    tags: true,
    placeholder: 'Wybierz lub wpisz adresy e-mail',
    allowClear: true
  });
});
</script>
<script type="text/javascript">
function get_data(){
	var selectElement = document.getElementById("odbiorcy");
	  var selectedOptions = selectElement.selectedOptions;
	  var emaile = "";

	  for (var i = 0; i < selectedOptions.length; i++) {
	    var optionText = selectedOptions[i].text;
	    var emailParts = optionText.split(", ", 2);
	    var firstPart = emailParts[0];

	    if (emaile === "") {
	      emaile = firstPart;
	    } else {
	      emaile += ", " + firstPart;
	    }
	  }

	  document.getElementById("lista").value = emaile;
	}
</script>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>

</body>
</html>