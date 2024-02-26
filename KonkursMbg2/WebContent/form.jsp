<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
 <link rel = "stylesheet" href="style.css"/>
   
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Formularz rejestracyjny</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>

<script type="text/javascript">

var categories = [];
categories["startList"] = ["dolnośląskie","kujawskopomorskie","lubelskie","lubuskie","łódzkie","małopolskie","mazowieckie",
	"opolskie","podkarpackie","podlaskie","pomorskie","śląskie","świętokrzyskie","warmińsko-mazurskie","wielkopolskie","zachodniopomorskie"]
categories["dolnośląskie"] = ["bolesławiecki","dzierżoniowski","głogowski","górowski","jaworski","Jelenia Góra","kamiennogórski",
	"karkonoski","kłodzki","Legnica","legnicki","lubański","lubiński","lwówecki","milicki","oleśnicki","oławski","polkowicki",
	"strzeliński","średzki (dolnośląskie)","świdnicki(dolnośląskie)","trzebnicki","Wałbrzych","wałbrzyski","wołowski","Wrocław","wrocławski",
	"ząbkowicki","zgorzelecki","złotoryjski"];
categories["kujawskopomorskie"] = ["aleksandrowski","brodnicki", "bydgoski","Bydgoszcz","chełmiński","golubsko-dobrzyński",
	"Grudziądz","grudziądzki","inowrocławski","lipnowski","mogileński","nakielski","radziejowski","rypiński","sępoleński",
	"świecki","Toruń","toruński","tucholski","wąbrzeski","Włocławek","włocławski","żniński"];
categories["lubelskie"] = ["bialski", "Biała Podlaska", "biłgorajski","Chełm","chełmski","hrubieszowski","janowski","kraśnicki",
	"krasnostawski","lubartowski","lubelski","Lublin","łęczyński","łukowski","opolski (lubelskie)","parczewski","puławski","radzyński",
	"rycki","świdnicki (lubelskie)","tomaszowski (lubelskie)","włodawski","zamojski","Zamość"];
categories["lubuskie"]=["gorzowski","Gorzów Wielkopolski","krośnieński (lubuskie)","międzyrzecki","nowosolski","słubicki","strzelecko-drezdenecki",
	"sulęciński","świebodziński","wschowski","Zielona Góra","zielonogórski","żagański","żarski"];
categories["łódzkie"]=["bełchatowski","brzeziński","kutnowski","łaski","łęczycki","łowicki","łódzki wschodni","Łódź","opoczyński",
	"pabianicki","pajęczański","piotrkowski","Piotrków Trybunalski","poddębicki","radomszczański","rawski",
	"sieradzki","Skierniewice","skierniewicki","tomaszowski (łódzkie)","wieluński","wieruszowski","zduńskowolski","zgierski"];
categories["małopolskie"]=["bocheński","brzeski (małopolskie)","chrzanowski","dąbrowski","gorlicki","krakowski","Kraków","limanowski","miechowski",
	"myślenicki","nowosądecki","nowotarski","Nowy Sącz","olkuski","oświęcimski","proszowicki","suski",
	"tarnowski","Tarnów","tatrzański","wadowicki","wielicki"];
categories["mazowieckie"]=["białobrzeski","ciechanowski","garwoliński","gostyniński","grodziski (mazowieckie)","grójecki","kozienicki","legionowski",
	"lipski","łosicki","makowski","miński","mławski","nowodworski (mazowieckie)","ostrołęcki","Ostrołęka","ostrowski (mazowieckie)","otwocki",
	"piaseczyński","Płock","płocki","płoński","pruszkowski","przasnyski","przysuski","pułtuski","Radom",
	"radomski","Siedlce","siedlecki","sierpecki","sochaczewski","sokołowski","szydłowiecki","Warszawa",
	"warszawski zachodni","węgrowski","wołomiński","wyszkowski","zwoleński","żuromiński","żyrardowski"];
categories["opolskie"]=["brzeski (opolskie)","głubczycki","kędzierzyńsko-kozielski","kluczborski","krapkowicki","namysłowski","nyski",
	"oleski","Opole","opolski (opolskie)","prudnicki","strzelecki"];
categories["podkarpackie"]=["bieszczadzki","brzozowski","dębicki","jarosławski","jasielski","kolbuszowski","Krosno","krośnieński (podkarpackie)","leski",
	"leżajski","lubaczowski","łańcucki","mielecki","niżański","przemyski","Przemyśl","przeworski","ropczycko-sędziszowski",
	"rzeszowski","Rzeszów","sanocki","stalowowolski","strzyżowski","Tarnobrzeg","tarnobrzeski"];
