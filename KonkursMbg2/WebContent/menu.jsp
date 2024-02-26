<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<nav>
<div class="topnav">
<ul id="menu">
<c:set var = "uzytk" scope = "session" value = "${zalogowanyU.nazwa_uzytkownika}"/>
<c:if test="${uzytk!=null}">
<li><center><span style="color:red">[${uzytk}]</span></center></li>
<li><div class=button><button class="logout" onclick="location.href='${pageContext.request.contextPath}/wylogowanie'">Wyloguj</button></div></li>
</c:if>
<c:if test="${uzytk==null}">
<li><div class=button>
<button id="log" onclick="document.getElementById('id01').style.display='block'">Logowanie</button>
<div id="id01" class="modal">
  <form class="modal-content animate" method="post" action="${pageContext.request.contextPath}/login">
  <input type="hidden" name="redirectId" value="${param.redirectId}" />
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <center><h1><span style="color: #339989">Panel logowania</span></h1></center>
      <input type="text" placeholder="Nazwa użytkownika" id="nazwa_uzytkownika" name="nazwa_uzytkownika" value= "${uzytkownik.nazwa_uzytkownika}" required>

      <input type="password" placeholder="Hasło" id="haslo" name="haslo" value= "${uzytkownik.haslo}" required>
        
      <button id="log2" type="submit">Zaloguj się</button>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="log" type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Anuluj</button>
      
    </div>
  </form>
</div>
</div>
<script>
var modal = document.getElementById('id01');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script></li>
</c:if>
  <li><a href="strona.jsp">Strona główna</a></li>
  <li><a href="form.jsp">Formularz rejestracyjny</a></li>
  <li><a href="http://maths-msf.site.ac-strasbourg.fr/" target="_blank">Mathématiques sans Frontières</a></li>
  <li class="dropdown">
    <a href="javascript:void(0)" class="dropbtn">Informacje o konkursie</a>
    <div class="dropdown-content">
  		<a href="regulaminS.jsp">Regulamin konkursu MBG Senior</a>
  		<a href="http://www.mbg.uz.zgora.pl/static/MbG_Junior_Wyciag_z_regulaminu.pdf">Regulamin konkursu MBG Junior</a>
 		<a href="geneza.jsp">Geneza konkursu</a>
  		<a href="warunkiUdzialu.jsp">Warunki udziału w konkursie</a>
  		<a href="specyfikacjaZadan.jsp">Specyfikacja zadań konkursowych</a>
  		<a href="idee.jsp">Idee konkursu</a>
  		<a href="zasady.jsp">Zasady ogólne</a>
  		<a href="nagrody.jsp">Nagrody</a>
   </div>
  <%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");

List<Edycja> edycje = new ArrayList<>();

try {
	Connection conn = DatabaseConnectionManager.getConnection();
	String sql = "SELECT nazwa,url,wszystkieWyniki FROM edycja where active=1 order by nazwa desc";
    
	Statement stmt = conn.createStatement();
	ResultSet rs=stmt.executeQuery(sql);
    
    while (rs.next()) {
        String nazwa = rs.getString("nazwa");
        String url = rs.getString("url");
        String wszystkieWyniki = rs.getString("wszystkieWyniki");
        
        Edycja edycja = new Edycja(nazwa, url, wszystkieWyniki);
        edycje.add(edycja);
    }
    rs.close();
    stmt.close();

for (Edycja edycja : edycje) {
%>
<li class="dropdown">
  <a href="javascript:void(0)" class="dropbtn"><%= edycja.getNazwa() %></a>
  <div class="dropdown-content">
  <a href="uczestnicyWojewodztwa2.jsp?edycja=<%= edycja.getNazwa() %>">Uczestnicy konkursu według Województw</a>
  <a href="uczestnicyRegiony.jsp?edycja=<%= edycja.getNazwa() %>">Uczestnicy konkursu według Regionów</a>
  <% if(edycja.getWszystkieWyniki().equals("1")){ %>
  <a href="statystyki2.jsp?edycja=<%= edycja.getNazwa() %>">Bieżące statystyki</a>
  <a href="ranking1.jsp?edycja=<%= edycja.getNazwa() %>">Wyniki wg województw - JUNIOR</a>
  <a href="ranking2.jsp?edycja=<%= edycja.getNazwa() %>">Wyniki wg województw - SENIOR</a>
  <% } 
  else {%>
  <a href="statystyki.jsp?edycja=<%= edycja.getNazwa() %>">Bieżące statystyki</a>
  <%} %>
  </div>
<%
}
} catch (SQLException e) {
    e.printStackTrace();
}
%>
  <li><a href="regionalneKomitety.jsp">Dane Regionalnych Komitetów Organizacyjnych MK</a></li>
  <li><a href="krajoweKomitety.jsp">Skład Krajowego Komitetu Organizacyjnego MK</a></li>
<c:if test="${uzytk!=null}">
<%@ page import="java.util.*"%>
<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%@ page import="mbg.javaee.config.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<% HttpSession sesja = request.getSession(); 
Uzytkownik zalogowanyU = AppUtils.getLoginedUser(sesja); %>
<c:if test="${zalogowanyU.role.contains('ADMIN')}">
<li><a href="admin.jsp">Panel administratora</a></li>
</c:if>
<c:if test="${zalogowanyU.role.contains('MODERATOR')}">
<li><a href="admin2.jsp">Panel administratora</a></li>
</c:if>
<c:if test="${!zalogowanyU.role.contains('MODERATOR') && zalogowanyU.role.contains('KOORDYNATOR')}">
<li><a href="admin3.jsp">Panel administratora</a></li>
</c:if>
<c:if test="${zalogowanyU.role.contains('NAUCZYCIEL')}">
<li><a href="konto.jsp">Konto</a></li>
</c:if>
</c:if>
</ul>
</div>
</nav>