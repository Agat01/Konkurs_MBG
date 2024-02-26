<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wyniki</title>
<link rel="stylesheet" href="sortable.min.css" />
<script src="sortable.min.js"></script>
 <link rel = "stylesheet" href="style.css"/>
</head>
<body>
<div id="kontener">
<div id="left">
 <jsp:include page="menu.jsp"></jsp:include>
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

<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=utf-8");

String nazwaEdycji = request.getParameter("edycja");

Connection conn = DatabaseConnectionManager.getConnection();
	
	int id=0;
	String wojewodztwo="";
	String wojewodztwoS="";
	String klasa="";
	String klasaS="";
	String nazwa="";
	int liczbaUczniow=0;
	String nauczyciel="";
	int wynik=0;
	int miejsceW=0;
	int miejsceK=0;
	int miejsceR=0;
	int liczbaZ=0;
	int liczbaKlas1=0;
	int liczbaKlas2=0;
//	int liczbaKlas3=0;
	int suma=0;
	
	String nazwaSz="";
	String miejscowosc="";
	int idKlasa=0;
	String nazwaK="";
	String woj="";
	int idRegion=0;
	
	List<String> wojewodztwa = new ArrayList<String>();
	  String sql1 = "select distinct(w.nazwa) \r\n"
				+ "from wojewodztwo w join powiat p on(w.id_wojewodztwo=p.id_wojewodztwo)\r\n"
				+ "                    join szkola sz on(p.id_powiat=sz.id_powiat)\r\n"
				+ "                    join klasa k on(sz.id_szkola=k.id_szkola)\r\n"
				+ "                    join wynik w on(w.id_klasa=k.id_klasa)\r\n"
				+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
				+ "order by w.nazwa asc";
	  Statement stmt1 = conn.createStatement();
	  ResultSet rs1=stmt1.executeQuery(sql1);
	  while(rs1.next()){
	  	wojewodztwo=rs1.getString(1);
	  	wojewodztwa.add(wojewodztwo);
	  }
	  rs1.close();
	  stmt1.close();
	  
	  ArrayList<Klasa> klasy1K = new ArrayList<Klasa>();
	  String sql4="select sz.nazwa,sz.miejscowosc, k.id_klasa,k.nazwa, k.liczba_uczniow, n.tytul || ' ' || n.imie || ' ' || n.nazwisko, count(k.id_klasa), sum(wynik)/count(k.id_klasa),w.nazwa \r\n"
	  			+ "from wynik w join klasa k on(w.id_klasa=k.id_klasa)\r\n"
	  			+ "            join szkola sz on(sz.id_szkola=k.id_szkola)\r\n"
	  			+ "            join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
	  			+ "            join wojewodztwo w on(w.id_wojewodztwo=p.id_wojewodztwo)\r\n"
	  			+ "            join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
	  			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
	  			+ "where (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and n.czy_koordynuje=0\r\n"
	  			+ "group by k.id_klasa,k.nazwa,sz.nazwa,sz.miejscowosc,k.id_klasa,k.nazwa, k.liczba_uczniow,n.tytul, n.imie,n.nazwisko, w.nazwa\r\n"
	  			+ "order by sum(wynik) desc";

	  Statement stmt4 = conn.createStatement();
	  ResultSet rs4=stmt4.executeQuery(sql4);
	  while(rs4.next()){
	  	nazwaSz=rs4.getString(1);
	  	miejscowosc=rs4.getString(2);
	  	idKlasa=rs4.getInt(3);
	  	nazwaK=rs4.getString(4);
	  	liczbaUczniow=rs4.getInt(5);
	  	nauczyciel=rs4.getString(6);
	  	liczbaZ=rs4.getInt(7);
	  	wynik=rs4.getInt(8);
	  	woj=rs4.getString(9);
	  	
	  	klasy1K.add(new Klasa(idKlasa,nazwaK,nazwaSz,miejscowosc,nauczyciel,liczbaUczniow,liczbaZ,wynik,woj));

	  }
	  rs4.close();
	  stmt4.close();

	  //Sortowanie uczestników według punktów, a następnie indeksu w liście
	  Collections.sort(klasy1K, new Comparator<Klasa>() {
	      @Override
	      public int compare(Klasa k1, Klasa k2) {
	          if (k2.getWynik() != k1.getWynik()) {
	              return Integer.compare(k2.getWynik(), k1.getWynik());
	          } else {
	              return Integer.compare(klasy1K.indexOf(k1), klasy1K.indexOf(k2));
	          }
	      }
	  });

	  // Nadanie miejsc
	  int miejsce4 = 1;
	  int ostatniePunkty4 = -1;
	  	for (Klasa k : klasy1K) {
	  		int punkty4 = k.getWynik();
	  		if (punkty4 < ostatniePunkty4) {
	  			miejsce4++;
	  	}
	  k.setZajeteMiejsceWKraju(miejsce4);
	  ostatniePunkty4 = punkty4;
	  }	  
	  	
			int n=16;
			ArrayList<ArrayList<Klasa>> wszystkieKlasy = new ArrayList<ArrayList<Klasa>>();
		      for (int i = 1; i <= n; i++) {
		          ArrayList<Klasa> klasy = new ArrayList<Klasa>();
		          String sql="select sz.nazwa,sz.miejscowosc, k.id_klasa,k.nazwa, k.liczba_uczniow, n.tytul || ' ' || n.imie || ' ' || n.nazwisko, count(k.id_klasa), sum(wynik)/count(k.id_klasa), kr.id_region \r\n"
							+ "from wynik w join klasa k on(w.id_klasa=k.id_klasa)\r\n"
							+ "            join szkola sz on(sz.id_szkola=k.id_szkola)\r\n"
							+ "            join klasa_region kr on(kr.id_klasa=k.id_klasa)\r\n"
							+ "            join region r on(r.id_region=kr.id_region)\r\n"
							+ "            join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
							+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
							+ "where r.id_region="+i+" and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and n.czy_koordynuje=0\r\n"
							+ "group by sz.nazwa,sz.miejscowosc, k.id_klasa,k.nazwa, k.liczba_uczniow, n.tytul,n.imie, n.nazwisko,kr.id_region\r\n"
							+ "order by sum(wynik) desc";

				Statement stmt = conn.createStatement();
				ResultSet rs=stmt.executeQuery(sql);
				while(rs.next()){
					nazwaSz=rs.getString(1);
					miejscowosc=rs.getString(2);
					idKlasa=rs.getInt(3);
					nazwaK=rs.getString(4);
					liczbaUczniow=rs.getInt(5);
					nauczyciel=rs.getString(6);
					liczbaZ=rs.getInt(7);
					wynik=rs.getInt(8);
					idRegion=rs.getInt(9);
					
					klasy.add(new Klasa(idKlasa,nazwaK,nazwaSz,miejscowosc,nauczyciel,liczbaUczniow,liczbaZ,wynik,idRegion));
				}
				rs.close();
				stmt.close();      
		      
		//for (int i = 0; i < wszystkieKlasy2.size(); i++) {
//			ArrayList<Klasa> klasy = wszystkieKlasy2.get(i);
				Collections.sort(klasy, new Comparator<Klasa>() {
				  @Override
				  public int compare(Klasa k1, Klasa k2) {
				      if (k2.getWynik() != k1.getWynik()) {
				          return Integer.compare(k2.getWynik(), k1.getWynik());
				      } else {
				          return Integer.compare(klasy.indexOf(k1), klasy.indexOf(k2));
				      }
				  }
				});

				int miejsce = 1;
				int ostatniePunkty = -1;
					for (Klasa k : klasy) {
						int punkty = k.getWynik();
						if (punkty < ostatniePunkty) {
							miejsce++;
					}
				k.setZajeteMiejsceWRegionie(miejsce);
				ostatniePunkty = punkty;
		}

			wszystkieKlasy.add(klasy);
		}
	
