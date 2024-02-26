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
// Get the modal
var modal = document.getElementById('id01');
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script></li>
</c:if>
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
<li><div class=button>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
Connection conn = DatabaseConnectionManager.getConnection();
List<String> role = new ArrayList<String>();

String rola="";
String rolaS="";

String sql = "select nazwa from rola where id_rola!=3";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	rola=rs.getString(1);
	role.add(rola);
}
rs.close();
stmt.close();

%>	
<button id="rej" onclick="document.getElementById('id02').style.display='block'">Rejestracja</button>
<div id="id02" class="modal">
  <form class="modal-content animate" method="post" action="${pageContext.request.contextPath}/rejestracja">
  <input type="hidden" name="redirectId" value="${param.redirectId}" />
    <div class="imgcontainer">
      <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <label for="rola"><b>Wybierz role:</b></label>
    <select name="rola" id="rola" multiple>
		<%
        for(int i=0;i<role.size();i++) {
        	rolaS=role.get(i).toString();
        %>
        <option value="<%=rolaS %>"><%=rolaS %></option>
        <%} %>
		</select>
		<input type="hidden" id="rol" name="rol" value="">
      <input type="text" placeholder="Podaj nazwę użytkownika" id="nazwa_uzytkownika" name="nazwa_uzytkownika" required>

      <input type="password" placeholder="Podaj hasło" id="haslo" name="haslo" required>

      <input type="password" placeholder="Powtórz hasło" id="haslo2" name="haslo2" required>
      <button id="log2" type="submit" name="save" onclick="change()">Zarejestruj użytkownika</button> 
      <script type="text/javascript">
    function change() {
				var wybrola = document.getElementById("rola").options[document.getElementById("rola").selectedIndex].value; 
			    var x1 = document.getElementById("rol").value=wybrola;
    }
		</script>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="rej" type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Anuluj</button>
    </div>
    
  </form>
</div>
</div>
<script>
// Get the modal
var modal = document.getElementById('id02');
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script></li>
  <li><a href="admin.jsp">Panel</a></li> 
  <li><a href="dyrektorzy.jsp">Dyrektorzy</a></li> 
  <li><a href="edycje.jsp">Edycje</a></li>
  <li><a href="jezyki.jsp">Języki</a></li>
  <li><a href="klasy.jsp">Klasy</a></li>
  <li><a href="klasyRegion.jsp">Klasa - Region</a></li>
  <li><a href="nauczyciele.jsp">Nauczyciele</a></li>
  <li><a href="powiaty.jsp">Powiaty</a></li>
  <li><a href="regiony.jsp">Regiony</a></li>
  <li><a href="role.jsp">Role</a></li>
  <li><a href="szkoly.jsp">Szkoły</a></li>
  <li><a href="typyKlas.jsp">Typy klas</a></li>
  <li><a href="uzytkownicy.jsp">Użytkownicy</a></li>
  <li><a href="uzytkownicyRole.jsp">Użytkownik - Rola</a></li>
  <li><a href="wojewodztwa.jsp">Województwa</a></li>
  <li><a href="wyniki.jsp">Wyniki</a></li>
  <li><a href="zadania.jsp">Zadania</a></li>
  <li><a href="rejestracjaZgloszen.jsp">Rejestracja zgłoszeń</a></li>
  <li><a href="wprowadzanieWynikow.jsp">Wprowadzanie wyników</a></li>
  <li><a href="wysylanieEmaili.jsp">Wysyłanie E-maili</a></li>
</c:if>
<c:if test="${zalogowanyU.role.contains('MODERATOR')}">
  <li><a href="admin2.jsp">Panel</a></li> 
  <li><a href="edycje.jsp">Edycje</a></li>
  <li><a href="rejestracjaZgloszen.jsp">Rejestracja zgłoszeń</a></li>
  <li><a href="wprowadzanieWynikow.jsp">Wprowadzanie wyników</a></li>
  <li><a href="wysylanieEmaili.jsp">Wysyłanie E-maili</a></li>
</c:if>
<c:if test="${!zalogowanyU.role.contains('MODERATOR') && zalogowanyU.role.contains('KOORDYNATOR')}">
  <li><a href="admin3.jsp">Panel</a></li> 
  <li><a href="rejestracjaZgloszen.jsp">Rejestracja zgłoszeń</a></li>
  <li><a href="wprowadzanieWynikow.jsp">Wprowadzanie wyników</a></li>
  <li><a href="strona.jsp">Strona główna</a></li>
</c:if>
</c:if>
</ul>
</div>
</nav>