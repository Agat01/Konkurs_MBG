package mbg.javaee.encje;

public class Klasa2 {
private int id_klasa;
private String nazwa;
private int liczba_uczniow;
private int pref_jezyk;
private int id_szkola;
private int id_typ_klasy;
private int id_nauczyciel;
private int id_edycja;
public int getId_klasa() {
	return id_klasa;
}
public void setId_klasa(int id_klasa) {
	this.id_klasa = id_klasa;
}
public String getNazwa() {
	return nazwa;
}
public void setNazwa(String nazwa) {
	this.nazwa = nazwa;
}
public int getLiczba_uczniow() {
	return liczba_uczniow;
}
public void setLiczba_uczniow(int liczba_uczniow) {
	this.liczba_uczniow = liczba_uczniow;
}
public int getPref_jezyk() {
	return pref_jezyk;
}
public void setPref_jezyk(int pref_jezyk) {
	this.pref_jezyk = pref_jezyk;
}
public int getId_szkola() {
	return id_szkola;
}
public void setId_szkola(int id_szkola) {
	this.id_szkola = id_szkola;
}
public int getId_typ_klasy() {
	return id_typ_klasy;
}
public void setId_typ_klasy(int id_typ_klasy) {
	this.id_typ_klasy = id_typ_klasy;
}
public int getId_nauczyciel() {
	return id_nauczyciel;
}
public void setId_nauczyciel(int id_nauczyciel) {
	this.id_nauczyciel = id_nauczyciel;
}
/*
public Klasa2(int id_klasa, String nazwa, int liczba_uczniow, int pref_jezyk, int id_szkola, int id_typ_klasy,
		int id_nauczyciel) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.liczba_uczniow = liczba_uczniow;
	this.pref_jezyk = pref_jezyk;
	this.id_szkola = id_szkola;
	this.id_typ_klasy = id_typ_klasy;
	this.id_nauczyciel = id_nauczyciel;
}
*/
public Klasa2(int id_klasa, String nazwa, int liczba_uczniow, int pref_jezyk, int id_szkola, int id_typ_klasy,
		int id_nauczyciel, int id_edycja) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.liczba_uczniow = liczba_uczniow;
	this.pref_jezyk = pref_jezyk;
	this.id_szkola = id_szkola;
	this.id_typ_klasy = id_typ_klasy;
	this.id_nauczyciel = id_nauczyciel;
	this.id_edycja = id_edycja;
}

}
