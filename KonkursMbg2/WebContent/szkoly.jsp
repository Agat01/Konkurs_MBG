<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Szkoły</title>

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
List<String> dyrektorzy = new ArrayList<String>();
List<String> powiaty = new ArrayList<String>();
String dyrektor="";
String dyrektorS="";
String powiat="";
String powiatS="";

String sql = "select id_dyrektor || ', ' || tytul || ' ' || imie || ' ' || nazwisko from dyrektor";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	dyrektor=rs.getString(1);
	dyrektorzy.add(dyrektor);
}
rs.close();
stmt.close();

String sql2 = "select id_powiat || ', ' || nazwa from powiat";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	powiat=rs2.getString(1);
	powiaty.add(powiat);
}
rs2.close();
stmt2.close();


%>
<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj nową szkołę</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/szkolaT">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Dodawanie nowej szkoły</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
    <div>
            <label for="miejscowosc">Miejscowość:</label>
            <input type="text" id="miejscowosc" name="miejscowosc"/>
        </div>
        <div>
            <label for="nazwa_zespolu_szkol">Nazwa zespołu szkół:</label>
            <input type="text" id="nazwa_zespolu_szkol" name="nazwa_zespolu_szkol">
        </div>
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="imienia">Szkoła imienia:</label>
            <input type="text" id="imienia" name="imienia"/>
        </div>
        <div>
            <label for="nr_tel">Numer telefonu:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="email">Adres e-mail:</label>
            <input type="text" id="email" name="email">
        </div>
        <div>
            <label for="dyrektor">Dyrektor:</label>
             <input type="text" list="dyrektorzy" id="dyrektor" name="dyrektor" onchange="get_data()" size="100"/>
			<datalist id="dyrektorzy">
						  <%
	        for(int i=0;i<dyrektorzy.size();i++) {
	        	dyrektorS=dyrektorzy.get(i).toString();
	        %>
	        <option value="<%=dyrektorS %>"><%=dyrektorS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="dyr" name="dyr" value="">
        </div>
        <div>
            <label for="powiat">Powiat:</label>
            <input type="text" list="powiaty" id="powiat" name="powiat" onchange="get_data()" size="100"/>
			<datalist id="powiaty">
						  <%
	        for(int i=0;i<powiaty.size();i++) {
	        	powiatS=powiaty.get(i).toString();
	        %>
	        <option value="<%=powiatS %>"><%=powiatS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="pow" name="pow" value="">
        </div>
        <div>
            <label for="ulica">Ulica:</label>
            <input type="text" id="ulica" name="ulica">
        </div>
        <div>
            <label for="nr_domu">Nr domu:</label>
            <input type="text" id="nr_domu" name="nr_domu">
        </div>
        <div>
            <label for="kod_pocztowy">Kod pocztowy:</label>
            <input type="text" id="kod_pocztowy" name="kod_pocztowy">
        </div>
        <div>
            <label for="miejscowosc2">Miejscowość:</label>
            <input type="text" id="miejscowosc2" name="miejscowosc2">
        </div>
         <div>
            <label for="active">Czy jest aktywna?:</label>
        	<select id="active" name="active" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="act" name="act" value="">
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
            <th>Miejscowość</th>
            <th>Zespoł szkół</th>
            <th>Nazwa</th>
            <th>Imienia</th>
            <th>Nr tel</th>
            <th>E-mail</th>
            <th>Id dyrektora</th>
            <th>Id powiatu</th>
            <th>Ulica</th>
            <th>Nr domu</th>
            <th>Kod pocztowy</th>
            <th>Miejscowość</th>
            <th>Active</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/szkolaT">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie szkoly</h2>
    <input type="hidden" id="id_szkola" name="id_szkola">
    <input type="hidden" id="metoda" name="metoda" value="edit">
    	 <div>
            <label for="miejscowosc">Miejscowość:</label>
            <input type="text" id="miejscowosc" name="miejscowosc"/>
        </div>
        <div>
            <label for="nazwa_zespolu_szkol">Nazwa zespołu szkół:</label>
            <input type="text" id="nazwa_zespolu_szkol" name="nazwa_zespolu_szkol">
        </div>
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="imienia">Szkoła imienia:</label>
            <input type="text" id="imienia" name="imienia"/>
        </div>
        <div>
            <label for="nr_tel">Numer telefonu:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="email">Adres e-mail:</label>
            <input type="text" id="email" name="email">
        </div>
        <div>
            <label for="dyrektor">Dyrektor:</label>
             <input type="text" list="dyrektorzy" id="dyrektor" name="dyrektor" onchange="get_data()" size="100"/>
			<datalist id="dyrektorzy">
						  <%
	        for(int i=0;i<dyrektorzy.size();i++) {
	        	dyrektorS=dyrektorzy.get(i).toString();
	        %>
	        <option value="<%=dyrektorS %>"><%=dyrektorS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="dyr" name="dyr" value="">
        </div>
        <div>
            <label for="powiat">Powiat:</label>
            <input type="text" list="powiaty" id="powiat" name="powiat" onchange="get_data()" size="100"/>
			<datalist id="powiaty">
						  <%
	        for(int i=0;i<powiaty.size();i++) {
	        	powiatS=powiaty.get(i).toString();
	        %>
	        <option value="<%=powiatS %>"><%=powiatS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="pow" name="pow" value="">
        </div>
        <div>
            <label for="ulica">Ulica:</label>
            <input type="text" id="ulica" name="ulica">
        </div>
        <div>
            <label for="nr_domu">Nr domu:</label>
            <input type="text" id="nr_domu" name="nr_domu">
        </div>
        <div>
            <label for="kod_pocztowy">Kod pocztowy:</label>
            <input type="text" id="kod_pocztowy" name="kod_pocztowy">
        </div>
        <div>
            <label for="miejscowosc2">Miejscowość:</label>
            <input type="text" id="miejscowosc2" name="miejscowosc2">
        </div>
         <div>
            <label for="active">Czy jest aktywna?:</label>
        	<select id="active" name="active" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="act" name="act" value="">
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
  <form class="modal-content animate" method="post" action="/KonkursMbg/szkolaT">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie szkoły</h2>
     <h3>Usunięcie szkoły spowoduje usunięcie przypisanych do niej klas!</h3>
    <h3>Czy na pewno chcesz usunąć tę szkołę?</h3>
    <input type="hidden" id="id_szkola" name="id_szkola">
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
            url: 'szkolaT',
            dataSrc:''           
        },
        columns: [
            { data: 'id_szkola' },
            { data: 'miejscowosc' },
            { data: 'nazwa_zespolu_szkol' },
            { data: 'nazwa' },
            { data: 'imienia' },
            { data: 'nr_tel' },
            { data: 'email' },
            { data: 'id_dyrektor' },
            { data: 'id_powiat' },
            { data: 'ulica' },
            { data: 'nr_domu' },
            { data: 'kod_pocztowy' },
            { data: 'miejscowosc2' },
            { data: 'active' },
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
    $('#m02 input[name=id_szkola]').val(rowData.eq(0).text());
    $('#m02 input[name=miejscowosc]').val(rowData.eq(1).text());
    $('#m02 input[name=nazwa_zespolu_szkol]').val(rowData.eq(2).text());
    $('#m02 input[name=nazwa]').val(rowData.eq(3).text());
    $('#m02 input[name=imienia]').val(rowData.eq(4).text());
    $('#m02 input[name=nr_tel]').val(rowData.eq(5).text());
    $('#m02 input[name=email]').val(rowData.eq(6).text());  
    var idDyrektor = rowData.eq(7).text();
    var datalist = $('#m02 input[name=dyrektor]').attr('dyrektorzy');
    var dyrektor="";
    var opcje= $('#' + datalist + ' option');
    opcje.each(function() {
    	  var opcja = $(this).val();
    	  var elementy = opcja.split(', ');
    	  if (elementy[0] === idDyrektor) {
    	    var dyrektor = elementy[1]; 
    	    return false; 
    	  }
    	});
    $('#m02 input[name=dyrektor]').attr('value', idDyrektor+', '+dyrektor); 
//    $('#m02 input[name=dyrektor]').attr('value',dyrektor);
  
//    $('#m02 input[name=dyrektor]').val(rowData.eq(7).text());
    $('#m02 input[name=id_powiat]').attr('value',rowData.eq(8).text());
    $('#m02 input[name=ulica]').val(rowData.eq(9).text());
    $('#m02 input[name=nr_domu]').val(rowData.eq(10).text());
    $('#m02 input[name=kod_pocztowy]').val(rowData.eq(11).text());
    $('#m02 input[name=miejscowosc2]').val(rowData.eq(12).text());
    $('#m02 select[name=active]').attr('value',rowData.eq(13).text());
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_szkola]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

function get_data(){
	  var val = document.getElementById("powiat").value;
	  var x = document.getElementById("pow").value=val;
	 
	  var val2 = document.getElementById("active").value;
	  var x2 = document.getElementById("act").value=val2;
	  
	  var val3 = document.getElementById("dyrektor").value;
	  var x3 = document.getElementById("dyr").value=val3;
	
}

</script>

<br>
</div>
</div>
</div>
</body>
</html>