%>
<h2>JUNIOR - szkoły podstawowe klasy 5 i 6 - <%= nazwaEdycji %></h2>
<div id="load"></div>
<div id="contents">
<table id="ranking">
<thead>
  <tr>
      <th onclick="sortTable(0)">Województwo</th>
      <th onclick="sortTable(1)">Miejsce w regionie</th>
      <th onclick="sortTable(2)">Miejsce w województwie</th>
      <th onclick="sortTable(3)">Miejsce w kraju</th>
      <th onclick="sortTable(4)">Liczba zadań </th>
      <th onclick="sortTable(5)">Wynik </th>
      <th onclick="sortTable(6)">Klasa </th>
      <th onclick="sortTable(7)">Liczba uczniów</th>
      <th onclick="sortTable(8)">Nauczyciel</th>
      <th onclick="sortTable(9)">Szkoła</th>
      <th onclick="sortTable(10)">Miejscowość</th>
</tr>
   </thead>
<tbody>
 <%
        for(int i=0;i<wojewodztwa.size();i++) {
            wojewodztwoS=wojewodztwa.get(i).toString();

ArrayList<Klasa> klasy1 = new ArrayList<Klasa>();
String sql="select sz.nazwa,sz.miejscowosc, k.id_klasa,k.nazwa, k.liczba_uczniow, n.tytul || ' ' || n.imie || ' ' || n.nazwisko, count(k.id_klasa), sum(wynik)/count(k.id_klasa), w.nazwa \r\n"
			+ "from wynik w join klasa k on(w.id_klasa=k.id_klasa)\r\n"
			+ "            join szkola sz on(sz.id_szkola=k.id_szkola)\r\n"
			+ "            join powiat p on(sz.id_powiat=p.id_powiat)\r\n"
			+ "            join wojewodztwo w on(w.id_wojewodztwo=p.id_wojewodztwo)\r\n"
			+ "            join nauczyciel n on(n.id_nauczyciel=k.id_nauczyciel)\r\n"
			+ "join edycja e on(e.id_edycja=k.id_edycja)\r\n"
			+ "where w.nazwa='"+wojewodztwoS+"' and (k.id_typ_klasy=1 or k.id_typ_klasy=2) and sz.active='1' and e.nazwa='"+nazwaEdycji+"' and n.czy_koordynuje=0\r\n"
			+ "group by k.id_klasa,k.nazwa,sz.nazwa,sz.miejscowosc,k.id_klasa,k.nazwa, k.liczba_uczniow,n.tytul, n.imie,n.nazwisko,w.nazwa\r\n"
			+ "order by sum(wynik) desc";

Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	nazwaSz=rs.getString(1);
	miejscowosc=rs.getString(2);
	idKlasa=rs.getInt(3);
	nazwaK=rs.getString(4);
	liczbaUczniow=rs.getInt(5);
	nauczyciel=rs.getString(6);
	liczbaZ=rs.getInt(7);
	wynik=rs.getInt(8);
	woj=rs.getString(9);
	
	klasy1.add(new Klasa(idKlasa,nazwaK,nazwaSz,miejscowosc,nauczyciel,liczbaUczniow,liczbaZ,wynik,woj));
//	liczbaKlas1++;

}
rs.close();
stmt.close();

