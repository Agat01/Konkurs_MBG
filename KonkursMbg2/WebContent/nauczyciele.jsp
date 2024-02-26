<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nauczyciele</title>

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
List<String> szkoly = new ArrayList<String>();
String szkola="";
String szkolaS="";

String sql2 = "select id_szkola || ', ' || nazwa || ', ' || miejscowosc from szkola";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	szkola=rs2.getString(1);
	szkoly.add(szkola);
}
rs2.close();
stmt2.close();

%>
<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj nowego nauczyciela</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/nauczyciel">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Dodawanie nowego nauczyciela</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
      <div>
            <label for="tytul">Tytuł:</label>
            <input type="text" id="tytul" name="tytul">
        </div>
        <div>
            <label for="imie">Imie:</label>
            <input type="text" id="imie" name="imie">
        </div>
        <div>
            <label for="nazwisko">Nazwisko:</label>
            <input type="text" id="nazwisko" name="nazwisko">
        </div>
       <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email">
        </div>
        <div>
            <label for="szkola">Id szkoły:</label>
            <input type="text" list="szkoly" id="szkola" name="szkola" onchange="get_data()" size="100"/>
			<datalist id="szkoly">
						  <%
	        for(int i=0;i<szkoly.size();i++) {
	        	szkolaS=szkoly.get(i).toString();
	        %>
	        <option value="<%=szkolaS %>"><%=szkolaS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="szk" name="szk" value="">
        </div>
        <div>
            <label for="nr_tel">Telefon:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="czy_koordynuje">Czy jest koordynatorem w szkole?:</label>
        	<select id="czy_koordynuje" name="czy_koordynuje" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="koor" name="koor" value="">
		</div>
		<div>
            <label for="komisja">Czy wyraził/a chęć na udział w komisji?:</label>
        	<select id="komisja" name="komisja" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="kom" name="kom" value="">
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
            <th>Tytuł</th>
            <th>Imie</th>
            <th>Nazwisko</th>
            <th>Email</th>
            <th>Id szkoły</th>
            <th>Koordynator</th>
            <th>Nr tel</th>
            <th>Komisja</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/nauczyciel">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie nauczyciela</h2>
    <input type="hidden" id="id_nauczyciel" name="id_nauczyciel">
    <input type="hidden" id="metoda" name="metoda" value="edit">
      <div>
            <label for="tytul">Tytuł:</label>
            <input type="text" id="tytul" name="tytul">
        </div>
        <div>
            <label for="imie">Imię:</label>
            <input type="text" id="imie" name="imie">
        </div>
        <div>
            <label for="nazwisko">Nazwisko:</label>
            <input type="text" id="nazwisko" name="nazwisko">
        </div>
        <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email">
        </div>
        <div>
            <label for="szkola">Id szkoły:</label>
            <input type="text" list="szkoly" id="szkola" name="szkola" onchange="get_data()" size="100"/>
			<datalist id="szkoly">
						  <%
	        for(int i=0;i<szkoly.size();i++) {
	        	szkolaS=szkoly.get(i).toString();
	        %>
	        <option value="<%=szkolaS %>"><%=szkolaS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="szk" name="szk" value="">
        </div>
        <div>
            <label for="nr_tel">Telefon:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="czy_koordynuje">Czy jest koordynatorem w szkole?:</label>
        	<select id="czy_koordynuje" name="czy_koordynuje" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="koor" name="koor" value="">
		</div>
		<div>
            <label for="komisja">Czy wyraził/a chęć na udział w komisji?:</label>
        	<select id="komisja" name="komisja" onchange="get_data()">
        		<option value=""> </option>
				<option value="1">Tak</option>
				<option value="0">Nie</option>
			</select>
			<input type="hidden" id="kom" name="kom" value="">
		</div>
        <div>
            <input type="submit" value="Zapisz" name="zapisz">
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
  <form class="modal-content animate" method="post" action="/KonkursMbg/nauczyciel">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie nauczyciela</h2>
     <h3>Usunięcie nauczyciela spowoduje usunięcie przypisanej do niego klasy!</h3>
    <h3>Czy na pewno chcesz usunąć tego nauczyciela?</h3>
    <input type="hidden" id="id_nauczyciel" name="id_nauczyciel">
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
            url: 'nauczyciel',
            dataSrc:''           
        },
        columns: [
            { data: 'id_nauczyciel' },
            { data: 'tytul' },
            { data: 'imie' },
            { data: 'nazwisko' },
            { data: 'email' },
            { data: 'id_szkola' },
            { data: 'czy_koordynuje' },
            { data: 'nr_tel' },
            { data: 'komisja' },
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
    $('#m02 input[name=id_nauczyciel]').val(rowData.eq(0).text());
    $('#m02 input[name=tytul]').val(rowData.eq(1).text());
    $('#m02 input[name=imie]').val(rowData.eq(2).text());
    $('#m02 input[name=nazwisko]').val(rowData.eq(3).text());
    $('#m02 input[name=email]').val(rowData.eq(4).text());
    $('#m02 input[name=szkola]').val(rowData.eq(5).text());
    $('#m02 select[name=czy_koordynuje]').val(rowData.eq(6).text());
    $('#m02 input[name=nr_tel]').val(rowData.eq(7).text());
    $('#m02 select[name=komisja]').val(rowData.eq(8).text());
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_nauczyciel]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

</script>

<br>
</div>
</div>
</div>
</body>
</html>