<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href="style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Regionalne komitety</title>
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
<br>
<div class="mainContent">
<div class="flex-container">
	<div class="flex-child buttons">
		<div class="btn-group">
		  <button class="button" id="krajowy">Krajowy Komitet Organizacyjny MK</button>
		  <button class="button" id="dol-opol">Region Dolnośląsko-Opolski</button>
		  <button class="button" id="kuj-pom">region kujawsko-pomorski</button>
		  <button class="button" id="lub-zach">region lubusko-zachodniopomorski</button>
		  <button class="button" id="mal-j">region małopolski - JUNIOR</button>
		  <button class="button" id="mal-s">region małopolski - SENIOR</button>
		  <button class="button" id="maz">region mazowiecki</button>
		  <button class="button" id="podk">region podkarpacki</button>
		  <button class="button" id="podl-s">region podlaski - SENIOR</button>
		  <button class="button" id="pom-j">region pomorski - JUNIOR</button>
		  <button class="button" id="pom-s">region pomorski - SENIOR</button>
		  <button class="button" id="sla">region śląski</button>
		  <button class="button" id="wielk-j">region wielkopolski - JUNIOR</button>
		  <button class="button" id="wielk-s">region wielkopolski - SENIOR</button>
 		</div>
	</div>
	
	<div class="flex-child tresc" id="tresc"></div>
	
<script>
var b1 = document.getElementById('krajowy'),
    b2 = document.getElementById('dol-opol'),
    b3 = document.getElementById('kuj-pom'),
    b4 = document.getElementById('lub-zach'),
    b5 = document.getElementById('mal-j'),
    b6 = document.getElementById('mal-s'),
    b7 = document.getElementById('maz'),
    b8 = document.getElementById('podk'),
    b9 = document.getElementById('podl-s'),
    b10 = document.getElementById('pom-j'),
    b11 = document.getElementById('pom-s'),
    b12 = document.getElementById('sla'),
    b13 = document.getElementById('wielk-j'),
    b14 = document.getElementById('wielk-s'),
    tresc = document.getElementById('tresc');
    