categories["podlaskie"]=["augustowski","białostocki","Białystok","bielski (podlaskie)","grajewski","hajnowski","kolneński","Łomża","łomżyński",
	"moniecki","sejneński","siemiatycki","sokólski","suwalski","Suwałki","wysokomazowiecki","zambrowski"];
categories["pomorskie"]=["bytowski","chojnicki","człuchowski","Gdańsk","gdański","Gdynia","kartuski","kościerski","kwidzyński","lęborski",
	"malborski","nowodworski (pomorskie)","pucki","Słupsk","słupski","Sopot","starogardzki","sztumski","tczewski","wejherowski"];
categories["śląskie"]=["będziński","bielski (śląskie)","Bielsko-Biała","bieruńsko-lędziński","Bytom","Chorzów","cieszyński","Częstochowa",
	"częstochowski","Dąbrowa Górnicza","Gliwice","gliwicki","Jastrzębie-Zdrój","Jaworzno","Katowice","kłobucki","lubliniecki",
	"mikołowski","Mysłowice","myszkowski","Piekary Śląskie","pszczyński","raciborski","Ruda Śląska","rybnicki","Rybnik",
	"Siemianowice Śląskie","Sosnowiec","Świętochłowice","tarnogórski","Tychy","wodzisławski","Zabrze","zawierciański","Żory","żywiecki"];
categories["świętokrzyskie"]=["buski","jędrzejowski","kazimierski","Kielce","kielecki","konecki","opatowski","ostrowiecki","pińczowski",
	"sandomierski","skarżyski","starachowicki","staszowski","włoszczowski"];
categories["warmińsko-mazurskie"]=["bartoszycki","braniewski","działdowski","Elbląg","elbląski","ełcki","giżycki","gołdapski","iławski",
	"kętrzyński","lidzbarski","mrągowski","nidzicki","nowomiejski","olecki","Olsztyn","olsztyński","ostródzki",
	"piski","szczycieński","węgorzewski"];
categories["wielkopolskie"]=["chodzieski","czarnkowsko-trzcianecki","gnieźnieński","gostyński","grodziski (wielkopolskie)","jarociński","kaliski","Kalisz",
	"kępiński","kolski","Konin","koniński","kościański","krotoszyński","leszczyński","Leszno","międzychodzki",
	"nowotomyski","obornicki","ostrowski (wielkopolskie)","ostrzeszowski","pilski","pleszewski","Poznań","poznański","rawicki",
	"słupecki","szamotulski","średzki (wielkopolskie)","śremski","turecki","wągrowiecki","wolsztyński","wrzesiński","złotowski"];
categories["zachodniopomorskie"]=["białogardzki","choszczeński","drawski","goleniowski","gryficki","gryfiński","kamieński","kołobrzeski",
	"Koszalin","koszaliński","łobeski","myśliborski","policki","pyrzycki","sławieński","stargardzki","Szczecin","szczecinecki",
	"świdwiński","Świnoujście","wałecki"];

var nLists = 2; // number of select lists in the set

function fillSelect(currCat,currList){
var step = Number(currList.name.replace(/\D/g,""));
for (i=step; i<nLists+1; i++) {
document.forms['formularz']['List'+i].length = 1;
document.forms['formularz']['List'+i].selectedIndex = 0;
}
var nCat = categories[currCat];
for (each in nCat) {
var nOption = document.createElement('option'); 
var nData = document.createTextNode(nCat[each]); 
nOption.setAttribute('value',nCat[each]); 
nOption.appendChild(nData); 
currList.appendChild(nOption); 
} 
}


function init() {
fillSelect('startList',document.forms['formularz']['List1'])
}

navigator.appName == "Microsoft Internet Explorer" ? attachEvent('onload', init, false) : addEventListener('load', init, false);	

	
	function showDiv(divId, element)
	{
	    document.getElementById(divId).style.display = element.value == 1 ? 'block' : 'none';
	}
	

	// Get the modal
	var modal = document.getElementById('id01');

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}

