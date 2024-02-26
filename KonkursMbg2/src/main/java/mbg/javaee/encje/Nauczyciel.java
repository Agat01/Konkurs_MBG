package mbg.javaee.encje;

public class Nauczyciel {
private int id_nauczyciel;
private String tytul;
private String imie;
private String nazwisko;
private String email;
private int id_szkola;
private String czy_koordynuje;
private String nr_tel;
private String komisja;
public int getId_nauczyciel() {
	return id_nauczyciel;
}
public void setId_nauczyciel(int id_nauczyciel) {
	this.id_nauczyciel = id_nauczyciel;
}
public String getTytul() {
	return tytul;
}
public void setTytul(String tytul) {
	this.tytul = tytul;
}
public String getImie() {
	return imie;
}
public void setImie(String imie) {
	this.imie = imie;
}
public String getNazwisko() {
	return nazwisko;
}
public void setNazwisko(String nazwisko) {
	this.nazwisko = nazwisko;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public int getId_szkola() {
	return id_szkola;
}
public void setId_szkola(int id_szkola) {
	this.id_szkola = id_szkola;
}
public String getCzy_koordynuje() {
	return czy_koordynuje;
}
public void setCzy_koordynuje(String czy_koordynuje) {
	this.czy_koordynuje = czy_koordynuje;
}
public String getNr_tel() {
	return nr_tel;
}
public void setNr_tel(String nr_tel) {
	this.nr_tel = nr_tel;
}
public String getKomisja() {
	return komisja;
}
public void setKomisja(String komisja) {
	this.komisja = komisja;
}


public Nauczyciel(int id_nauczyciel, String tytul, int id_szkola) {
	super();
	this.id_nauczyciel = id_nauczyciel;
	this.tytul = tytul;
	this.id_szkola = id_szkola;
}
public Nauczyciel(int id_nauczyciel, String tytul, String imie, String nazwisko, String email, int id_szkola,
		String czy_koordynuje, String nr_tel, String komisja) {
	super();
	this.id_nauczyciel = id_nauczyciel;
	this.tytul = tytul;
	this.imie = imie;
	this.nazwisko = nazwisko;
	this.email = email;
	this.id_szkola = id_szkola;
	this.czy_koordynuje = czy_koordynuje;
	this.nr_tel = nr_tel;
	this.komisja = komisja;
}
}