//Sortowanie uczestników według punktów, a następnie indeksu w liście
Collections.sort(klasy1, new Comparator<Klasa>() {
    @Override
    public int compare(Klasa k1, Klasa k2) {
        if (k2.getWynik() != k1.getWynik()) {
            return Integer.compare(k2.getWynik(), k1.getWynik());
        } else {
            return Integer.compare(klasy1.indexOf(k1), klasy1.indexOf(k2));
        }
    }
});

// Nadanie miejsc
int miejsce = 1;
int ostatniePunkty = -1;
	for (Klasa k : klasy1) {
		int punkty = k.getWynik();
		if (punkty < ostatniePunkty) {
			miejsce++;
	}
k.setZajeteMiejsceWWojewodztwie(miejsce);
ostatniePunkty = punkty;
}



	


   for(int i2=0;i2<klasy1.size();i2++) {
   	idKlasa=klasy1.get(i2).getId_klasa();
       nazwaK=klasy1.get(i2).getNazwa();
       nauczyciel=klasy1.get(i2).getNauczyciel();
       liczbaUczniow=klasy1.get(i2).getLiczbaUczniow();
       nazwaSz=klasy1.get(i2).getNazwaSz();
       miejscowosc=klasy1.get(i2).getMiejscowosc();
       liczbaZ=klasy1.get(i2).getLiczbaZ();
       wynik=klasy1.get(i2).getWynik();
       miejsceW=klasy1.get(i2).getZajeteMiejsceWWojewodztwie();
       
       for(Klasa k:klasy1K){
       	if(k.getId_klasa()==idKlasa){
       		miejsceK=k.getZajeteMiejsceWKraju();
       		break;
       	}
       }
       for (ArrayList<Klasa> klasy : wszystkieKlasy) {
           for (Klasa k2 : klasy) {
               if (k2.getId_klasa() == idKlasa) {
            	   miejsceR=k2.getZajeteMiejsceWRegionie();
            	   idRegion=k2.getIdRegion();
            	   break;
               }
           }
       }
       
   %>
  <tr>
  	<td><%=wojewodztwoS %></td>
  	<td><%=miejsceR %></td>
	<td><%=miejsceW %></td>
	<td><%=miejsceK %></td>
    <td><%=liczbaZ %></td>
    <td><%=wynik %></td>
    <td><%=nazwaK %></td>
    <td><%=liczbaUczniow %></td>
    <td><%=nauczyciel %></td>
    <td><%=nazwaSz %></td>
    <td><%=miejscowosc %></td>
   </tr>
    <%} 
   klasy1.clear();
    }%>
	</tbody>
	</table>