</script> 

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
<div class="card">
<h2>Formularz rejestracyjny</h2>
	 <p><span style="color: #ff0000">UWAGA:</span> Formularz zgłoszenia - przygotowany do wydruku - zostanie utworzony 
	 po wypełnieniu poniższych pól odpowiednimi danymi i wciśnięciu przycisku Generuj PDF.</p>
		<p><span style="color: #ff0000">UWAGA:</span> Pola z * muszą być obowiązkowo wypełnione.</p>
	<form name="formularz" id="formularz" method="post" action="http://localhost:8090/KonkursMbg/formularz.pdf">
	
	<label for="List1">Województwo *</label>
	<select id="List1" name="List1" onchange="fillSelect(this.value,this.form['List2'])" required>
	<option selected></option>
	</select>
	&nbsp;
	<label for="List2">Powiat *</label>
	<select id="List2" name="List2" onchange="fillSelect(this.value)" required>
	<option selected></option>
	</select>
	<input type="hidden" id="wojewodztwo" name="wojewodztwo" value="">
	<input type="hidden" id="powiat" name="powiat" value="">
	
        <div class="form-row">
            <label for="miejscowosc">Miejscowość *</label>
            <input type="text" name="miejscowosc" required pattern=.{2,} id="miejscowosc" data-error-text="Wypełnij to pole">
        </div> 
        <div class="form-row">
            <label for="nazwaZespolu">Nazwa Zespołu Szkół</label>
            <input type="text" name="nazwaZespolu" id="nazwaZespolu">
        </div>  
        <div class="form-row">
            <label for="nazwa">Nazwa Szkoły *</label>
            <input type="text" name="nazwa" required pattern=.{2,} id="nazwa" data-error-text="Wypełnij to pole">
        </div>  
        <div class="form-row">
            <label for="imienia">Szkoła Imienia</label>
            <input type="text" name="imienia" id="imienia">
         </div>  
        <div class="form-row">
        <label for="ulica">Ulica *</label>
		<input type="text" name="ulica" required pattern=.{2,} id="ulica" data-error-text="Wypełnij to pole">
		 </div>  
        <div class="form-row">
		<label for="nrDomu">Nr domu *</label>
		<input type="text" name="nrDomu" required pattern=.{1,} id="nrDomu" data-error-text="Wypełnij to pole">
		 </div>  
        <div class="form-row">
		<label for="kodPocztowy">Kod pocztowy *</label>
		<input type="text" name="kodPocztowy" required pattern="[0-9]{2}-[0-9]{3}" id="kodPocztowy" placeholder="00-000" data-error-text="Wpisz poprawny kod pocztowy (00-000)">
		 </div>  
        <div class="form-row">
		<label for="miejscowosc2">Miejscowość *</label>
		<input type="text" name="miejscowosc2" required pattern=.{2,} id="miejscowosc2" data-error-text="Wypełnij to pole">
		 </div>  
        <div class="form-row">
		<label for="telefon">Telefon *</label>
		<input type="text" name="telefon" required pattern=[0-9]{6,9} id="telefon" data-error-text="Wpisz poprawny nr telefonu">
		 </div>  
        <div class="form-row">
            <label for="email">Adres E-mail Szkoły *</label>
            <input type="email" name="email" required pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$" id="email" data-error-text="Wpisz poprawny email">
        </div>  
        
        <p>Dane dotyczące Dyrektora Szkoły:</p>
        <div class="form-row"> 
	<label for="tytul">Tytuł (np. mgr., inż. itp.) *</label>
	<input type="text" name="tytul" required id="tytul" data-error-text="Wypełnij to pole" />  
	</div>  
        <div class="form-row">
	<label for="imie">Imię *</label>
	<input type="text" name="imie" required pattern=.{2,} id="imie" data-error-text="Wypełnij to pole"/>  
	</div>  
        <div class="form-row">
	<label for="nazwisko">Nazwisko *</label>
	<input type="text" name="nazwisko" required pattern=.{2,} id="nazwisko" data-error-text="Wypełnij to pole"/>  
	</div>  
        <div class="form-row">
	<label for="demail">Adres E-mail *</label>
	<input type="email" name="demail" required pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$" id="demail" data-error-text="Wpisz poprawny email" />  
	</div>  
	
	<p>Dane dotyczące nauczyciela koordynującego przebieg konkursu w szkole:</p>
        <div class="form-row">
	<label for="ktytul">Tytuł (np. mgr., inż. itp.) *</label>
	<input type="text" name="ktytul" required id="ktytul" data-error-text="Wypełnij to pole"/>
	</div>  
        <div class="form-row">
	<label for="kimie">Imię *</label>
	<input type="text" name="kimie" required pattern=.{2,} id="kimie" data-error-text="Wypełnij to pole" /> 
	</div>  
        <div class="form-row">
	<label for="knazwisko">Nazwisko *</label>
	<input type="text" name="knazwisko" required pattern=.{2,} id="knazwisko" data-error-text="Wypełnij to pole" /> 
	</div>  
        <div class="form-row">
	<label for="kemail">Adres E-mail *</label>
	<input type="email" name="kemail" required pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$" id="kemail" data-error-text="Wpisz poprawny email" /> 
	</div>  
        <div class="form-row">
	<label for="ktelefon">Telefon kontaktowy *</label>
	<input type="text" name="ktelefon" required pattern=[0-9]{6,9} id="ktelefon" data-error-text="Wypełnij to pole" />
	</div>  
        <div class="form-row">
	<input type="checkbox" id="udzialKomisja" name="udzialKomisja" value="tak">
