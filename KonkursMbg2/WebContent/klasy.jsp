<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Klasy</title>

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
List<String> nauczyciele = new ArrayList<String>();
List<String> szkoly = new ArrayList<String>();
List<String> typy = new ArrayList<String>();
List<String> jezyki = new ArrayList<String>();
List<String> edycje = new ArrayList<String>();
String nauczyciel="";
String nauczycielS="";
String szkola="";
String szkolaS="";
String typ="";
String typS="";
String jezyk="";
String jezykS="";
String edycja="";
String edycjaS="";

String sql = "select id_nauczyciel || ', ' || tytul || ' ' || imie || ' ' || nazwisko || ', ' || id_szkola  from nauczyciel";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	nauczyciel=rs.getString(1);
	nauczyciele.add(nauczyciel);
}
rs.close();
stmt.close();

String sql2 = "select id_szkola || ', ' || nazwa || ', ' || miejscowosc from szkola";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	szkola=rs2.getString(1);
	szkoly.add(szkola);
}
rs2.close();
stmt2.close();

String sql3 = "select id_typ_klasy || ', ' || nazwa from typ_klasy";
Statement stmt3 = conn.createStatement();
ResultSet rs3=stmt3.executeQuery(sql3);
while(rs3.next()){
	typ=rs3.getString(1);
	typy.add(typ);
}
rs3.close();
stmt3.close();

String sql4 = "select id_jezyk || ', ' || nazwa from jezyk";
Statement stmt4 = conn.createStatement();
ResultSet rs4=stmt4.executeQuery(sql4);
while(rs4.next()){
	jezyk=rs4.getString(1);
	jezyki.add(jezyk);
}
rs4.close();
stmt4.close();

