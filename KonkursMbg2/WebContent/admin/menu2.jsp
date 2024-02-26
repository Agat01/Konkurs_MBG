<nav>
<div class="topnav">
<ul id="menu">
<li><span style="color:red">[${zalogowanyU.nazwa_uzytkownika}]</span></li>
<li><div class=button>
<button id="log" onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Logowanie</button>
<div id="id01" class="modal">
  <form class="modal-content animate" method="post" action="${pageContext.request.contextPath}/login">
  <input type="hidden" name="redirectId" value="${param.redirectId}" />
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
      <label for="nazwa_uzytkownika"><b>Nazwa użytkownika</b></label>
      <input type="text" placeholder="Enter Username" id="nazwa_uzytkownika" name="nazwa_uzytkownika" value= "${uzytkownik.nazwa_uzytkownika}" required>

      <label for="haslo"><b>Hasło</b></label>
      <input type="password" placeholder="Enter Password" id="haslo" name="haslo" value= "${uzytkownik.haslo}" required>
        
      <button id="log" type="submit">Zaloguj się</button>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="log" type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
      
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

<li><div class=button>
	<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
Connection conn = DatabaseConnectionManager.getConnection();
List<String> role = new ArrayList<String>();

String rola="";
String rolaS="";

String sql = "select nazwa from rola where id_rola not in (1,2,3)";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	rola=rs.getString(1);
	role.add(rola);
}
rs.close();
stmt.close();

%>	
<button id="rej" onclick="document.getElementById('id02').style.display='block'" style="width:auto;">Rejestracja</button>
<div id="id02" class="modal">
  <form class="modal-content animate" method="post" action="${pageContext.request.contextPath}/rejestracja">
  <input type="hidden" name="redirectId" value="${param.redirectId}" />
    <div class="imgcontainer">
      <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <label for="rola"><b>Rola</b></label>
    <select name="rola" id="rola">
					  <%
        for(int i=0;i<role.size();i++) {
        	rolaS=role.get(i).toString();
        %>
        <option value="<%=rolaS %>"><%=rolaS %></option>
        <%} %>
		</select>
		<input type="hidden" id="rol" name="rol" value="">
      <label for="nazwa_uzytkownika"><b>Nazwa użytkownika</b></label>
      <input type="text" placeholder="Enter Username" id="nazwa_uzytkownika" name="nazwa_uzytkownika" required>

      <label for="haslo"><b>Hasło</b></label>
      <input type="password" placeholder="Enter Password" id="haslo" name="haslo" required>
      
       <label for="haslo2"><b>Powtórz hasło</b></label>
      <input type="password" placeholder="Enter Password" id="haslo2" name="haslo2" required>
      
      <input type="submit" value="Zarejestruj się" name="save" onclick="change()" />  
      <script type="text/javascript">
    function change() {
				var wybrola = document.getElementById("rola").options[document.getElementById("rola").selectedIndex].value; 
			    var x1 = document.getElementById("rol").value=wybrola;
    }
		</script>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="rej" type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button>
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
<li><a href="${pageContext.request.contextPath}/wylogowanie">Wyloguj</a></li>
  <li><a href="/admin.jsp">Strona główna</a></li> 
  <li><a href="admin/dyrektorzy.jsp">Dyrektorzy</a></li> 
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
  <li><a href="zadania.jsp">Zadania</a></li>
  <li><a href="wyniki.jsp">Wyniki</a></li>
  <li><a href="${pageContext.request.contextPath}/wprowadzanieWynikow">Wprowadzanie wyników</a></li>
  <li><a href="${pageContext.request.contextPath}/wysylanieEmaili">Wysyłanie E-maili</a></li>
</ul>
</div>
</nav>