<label for="udzialKomisja">Prosimy o zaznaczenie poniższego pola w przypadku chęci udziału koordynatora w pracach Komisji Sprawdzającej prace uczestników konkursu z etapu finałowego w swoim regionie.
Na podstawie powyższej deklaracji Przewodniczący RKO MK „MBG” będzie mógł w razie potrzeby zaprosić koordynatora do udziału w sprawdzaniu prac konkursowych. <br>
O faktycznym udziale w pracach Komisji koordynator zdecyduje przyjmując bądź odrzucając otrzymane zaproszenie.<br>
Jednocześnie informujemy, że wszystkie osoby zaangażowane w organizację i przebieg konkursu działają na zasadzie wolontariatu. Deklaracja współpracy jest całkowicie dobrowolna. <br>
</label>
        </div> <br>
        
        	 
	<p>Dane do logowania się na stronę.</p>
	<p>Nazwą użytkownika jest podany wyżej adres E-mail nauczyciela koordynującego.</p>

<div class="form-row">
    <label for="haslo">Podaj hasło: *</label>
    <input type="password" name="haslo" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&*()_+}{:;.,?/|\-]{8,}$" id="haslo" data-error-text="wymagania: min 8 znaków, 1 duża, 1 mała litera oraz 1 cyfra" /> <br>
</div>  
<div class="form-row">
    <label for="powtorzHaslo">Powtórz hasło: *</label>
    <input type="password" name="powtorzHaslo" required id="powtorzHaslo" data-error-text="Hasła nie są takie same" />
</div>


		<h3>Dane klas:</h3>
		<table id="klasy" border="1">
			<tr>
				<th style="min-width: 80px; width: 22%; text-align: center;" rowspan="2">Typ klasy</th>
				<th style="min-width: 70px; width: 13%; text-align: center; " rowspan="2">Nazwa klasy *</th>
				<th style="min-width: 90px; width: 35%; text-align: center;" colspan="3">Nauczyciel</th>
				<th style="min-width: 70px; width: 10%; text-align: center;" rowspan="2">Liczba uczniów *</th>
				<th style="text-align: center;"rowspan="2">Preferowany język *</th>
			</tr>
			<tr>
				<th style="min-width: 60px; width: 10%; text-align: center;">Tytuł *</th>
				<th style="min-width: 70px; width: 15%; text-align: center;">Imie *</th>
				<th style="min-width: 70px; width: 15%; text-align: center;">Nazwisko *</th>
			</tr>
			<tr>
				<td id="col0"><div class="form-row"><select id="typ" name="typ">
						<option value="szkoła podstawowa - klasa 5">JUNIOR-szkoła podstawowa - klasa 5</option>
						<option value="szkoła podstawowa - klasa 6">JUNIOR-szkoła podstawowa - klasa 6</option>
						<option value="szkoła podstawowa - klasa 8">SENIOR-szkoła podstawowa - klasa 8</option>
						<option value="szkoła ponadpodstawowa - liceum - klasa 1">SENIOR-szkoła ponadpodstawowa - liceum - klasa 1</option>
						<option value="szkoła ponadpodstawowa - technikum - klasa 1">SENIOR-szkoła ponadpodstawowa - technikum - klasa 1</option>
				</select></div> <input type="hidden" id="typ[]" name="typ[]" value=""> </td>
				<td id="col1"><div class="form-row"><input type="text" name="nazwaKlasy" required pattern=.{1,} id="nazwaKlasy" data-error-text="Wypełnij to pole" /></div></td>
				<td id="col2"><div class="form-row"><input type="text" name="ntytul" required pattern=.{1,} id="ntytul" data-error-text="Wypełnij to pole" /></div></td>
				<td id="col3"><div class="form-row"><input type="text" name="nimie" required pattern=.{2,} id="nimie" data-error-text="Wypełnij to pole" /></div></td>
				<td id="col4"><div class="form-row"><input type="text" name="nnazwisko" required pattern=.{2,} id="nnazwisko" data-error-text="Wypełnij to pole" /></div></td>
				<td id="col5"><div class="form-row"><input type="number" name="liczbaUczniow" min="1" required pattern=.{1,} id="liczbaUczniow" data-error-text="Wypełnij to pole" /></div></td>
				<td id="col6"><div class="form-row"><select id="jezyk" name="jezyk">
						<option value="angielski">angielski</option>
						<option value="francuski">francuski</option>
						<option value="hiszpański">hiszpański</option>
						<option value="niemiecki">niemiecki</option>
						<option value="włoski">włoski</option>
				</select> </div>
				<input type="hidden" id="jezyk[]" name="jezyk[]" value=""></td>
			</tr>

		</table>
		<input type="hidden" id="liczba_klas" name="liczba_klas" value="1">
		
		<table>
			<tr>
				<td><input type="button" value="Dodaj klasę"
					onclick="addRows()" /></td>
				<td><input type="button" value="Usuń klasę"
					onclick="deleteRows()" /></td>
			</tr>
		</table>
        <div class="form-row">
            <input type="submit" value="Generuj PDF" name="save" onclick="change()" />
        </div>
   