</div>
<script type="text/javascript">

var initialColumn = 5; // Numer kolumny, w której znajduje się wynik
var table = document.getElementById("ranking");
var rows = Array.from(table.rows).slice(1); // Pobierz wszystkie wiersze poza nagłówkiem
var dir = "desc";

// Sortuj wiersze początkowo
rows.sort(function(a, b) {
  var x = a.cells[initialColumn].innerHTML;
  var y = b.cells[initialColumn].innerHTML;
  return parseInt(y) - parseInt(x); // Sortuj malejąco po wyniku (liczbie)
});

// Umieść posortowane wiersze z powrotem w tabeli
for (var i = 0; i < rows.length; i++) {
  table.tBodies[0].appendChild(rows[i]);
}

var initialHeaderCell = table.rows[0].cells[initialColumn];
initialHeaderCell.innerHTML += " &#9660;";

function sortTable(n) {
const p=[1,2,3,4,5,7];
	  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
	  table = document.getElementById("ranking");
	  switching = true;
	  dir = "asc";
	  var initialColumn = 4;
	  rows = table.rows;
		var initialHeaderCell = table.rows[0].cells[initialColumn];
		initialHeaderCell.innerHTML = initialHeaderCell.innerHTML.replace(" &#9660;", "");
	  // loop through each header cell and add a span element with a triangle icon
	  var headerCells = table.getElementsByTagName("th");
	  for (i = 0; i < headerCells.length; i++) {
	    if (i != n) {
	      // remove any existing span elements from other header cells
	      if (headerCells[i].getElementsByTagName("span").length > 0) {
	        headerCells[i].removeChild(headerCells[i].getElementsByTagName("span")[0]);
	      }
	      continue;
	    }
	    var span = document.createElement("span");
	    span.classList.add("sort-icon");
	    headerCells[i].appendChild(span);
	  }
	  
	  while (switching) {
	    switching = false;
	    rows = table.rows;
	    for (i = 1; i < (rows.length - 1); i++) {
	      shouldSwitch = false;
	      x = rows[i].getElementsByTagName("TD")[n];
	      y = rows[i + 1].getElementsByTagName("TD")[n];
	      if (dir == "asc") {
	    	  //if (n==1 || n==2 || n==3 || n==4 || n==6) {
	        if (p.includes(n)) {
	          if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
	            shouldSwitch = true;
	            break;
	          }
	        }
	        else{
	          if (x.innerHTML.localeCompare(y.innerHTML, 'pl', {ignorePunctuation: true}) > 0) {
	            shouldSwitch= true;
	            break;
	          }
	        }
	      } else if (dir == "desc") {
	    	//if (n==1 || n==2 || n==3 || n==4 || n==6) {
	        if (p.includes(n)) {
	          if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
	            shouldSwitch = true;
	            break;
	          }
	        }
	        else{
	          if (y.innerHTML.localeCompare(x.innerHTML, 'pl', {ignorePunctuation: true}) > 0) {
	            shouldSwitch= true;
	            break;
	          }
	        }
	      }
	    }
	    if (shouldSwitch) {
	      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
	      switching = true;
	      switchcount ++;
	    } else {
	      if (switchcount == 0 && dir == "asc") {
	        dir = "desc";
	        switching = true;
	      }
	    }
	  }
	
	  // update the triangle icon based on the current sort order
	  var sortIcon = headerCells[n].getElementsByClassName("sort-icon")[0];
	  if (dir == "asc") {
	    sortIcon.innerHTML = "&#9650;";
	  } else if (dir == "desc") {
	    sortIcon.innerHTML = "&#9660;";
	  }
	}

</script>

<br>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>	
</body>
</html>