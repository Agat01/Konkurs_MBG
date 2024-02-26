<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Użytkownik - Rola</title>

<link rel="stylesheet" href="style.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
 <script src="https://cdn.lordicon.com/bhenfmcm.js"></script>
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
<%@ page import="java.util.*" %>

<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
Connection conn = DatabaseConnectionManager.getConnection();
List<String> uzytkownicy = new ArrayList<String>();
List<String> role = new ArrayList<String>();
String uzytkownik="";
String uzytkownikS="";
String rola="";
String rolaS="";

String sql = "select id_uzytkownik || ', ' || nazwa_uzytkownika from uzytkownik";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	uzytkownik=rs.getString(1);
	uzytkownicy.add(uzytkownik);
}
rs.close();
stmt.close();

String sql2 = "select id_rola || ', ' || nazwa from rola order by id_rola";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	rola=rs2.getString(1);
	role.add(rola);
}
rs2.close();
stmt2.close();
%>
<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj rolę do użytkownika</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/uzytkownikRola">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Dodawanie roli do użytkownika</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
    	<div>
            <label for="uzytkownik">Użytkownik:</label>
            <input type="text" list="uzytkownicy" id="uzytkownik" name="uzytkownik" size="100"/>
			<datalist id="uzytkownicy">
						  <%
	        for(int i=0;i<uzytkownicy.size();i++) {
	        	uzytkownikS=uzytkownicy.get(i).toString();
	        %>
	        <option value="<%=uzytkownikS %>"><%=uzytkownikS %></option>
	        <%} %>
			</datalist>
        </div>
      	<div>
            <label for="rola">Rola:</label>
            <input type="text" list="role" id="rola" name="rola" size="100"/>
			<datalist id="role">
						  <%
	        for(int i=0;i<role.size();i++) {
	        	rolaS=role.get(i).toString();
	        %>
	        <option value="<%=rolaS %>"><%=rolaS %></option>
	        <%} %>
			</datalist>
		</div>
        <div>
            <input type="submit" value="Dodaj">
        </div>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="log" type="button" onclick="document.getElementById('m01').style.display='none'" class="cancelbtn">Anuluj</button>
      
    </div>
  </form>
</div>
<script>
var modal = document.getElementById('m01');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>


<table id="table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Id użytkownika</th>
            <th>Id roli</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/uzytkownikRola">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie</h2>
    <input type="hidden" id="id_uzytkownik_rola" name="id_uzytkownik_rola">
    <input type="hidden" id="metoda" name="metoda" value="edit">
    	<div>
            <label for="uzytkownik">Użytkownik:</label>
            <input type="text" list="uzytkownicy" id="uzytkownik" name="uzytkownik" size="100"/>
			<datalist id="uzytkownicy">
						  <%
	        for(int i=0;i<uzytkownicy.size();i++) {
	        	uzytkownikS=uzytkownicy.get(i).toString();
	        %>
	        <option value="<%=uzytkownikS %>"><%=uzytkownikS %></option>
	        <%} %>
			</datalist>
        </div>
     	<div>
            <label for="rola">Rola:</label>
            <input type="text" list="role" id="rola" name="rola" size="100"/>
			<datalist id="role">
						  <%
	        for(int i=0;i<role.size();i++) {
	        	rolaS=role.get(i).toString();
	        %>
	        <option value="<%=rolaS %>"><%=rolaS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <input type="submit" value="Zapisz">
        </div>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      <button id="log" type="button" onclick="document.getElementById('m02').style.display='none'" class="cancelbtn">Anuluj</button>
      
    </div>
  </form>
</div>
<script>
var modal = document.getElementById('m02');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<div id="m03" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/uzytkownikRola">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie roli użytkownika</h2>
    <h3>Czy na pewno chcesz usunąć?</h3>
    <input type="hidden" id="id_uzytkownik_rola" name="id_uzytkownik_rola">
    <input type="hidden" id="metoda" name="metoda" value="delete">
      
        <div>
            <button type="submit" class="usun">Usuń</button>
      <button type="button" class="usun" onclick="document.getElementById('m03').style.display='none'" class="cancel-btn">Anuluj</button>
        </div>
    </div>
    <div class="container" style="background-color:#f1f1f1">
      
    </div>
  </form>
</div>
<script>
var modal = document.getElementById('m03');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<script type="text/javascript">

$(document).ready(function() {
    $('#table').dataTable({
        ajax: {
            url: 'uzytkownikRola',
            dataSrc:''           
        },
        columns: [
            { data: 'id_uzytkownik_rola' },
            { data: 'id_uzytkownik' },
            { data: 'id_rola' },
            { data: null,
          	  render: function(data, type, row) {
          	    return '<span class="edit" onclick="document.getElementById(\'m02\').style.display=\'block\'">' +
          	             '<lord-icon ' +
          	             'src="https://cdn.lordicon.com/wloilxuq.json" ' +
          	             'trigger="hover" ' +
          	             'colors="primary:#339989,secondary:#e8b730" ' +
          	             'stroke="70" ' +
          	             'state="hover-2" ' +
          	             'style="width:25px;height:25px"></lord-icon>' +
          	             '</span>' +
          	             '<span class="delete" onclick="document.getElementById(\'m03\').style.display=\'block\'">' +
          	             '<lord-icon '+
          	             'src="https://cdn.lordicon.com/gsqxdxog.json" '+
          	             'trigger="hover" '+
          	             'colors="primary:#339989,secondary:#e8b730" '+
          	             'state="hover-empty" '+
          	             'style="width:25px;height:25px"> '+
          	             '</lord-icon>'+
          	             '</span>';
        }
            }
        ],
        columnDefs: [{
            targets: '_all',
            defaultContent: ""
        }],
    });
});

$(document).on('click', '.edit', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m02 input[name=id_uzytkownik_rola]').val(rowData.eq(0).text());
    $('#m02 input[name=uzytkownik]').val(rowData.eq(1).text());
    $('#m02 input[name=rola]').val(rowData.eq(2).text());
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_uzytkownik_rola]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

</script>

<br>
</div>
</div>
</div>
</body>
</html>