<script>
   
   /* 
        function removeFieldError(field) {
            const errorText = field.nextElementSibling;
            if (errorText !== null) {
                if (errorText.classList.contains("form-error-text")) {
                    errorText.remove();
                }
            }
        };

        function createFieldError(field, text) {
            removeFieldError(field); 

            const div = document.createElement("div");
            div.classList.add("form-error-text");
            div.innerText = text;
            if (field.nextElementSibling === null) {
                field.parentElement.appendChild(div);
            } else {
                if (!field.nextElementSibling.classList.contains("form-error-text")) {
                    field.parentElement.insertBefore(div, field.nextElementSibling);
                }
            }
        };

        function toggleErrorField(field, show) {
            const errorText = field.nextElementSibling;
            if (errorText !== null) {
                if (errorText.classList.contains("form-error-text")) {
                	if (field.id === "powtorzHaslo") {
                        errorText.style.display = show ? "block" : "none";
                        errorText.setAttribute('aria-hidden', show);
                    } else {
                        errorText.style.display = "none";
                        errorText.setAttribute('aria-hidden', true);
                    }
        //            errorText.style.display = show ? "block" : "none";
        //            errorText.setAttribute('aria-hidden', show);
                }
            }
        };

        function markFieldAsError(field, show) {
            if (show) {
                field.classList.add("field-error");
            } else {
                field.classList.remove("field-error");
                toggleErrorField(field, false);
            }
            
            if (field.id === "powtorzHaslo") {
                const hasloField = document.querySelector("#haslo");
                const hasloValue = hasloField.value;
                const powtorzHasloValue = field.value;

                if (hasloValue !== powtorzHasloValue) {
                    createFieldError(field, field.dataset.errorText);
                    field.classList.add("field-error");
                    formErrors = true;
                }
            }
        };

        const form = document.querySelector("#formularz");
        const inputs = form.querySelectorAll("[required]");

        form.setAttribute("novalidate", true);

        for (const el of inputs) {
            el.addEventListener("input", e => markFieldAsError(e.target, !e.target.checkValidity()));
        }

        
        
        form.addEventListener("submit", e => {
            e.preventDefault();

            let formErrors = false;

            for (const el of inputs) {
                removeFieldError(el);
                el.classList.remove("field-error");

                if (!el.checkValidity()) {
                    createFieldError(el, el.dataset.errorText);
                    el.classList.add("field-error");
                    formErrors = true;
                }
            }

            if (!formErrors) {
                const submit = form.querySelector("[type=submit]");
                submit.disabled = true;
                submit.classList.add("loading");
                form.submit();

            }
        });
   */
   const hasloField = document.querySelector("#haslo");
   const powtorzHasloField = document.querySelector("#powtorzHaslo");
   let hasloErrorField = null;
   
   function removeFieldError(field) {
	    const errorText = field.nextElementSibling;
	    if (errorText !== null) {
	        if (errorText.classList.contains("form-error-text")) {
	            errorText.remove();

	            // Resetuj pole błędu dla hasła, jeśli usuwane pole to hasło
	            if (field === hasloField) {
	                hasloErrorField = null;
	            }
	        }
	    }
	}
   
	 function createFieldError(field, text) {
		 removeFieldError(field);

		    const div = document.createElement("div");
		    div.classList.add("form-error-text");
		    div.innerText = text;
		    if (field.nextElementSibling === null) {
		        field.parentElement.appendChild(div);
		    } else {
		        if (!field.nextElementSibling.classList.contains("form-error-text")) {
		            field.parentElement.insertBefore(div, field.nextElementSibling);
		        }
		    }

		    // Dodaj przypisanie pola błędu dla hasła
		    if (field === hasloField) {
		        hasloErrorField = div;
		    }
	 }

	 function markFieldAsError(field, show) {
		    if (show) {
		        field.classList.add("field-error");
		    } else {
		        field.classList.remove("field-error");
		        removeFieldError(field);
		        toggleErrorField(field, false);
		    }

		    // Dodaj sprawdzenie, czy pole to hasło i czy jest polem błędu
		    if (field === hasloField && hasloErrorField !== null) {
		        toggleErrorField(hasloErrorField, show);
		    }
		}

	 const form = document.querySelector("#formularz");
	 const inputs = form.querySelectorAll("[required]");

	 form.setAttribute("novalidate", true);

	 for (const el of inputs) {
	   el.addEventListener("input", (e) =>
	     markFieldAsError(e.target, !e.target.checkValidity())
	   );
	 }

	 form.addEventListener("submit", (e) => {
	   e.preventDefault();

	   let formErrors = false;
	   let passwordField;
	   let confirmPasswordField;

	   for (const el of inputs) {
	     removeFieldError(el);
	     el.classList.remove("field-error");

	     if (!el.checkValidity()) {
	       createFieldError(el, el.dataset.errorText);
	       el.classList.add("field-error");
	       formErrors = true;
	     }

	     if (el.name === "haslo") {
	       passwordField = el;
	     }

	     if (el.name === "powtorzHaslo") {
	       confirmPasswordField = el;
	     }
	   }

	   if (passwordField.value !== confirmPasswordField.value) {
	     createFieldError(confirmPasswordField, "Hasła nie są takie same");
	     confirmPasswordField.classList.add("field-error");
	     formErrors = true;
	   }

	   if (!formErrors) {
	     const submit = form.querySelector("[type=submit]");
	     submit.disabled = true;
	     submit.classList.add("loading");
	     form.submit();
	   }
	 });
	 
	 
   
    function addRows() {
		var table = document.getElementById('klasy');
		var rowCount = table.rows.length;
		document.getElementById("liczba_klas").value = rowCount-1;
		var cellCount = table.rows[0].cells.length + 1;
		var row = table.insertRow(rowCount);
		for (var i = 0; i <= cellCount; i++) {
			var cell = 'cell' + i;
			cell = row.insertCell(i);
			var copycel = document.getElementById('col' + i).innerHTML;
			cell.innerHTML = copycel;

		}
	}
  function deleteRows() {
		var table = document.getElementById('klasy');
		var rowCount = table.rows.length;
		if (rowCount > '2') {
			var row = table.deleteRow(rowCount - 1);
			rowCount--;
			document.getElementById("liczba_klas").value = rowCount-2;
		} else {
			alert('There should be atleast one row');
		}
	}

	

	function change() {
		var wybwoj = document.getElementById('List1').options[document.getElementById('List1').selectedIndex].value; 
	    var x1 = document.getElementById("wojewodztwo").value=wybwoj;
		var wybpowiat = document.getElementById('List2').options[document.getElementById('List2').selectedIndex].value; 
	    var x2 = document.getElementById("powiat").value=wybpowiat;
		var wybtyp=[];
		var wybjezyk=[];
		   for(var i = 0; i < liczba.klas; i++)
		   {
		      wybtyp.push(document.getElementById('typ').options[document
					.getElementById('typ').selectedIndex].value);
		      document.getElementById("typ").value = wybtyp[i];
		      
		      wybjezyk.push(document.getElementById('prefJezyk').options[document
					.getElementById('prefJezyk').selectedIndex].value);
		      document.getElementById("jezyk").value = wybjezyk[i];
		   }
				   
	}
</script>
 </form>
</div>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>
</body>
</html>