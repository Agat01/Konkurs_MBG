<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <link rel = "stylesheet" href="style.css"/>
  <title>Wprowadzanie wyników</title>
  <meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" ></script>
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
      <h1>Wprowadzanie wyników</h1>
     
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


List<String> regiony = new ArrayList<String>();
List<String> zadania = new ArrayList<String>();
List<Wynik> wyniki = new ArrayList<Wynik>();
String region="";
String regionS="";
String zadanie="";
String zadanieS="";

int wynik=0;
int idKlasa=0;
String nazwaK="";
String nazwaSz="";
String miejscowosc="";

String sql = "select nazwa from region";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	region=rs.getString(1);
	if(role.contains(region)){
	regiony.add(region);
	}
}
rs.close();
stmt.close();

String sql4 = "select wynik, zadanie, k.id_klasa, k.nazwa, sz.nazwa, sz.miejscowosc\r\n"
		+ "from wynik w join klasa k on(w.id_klasa=k.id_klasa)\r\n"
		+ "             join szkola sz on(sz.id_szkola=k.id_szkola)\r\n"
		+ "             join zadanie z on(z.id_zadanie=w.id_zadanie)\r\n"
		+ "order by id_wynik desc";
Statement stmt4 = conn.createStatement();
ResultSet rs4=stmt4.executeQuery(sql4);
while(rs4.next()){
	wynik=rs4.getInt(1);
	zadanie=rs4.getString(2);
	idKlasa=rs4.getInt(3);
	nazwaK=rs4.getString(4);
	nazwaSz=rs4.getString(5);
	miejscowosc=rs4.getString(6);
	wyniki.add(new Wynik(idKlasa,nazwaSz,miejscowosc,nazwaK,zadanie,wynik));
}
rs4.close();
stmt4.close();


%>
  <form name="formularz" method="post" action="http://localhost:8090/KonkursMbg/wprowadzanieWynikow">
    <label for="reg">Wybierz region:</label>
    <select id="reg" name="reg" onchange="callJqueryAjax()">
      <option value="">-- Wybierz region --</option>
      <%
        for(int i=0;i<regiony.size();i++) {
        	regionS=regiony.get(i).toString();
        %>
        <option value="<%=regionS %>"><%=regionS %></option>
        <%} %>
    </select>
    
    <label for="szkola">Wybierz szkołę:</label>
    <select id="szkola" name="szkola" onchange="callJqueryAjax2()">
      <option value="">-- Wybierz szkołę --</option>
    </select>
    <label for="klasa">Wybierz klasę:</label>
    <select id="klasa" name="klasa" onchange="callJqueryAjax3()">
      <option value="">-- Wybierz klasę --</option>
    </select>
    <label for="zadanie">Zadanie</label>
	<select id="zadanie" name="zadanie" onchange="">
	  <option value="">-- Wybierz zadanie --</option>
	</select>
	<label for="nazwa">Wynik</label>
	<input type="number" id="wynik" name="wynik" min="0" max="70" required />
	
    <div>
			<input type="submit" value="Dodaj wynik" name="save" onclick="" />

	</div>
  </form>
      
      <br>
       
 <table id="wynikiTable">
  <thead id="tableHead">
    <tr>
      <th>Wynik</th>
      <th>Zadanie</th>
      <th>Id klasy</th>
      <th>Nazwa klasy</th>
      <th>Nazwa szkoły</th>
      <th>Miejscowość</th>
    </tr>
  </thead>
  <tbody>

  </tbody>
</table>     
      <script>
        function callJqueryAjax() {
		  var reg = $('#reg :selected').text();
           $.ajax({
              url: 'AjaxHandler',
              method: 'POST',
              data: {
                 reg: reg
              },
              dataType: "json",
              success: function (response) {
    	 let optionsHtml = '<option value="">-- Wybierz szkołę --</option>';
            response.forEach(function(szkola) {
                optionsHtml += '<option value="' + szkola.id_szkola + '">' + szkola.nazwa + '</option>';
            });
            $('#szkola').html(optionsHtml);
            
            if (reg === '') {
                $('#wynikiTable').hide();
              } else {
                $('#wynikiTable').show();
              }
            updateWynikiTable();
                 },
              error: function (jqXHR, exception) {
                 console.log('Error occured!!');
              }
           });
        }
        function callJqueryAjax2() {
  		  var szkola = $('#szkola :selected').text();
  		  var reg = $('#reg :selected').text();
             $.ajax({
                url: 'AjaxHandler2',
                method: 'POST',
                data: {
                   szkola: szkola,
                   reg: reg
                },
                dataType: "json",
                success: function (response) {
      	 let optionsHtml = '<option value="">-- Wybierz klasę --</option>';
              response.forEach(function(klasa) {
                  optionsHtml += '<option value="' + klasa.id_klasa + '">' + klasa.nazwa + '</option>';
              });
              $('#klasa').html(optionsHtml);
                   },
                error: function (jqXHR, exception) {
                   console.log('Error occured!!');
                }
             });
          }       
        function callJqueryAjax3() {
    		  var klasa = $('#klasa :selected').text();
               $.ajax({
                  url: 'AjaxHandler3',
                  method: 'POST',
                  data: {
                     klasa: klasa
                  },
                  dataType: "json",
                  success: function (response) {
        	 let optionsHtml = '<option value="">-- Wybierz zadanie --</option>';
                response.forEach(function(zadanie) {
                    optionsHtml += '<option value="' + zadanie.id_zadanie + '">' + zadanie.nazwa + '</option>';
                });
                $('#zadanie').html(optionsHtml);
                     },
                  error: function (jqXHR, exception) {
                     console.log('Error occured!!');
                  }
               });
            }       
        function updateWynikiTable() {
        	  var reg = $('#reg :selected').text();
        	  $.ajax({
        	    url: 'AjaxHandler4',
        	    method: 'POST',
        	    data: {
        	      reg: reg
        	    },
        	    dataType: "json",
        	    success: function (response) {
        	      let tableBodyHtml = '';
        	      response.forEach(function (wynik) {
        	        tableBodyHtml += '<tr>';
        	        tableBodyHtml += '<td>' + wynik.wynik + '</td>';
        	        tableBodyHtml += '<td>' + wynik.zadanie + '</td>';
        	        tableBodyHtml += '<td>' + wynik.id_klasa + '</td>';
        	        tableBodyHtml += '<td>' + wynik.nazwaK + '</td>';
        	        tableBodyHtml += '<td>' + wynik.nazwaSz + '</td>';
        	        tableBodyHtml += '<td>' + wynik.miejscowosc + '</td>';
        	        tableBodyHtml += '</tr>';
        	      });
        	      if (reg !== '') {
        	          $('#tableHead').show(); // Pokaż nagłówki tabeli
        	          $('#wynikiTable tbody').html(tableBodyHtml);
        	        } else {
        	          $('#tableHead').hide(); // Ukryj nagłówki tabeli
        	          $('#wynikiTable tbody').empty(); // Wyczyść zawartość <tbody>
        	        }
        	    },
        	    error: function (jqXHR, exception) {
        	      console.log('Error occurred!!');
        	    }
        	  });
        	}
      </script>
	<br>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>	
<script>
    var success = <%= request.getAttribute("success") %>;
    if (success === true) {
        alert('Wynik został dodany');
    } else if (success === false) {
        alert('Niepowodzenie dodawania wyniku');
    }
</script>
</body>
</html>