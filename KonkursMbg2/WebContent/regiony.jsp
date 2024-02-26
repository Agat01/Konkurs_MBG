<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Regiony</title>

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

<br>
<button id="dodaj" class="dodaj" onclick="document.getElementById('m01').style.display='block'" style="width:auto;">+ Dodaj nowy region</button>
<div id="m01" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/region">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m01').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Dodawanie nowego regionu</h2>
    <input type="hidden" id="metoda" name="metoda" value="add">
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="adres1">Adres1:</label>
            <input type="text" id="adres1" name="adres1">
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
            <label for="miejscowosc">Miejscowość:</label>
            <input type="text" id="miejscowosc" name="miejscowosc">
        </div>
        <div>
            <label for="przewodniczacy">Przewodniczący:</label>
            <input type="text" id="przewodniczacy" name="przewodniczacy"/>
        </div>
        <div>
            <label for="email">Adres e-mail:</label>
            <input type="text" id="email" name="email">
        </div>
        <div>
            <label for="nr_tel">Numer telefonu:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="www">Adres www:</label>
            <input type="text" id="www" name="www"/>
        </div> 
        <div>
            <label for="z_dopiskiem">Z dopiskiem do adresu:</label>
            <input type="text" id="z_dopiskiem" name="z_dopiskiem"/>
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
            <th>Adres1</th>
            <th>Ulica</th>
            <th>Nr domu</th>
            <th>Kod pocztowy</th>
            <th>Miejscowość</th>
            <th>Przewodniczący</th>
            <th>Email</th>
            <th>Nr tel</th>
            <th>Adres www</th>
            <th>Z dopiskiem</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>


<div id="m02" class="modal">
  <form class="modal-content animate" method="post" action="/KonkursMbg/region">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m02').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Edytowanie regionu</h2>
    <input type="hidden" id="id_region" name="id_region">
    <input type="hidden" id="metoda" name="metoda" value="edit">
      <div>
            <label for="nazwa">Nazwa:</label>
            <input type="text" id="nazwa" name="nazwa">
        </div>
        <div>
            <label for="adres1">Adres1:</label>
            <input type="text" id="adres1" name="adres1">
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
            <label for="miejscowosc">Miejscowość:</label>
            <input type="text" id="miejscowosc" name="miejscowosc">
        </div>
        <div>
            <label for="przewodniczacy">Przewodniczący:</label>
            <input type="text" id="przewodniczacy" name="przewodniczacy"/>
        </div>
        <div>
            <label for="email">Adres e-mail:</label>
            <input type="text" id="email" name="email">
        </div>
        <div>
            <label for="nr_tel">Numer telefonu:</label>
            <input type="text" id="nr_tel" name="nr_tel">
        </div>
        <div>
            <label for="www">Adres www:</label>
            <input type="text" id="www" name="www"/>
        </div> 
        <div>
            <label for="z_dopiskiem">Z dopiskiem do adresu:</label>
            <input type="text" id="z_dopiskiem" name="z_dopiskiem"/>
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
  <form class="modal-content animate" method="post" action="/KonkursMbg/region">
    <div class="imgcontainer">
      <span onclick="document.getElementById('m03').style.display='none'" class="close" title="Close Modal">&times;</span>
      
    </div>
    <div class="container">
    <h2>Usuwanie regionu</h2>
     <h3>Usunięcie regionu spowoduje usunięcie wszystkich przypisanych do region klas!</h3>
    <h3>Czy na pewno chcesz usunąć ten region?</h3>
    <input type="hidden" id="id_region" name="id_region">
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
            url: 'region',
            dataSrc:''           
        },
        columns: [
            { data: 'id_region' },
            { data: 'nazwa' },
            { data: 'adres1' },
            { data: 'ulica' },
            { data: 'nr_domu' },
            { data: 'kod_pocztowy' },
            { data: 'miejscowosc' },
            { data: 'przewodniczacy' },
            { data: 'email' },
            { data: 'nr_tel' },
            { data: 'www' },
            { data: 'z_dopiskiem' },
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
    $('#m02 input[name=id_region]').val(rowData.eq(0).text());
    $('#m02 input[name=nazwa]').val(rowData.eq(1).text());
    $('#m02 input[name=adres1]').val(rowData.eq(2).text());
    $('#m02 input[name=ulica]').val(rowData.eq(3).text());
    $('#m02 input[name=nr_domu]').val(rowData.eq(4).text());
    $('#m02 input[name=kod_pocztowy]').val(rowData.eq(5).text());
    $('#m02 input[name=miejscowosc]').val(rowData.eq(6).text());  
    $('#m02 input[name=przewodniczacy]').val(rowData.eq(7).text());
    $('#m02 input[name=email]').val(rowData.eq(8).text());
    $('#m02 input[name=nr_tel]').val(rowData.eq(9).text());
    $('#m02 input[name=www]').val(rowData.eq(10).text());
    $('#m02 input[name=z_dopiskiem]').val(rowData.eq(11).text());  
    document.getElementById('m02').style.display='block';
});

$(document).on('click', '.delete', function() {
    var rowData = $(this).closest('tr').find('td');
    $('#m03 input[name=id_region]').val(rowData.eq(0).text());
    document.getElementById('m03').style.display='block';
});

</script>

<br>
</div>
</div>
</div>
</body>
</html>