b1.onclick = function() {
    tresc.innerHTML = '<h3><b>Krajowy Komitet Organizacyjny MK </b></h3><br>'
    	+'Adres:<address>WMIE Uniwersytet Zielonogórski<br>'
    	+'ul. Szafrana 4a<br>'
    	+'65-516 Zielona Góra<br>'
    	+'z dopiskiem MbG - Aleksandra Rzepka</address><br>'
    	+'Przewodniczący komitetu:  dr Aleksandra Rzepka<br>'
    	+'E-Mail:  mbg@wmie.uz.zgora.pl';
}
b2.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Dolnośląsko-Opolski </b></h3><br>'
    	+'Adres:<address>Powiatowe Centrum Doskonalenia Nauczycieli <br>'
    	+'i Poradnictwa Psychologiczno-Pedagogicznego<br>'
    	+'Plac Bolesława Chrobrego 27<br>'
    	+'56-200 Góra</address><br>'
    	+'Przewodniczący komitetu:  mgr Grzegorz Goździewicz <br>'
    	+'E-Mail:  grzegorz.gozdziewicz@logora.edu.pl<br>'
    	+'Telefon :	655 441 277<br>'
    	+'WWW :	<a href="https://www.pcdn.edu.pl/">https://www.pcdn.edu.pl/</a>';
}
b3.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Dolnośląsko-Opolski </b></h3><br>'
    	+'Adres:<address>Szkoła Podstawowa im.ppor. Piotra Wysockiego w Świedziebni<br>'
    	+'Świedziebnia 51-51A<br>'
    	+'87-335 Świedziebnia</address><br>'
    	+'Przewodniczący komitetu:  mgr Justyna Gadomska<br>'
    	+'E-Mail:  justyna.gadomska@sp.swiedziebnia.pl<br>'
    	+'Telefon :	512 272 548<br>';
}
b4.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Lubusko-Zachodniopomorski </b></h3><br>'
    	+'Adres:<address>Instytut Matematyki pok. 508 bud. A-29<br>'
    	+'ul. prof. Z. Szafrana 4a<br>'
    	+'65-516 Zielona Góra</address><br>'
    	+'Przewodniczący komitetu:  dr Joanna Skowronek Kaziów<br>'
    	+'E-Mail:  	j.skowronek-kaziow@wmie.uz.zgora.pl<br>';
}
b5.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Małopolski - JUNIOR </b></h3><br>'
    	+'Adres:<address>Zespół Szkół Samochodowych im. inż. T. Tańskiego<br>'
    	+'ul. Rejtana 18<br>'
    	+'33-300 Nowy Sącz<br>'
    	+'z dopiskiem MbG Junior - Katarzyna Chyclak</address><br>'
    	+'Przewodniczący komitetu:  mgr Katarzyna Chyclak<br>'
    	+'E-Mail:  	k.chyclak@wp.pl<br>';
}
b6.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Małopolski - SENIOR </b></h3><br>'
    	+'Adres:<address>Zespół Szkół Samochodowych im. inż. T. Tańskiego<br>'
    	+'ul. Rejtana 18<br>'
    	+'33-300 Nowy Sącz<br>'
    	+'z dopiskiem MbG Senior - Anna Kochanek</address><br>'
    	+'Przewodniczący komitetu:  dr inż. Anna Kochanek<br>'
    	+'E-Mail:  	annakochanek@op.pl<br>';
}
b7.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Mazowiecki </b></h3><br>'
    	+'Adres:<address>Fundacja im. Fryderyka Skarbka<br>'
    	+'Pracowników i Absolwentów Wydziału Nauk Ekonomicznych <br>'
    	+'Uniwersytetu Warszawskiego<br>'
    	+'ul. Długa 44/50<br>'
    	+'00-241 Warszawa</address><br>'
    	+'Przewodniczący komitetu:  dr hab. Anna Białek-Jaworska<br>'
    	+'E-Mail:  	abialek@wne.uw.edu.pl<br>'
    	+'Telefon :	604 958 796<br>';
}
b8.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Podkarpacki - SENIOR-JUNIOR</b></h3>';
}
b9.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Podlaski - SENIOR </b></h3><br>'
    	+'Adres:<address>Uniwersytet w Białymstoku<br>'
    	+'Wydział Matematyki i Informatyki<br>'
    	+'K. Ciołkowskiego 1M<br>'
    	+'15-245 Białystok</address><br>'
    	+'Przewodniczący komitetu:  dr Agnieszka Stocka <br>'
    	+'E-Mail:  stocka@math.uwb.edu.pl<br>'
    	+'Telefon :	(85)738 8292<br>'
    	+'WWW :	<a href="https://www.math.uwb.edu.pl">www.math.uwb.edu.pl</a>';
}
b10.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Pomorski – JUNIOR</b></h3>';
}
b11.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Pomorski – SENIOR</b></h3>';
}
b12.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Śląski </b></h3><br>'
    	+'Adres:<address>	IX Liceum Ogólnokształcące im. W. Szymborskiej<br>'
    	+'ul. Dormana 9a<br>'
    	+'41-219 Sosnowiec</address><br>'
    	+'Przewodniczący komitetu:  mgr Katarzyna Budziłek - Jurek <br>'
    	+'E-Mail:  	budzilek.jurekk@gmail.com<br>'
    	+'Telefon :	600 73 55 89<br>'
    	+'WWW :	<a href="ixlo.sosnowiec.pl/matematyka-bez-granic/">ixlo.sosnowiec.pl/matematyka-bez-granic/</a><br>'
    	+'Zastępca przewodniczącej: mgr inż. Marta Heblik';
}
b13.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Wielkopolski - JUNIOR</b></h3>';
}
b14.onclick = function() {
    tresc.innerHTML = '<h3><b>Region Wielkopolski - SENIOR </b></h3><br>'
    	+'Adres:<address>	Liceum Ogólnokształcące<br>'
    	+'ul. Poznańska 118<br>'
    	+'62-080 Tarnowo Podgórne</address><br>'
    	+'Przewodniczący komitetu:  mgr Anna Gorońska <br>'
    	+'E-Mail:  	a.goronska@liceumtp.edu.pl<br>'
    	+'Telefon :  061 814 72 53<br>'
    	+'Fax :	061 816 60 37<br>'
    	+'WWW :	<a href="www.liceumtp.edu.pl">www.liceumtp.edu.pl</a>';
}



</script>
</div>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>
</body>
</html>