String sql5 = "select id_edycja || ', ' || nazwa from edycja";
Statement stmt5 = conn.createStatement();
ResultSet rs5=stmt5.executeQuery(sql5);
while(rs5.next()){
	edycja=rs5.getString(1);
	edycje.add(edycja);
}
rs5.close();
stmt5.close();
%>
<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj nową klasę</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasa">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Dodawanie nowej klasy</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="liczba_uczniow">Liczba uczniów:</label>
            <input type="text" id="liczba_uczniow" name="liczba_uczniow">
        </div>
        <div>
            <label for="pref_jezyk">Język:</label>
            <input type="text" list="jezyki" id="pref_jezyk" name="pref_jezyk" size="100"/>
			<datalist id="jezyki">
						  <%
	        for(int i=0;i<jezyki.size();i++) {
	        	jezykS=jezyki.get(i).toString();
	        %>
	        <option value="<%=jezykS %>"><%=jezykS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="szkola">Id szkoły:</label>
            <input type="text" list="szkoly" id="szkola" name="szkola" size="100"/>
			<datalist id="szkoly">
						  <%
	        for(int i=0;i<szkoly.size();i++) {
	        	szkolaS=szkoly.get(i).toString();
	        %>
	        <option value="<%=szkolaS %>"><%=szkolaS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="typ_klasy">Id typu klasy:</label>
             <input type="text" list="typy" id="typ_klasy" name="typ_klasy" size="100"/>
			<datalist id="typy">
						  <%
	        for(int i=0;i<typy.size();i++) {
	        	typS=typy.get(i).toString();
	        %>
	        <option value="<%=typS %>"><%=typS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="nauczyciel">Id nauczyciela:</label>
            <input type="text" list="nauczyciele" id="nauczyciel" name="nauczyciel" size="100"/>
			<datalist id="nauczyciele">
						  <%
	        for(int i=0;i<nauczyciele.size();i++) {
	        	nauczycielS=nauczyciele.get(i).toString();
	        %>
	        <option value="<%=nauczycielS %>"><%=nauczycielS %></option>
	        <%} %>
			</datalist>
		 </div>
		 <div>
            <label for="edycja">Edycja:</label>
            <input type="text" list="edycje" id="edycja" name="edycja" size="100"/>
			<datalist id="edycje">
						  <%
	        for(int i=0;i<edycje.size();i++) {
	        	edycjaS=edycje.get(i).toString();
	        %>
	        <option value="<%=edycjaS %>"><%=edycjaS %></option>
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
            <th>Nazwa</th>
            <th>Liczba uczniów</th>
            <th>Język</th>
            <th>Id szkoły</th>
            <th>Id typu klasy</th>
            <th>Id nauczyciela</th>
            <th>Id edycji</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasa">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie klasy</h2>
    <input type="hidden" id="id_klasa" name="id_klasa">
    <input type="hidden" id="metoda" name="metoda" value="edit">
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="liczba_uczniow">Liczba uczniów:</label>
            <input type="text" id="liczba_uczniow" name="liczba_uczniow">
        </div>
        <div>
            <label for="pref_jezyk">Język:</label>
            <input type="text" list="jezyki" id="pref_jezyk" name="pref_jezyk" size="100"/>
			<datalist id="jezyki">
						  <%
	        for(int i=0;i<jezyki.size();i++) {
	        	jezykS=jezyki.get(i).toString();
	        %>
	        <option value="<%=jezykS %>"><%=jezykS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="szkola">Id szkoły:</label>
            <input type="text" list="szkoly" id="szkola" name="szkola" size="100"/>
			<datalist id="szkoly">
						  <%
	        for(int i=0;i<szkoly.size();i++) {
	        	szkolaS=szkoly.get(i).toString();
	        %>
	        <option value="<%=szkolaS %>"><%=szkolaS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="typ_klasy">Id typu klasy:</label>
             <input type="text" list="typy" id="typ_klasy" name="typ_klasy" size="100"/>
			<datalist id="typy">
						  <%
	        for(int i=0;i<typy.size();i++) {
	        	typS=typy.get(i).toString();
	        %>
	        <option value="<%=typS %>"><%=typS %></option>
	        <%} %>
			</datalist>
        </div>
        <div>
            <label for="nauczyciel">Id nauczyciela:</label>
            <input type="text" list="nauczyciele" id="nauczyciel" name="nauczyciel" size="100"/>
			<datalist id="nauczyciele">
						  <%
	        for(int i=0;i<nauczyciele.size();i++) {
	        	nauczycielS=nauczyciele.get(i).toString();
	        %>
	        <option value="<%=nauczycielS %>"><%=nauczycielS %></option>
	        <%} %>
			</datalist> 
        </div>
        <div>
            <label for="edycja">Edycja:</label>
            <input type="text" list="edycje" id="edycja" name="edycja" size="100"/>
			<datalist id="edycje">
						  <%
	        for(int i=0;i<edycje.size();i++) {
	        	edycjaS=edycje.get(i).toString();
	        %>
	        <option value="<%=edycjaS %>"><%=edycjaS %></option>
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
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasa">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie klasy</h2>
     <h3>Usunięcie klasy spowoduje usunięcie przypisanych do niej wyników!</h3>
    <h3>Czy na pewno chcesz usunąć tą klasę?</h3>
    <input type="hidden" id="id_klasa" name="id_klasa">
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
            url: 'klasa',
            dataSrc:''           
        },
        columns: [
            { data: 'id_klasa' },
            { data: 'nazwa' },
            { data: 'liczba_uczniow' },
            { data: 'pref_jezyk' },
            { data: 'id_szkola' },
            { data: 'id_typ_klasy' },
            { data: 'id_nauczyciel' },
            { data: 'id_edycja' },
            { 
            	data: null,
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
    $('#m02 input[name=id_klasa]').val(rowData.eq(0).text());
    $('#m02 input[name=nazwa]').val(rowData.eq(1).text());
    $('#m02 input[name=liczba_uczniow]').val(rowData.eq(2).text());
    $('#m02 input[name=pref_jezyk]').val(rowData.eq(3).text());
    $('#m02 input[name=szkola]').val(rowData.eq(4).text());
    $('#m02 input[name=typ_klasy]').val(rowData.eq(5).text());
    $('#m02 input[name=nauczyciel]').val(rowData.eq(6).text());
    $('#m02 input[name=edycja]').val(rowData.eq(7).text());
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_klasa]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

</script>

<br>
</div>
</div>
</div>
</body>
</html>