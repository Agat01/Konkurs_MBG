<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Klasa - Region</title>

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
List<String> regiony = new ArrayList<String>();
List<String> klasy = new ArrayList<String>();
String region="";
String regionS="";
String klasa="";
String klasaS="";

String sql = "select id_region || ', ' || nazwa from region";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	region=rs.getString(1);
	regiony.add(region);
}
rs.close();
stmt.close();

String sql2 = "select k.id_klasa || ', ' || k.nazwa || ': ' || k.id_szkola || ', ' || sz.nazwa || ', ' || miejscowosc \r\n"
		+ "from klasa k join szkola sz on(k.id_szkola=sz.id_szkola)\r\n"
		+ "           left join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
		+ "where kr.id_klasa is null\r\n"
		+ "order by k.id_klasa";
Statement stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(sql2);
while(rs2.next()){
	klasa=rs2.getString(1);
	klasy.add(klasa);
}
rs2.close();
stmt2.close();
%>
<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj klasę do regionu</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasaRegion">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Przypisanie klasy do regionu</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
      <div>
            <label for="klasa">Klasa:</label>
            <input type="text" list="klasy" id="klasa" name="klasa" onchange="get_data()" size="100"/>
			<datalist id="klasy">
			<%
	        for(int i=0;i<klasy.size();i++) {
	        	klasaS=klasy.get(i).toString();
	        %>
	        <option value="<%=klasaS %>"><%=klasaS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="kl" name="kl" value="">
          
        </div>
        <div>
            <label for="region">Region:</label>
            <input type="text" list="regiony" id="region" name="region" onchange="get_data()" size="100"/>
			<datalist id="regiony">
						  <%
	        for(int i=0;i<regiony.size();i++) {
	        	regionS=regiony.get(i).toString();
	        %>
	        <option value="<%=regionS %>"><%=regionS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="reg" name="reg" value="">
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
            <th>Id klasy</th>
            <th>Id regionu</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasaRegion">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie</h2>
    <input type="hidden" id="id_klasa_region" name="id_klasa_region">
    <input type="hidden" id="metoda" name="metoda" value="edit">
     <div>
            <label for="klasa">Klasa:</label>
            <input type="text" list="klasy" id="klasa" name="klasa" onchange="get_data()" size="100"/>
			<datalist id="klasy">
						  <%
	        for(int i=0;i<klasy.size();i++) {
	        	klasaS=klasy.get(i).toString();
	        %>
	        <option value="<%=klasaS %>"><%=klasaS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="kl" name="kl" value="">
          
        </div>
        <div>
            <label for="region">Region:</label>
            <input type="text" list="regiony" id="region" name="region" onchange="get_data()" size="100"/>
			<datalist id="regiony">
						  <%
	        for(int i=0;i<regiony.size();i++) {
	        	regionS=regiony.get(i).toString();
	        %>
	        <option value="<%=regionS %>"><%=regionS %></option>
	        <%} %>
			</datalist>
			<input type="hidden" id="reg" name="reg" value="">
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
  <form class="modal-content animate" method="post" action="/KonkursMbg/klasaRegion">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie przypisania klasy do regionu</h2>
    <h3>Czy na pewno chcesz usunąć?</h3>
    <input type="hidden" id="id_klasa_region" name="id_klasa_region">
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
            url: 'klasaRegion',
            dataSrc:''           
        },
        columns: [
            { data: 'id_klasa_region' },
            { data: 'id_klasa' },
            { data: 'id_region' },
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
    $('#m02 input[name=id_klasa_region]').val(rowData.eq(0).text());
    $('#m02 input[name=klasa]').val(rowData.eq(1).text());
    $('#m02 input[name=region]').val(rowData.eq(2).text());
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_klasa_region]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

function get_data(){
	  var val = document.getElementById("region").value;
	  var x = document.getElementById("reg").value=val;
	 
	  var val2 = document.getElementById("klasa").value;
	  var x2 = document.getElementById("kl").value=val2;
}

</script>

<br>
</div>
</div>
</div>
</body>
</html>