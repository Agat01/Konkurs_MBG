package mbg.javaee.encje;

public class Klasa {
private int id_klasa;
private String nazwa;
private String nazwaSz;
private String miejscowosc;
private String nauczyciel;
private int liczbaUczniow;
private int liczbaZ;
private int wynik;
private int liczbaKl;
private int zajeteMiejsceWKraju;
private int zajeteMiejsceWWojewodztwie;
private String woj;
private int idRegion;
private int zajeteMiejsceWRegionie;

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
public String getNazwaSz() {
	return nazwaSz;
}
public void setNazwaSz(String nazwaSz) {
	this.nazwaSz = nazwaSz;
}

public String getMiejscowosc() {
	return miejscowosc;
}
public void setMiejscowosc(String miejscowosc) {
	this.miejscowosc = miejscowosc;
}
public String getNauczyciel() {
	return nauczyciel;
}
public void setNauczyciel(String nauczyciel) {
	this.nauczyciel = nauczyciel;
}
public int getLiczbaUczniow() {
	return liczbaUczniow;
}
public void setLiczbaUczniow(int liczbaUczniow) {
	this.liczbaUczniow = liczbaUczniow;
}
public int getWynik() {
	return wynik;
}
public void setWynik(int wynik) {
	this.wynik = wynik;
}
public int getLiczbaKl() {
	return liczbaKl;
}
public void setLiczbaKl(int liczbaKl) {
	this.liczbaKl = liczbaKl;
}

public int getZajeteMiejsceWKraju() {
	return zajeteMiejsceWKraju;
}
public void setZajeteMiejsceWKraju(int zajeteMiejsceWKraju) {
	this.zajeteMiejsceWKraju = zajeteMiejsceWKraju;
}
public int getZajeteMiejsceWWojewodztwie() {
	return zajeteMiejsceWWojewodztwie;
}
public void setZajeteMiejsceWWojewodztwie(int zajeteMiejsceWWojewodztwie) {
	this.zajeteMiejsceWWojewodztwie = zajeteMiejsceWWojewodztwie;
}
public String getWoj() {
	return woj;
}
public void setWoj(String woj) {
	this.woj = woj;
}

public int getIdRegion() {
	return idRegion;
}
public void setIdRegion(int idRegion) {
	this.idRegion = idRegion;
}
public int getZajeteMiejsceWRegionie() {
	return zajeteMiejsceWRegionie;
}
public void setZajeteMiejsceWRegionie(int zajeteMiejsceWRegionie) {
	this.zajeteMiejsceWRegionie = zajeteMiejsceWRegionie;
}

public int getLiczbaZ() {
	return liczbaZ;
}
public void setLiczbaZ(int liczbaZ) {
	this.liczbaZ = liczbaZ;
}
public Klasa(int id_klasa, String nazwa) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
}
/*
public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int wynik, String woj) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.wynik = wynik;
	this.woj = woj;
}
*/
public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int liczbaZ, int wynik, String woj) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.liczbaZ = liczbaZ;
	this.wynik = wynik;
	this.woj = woj;
}

public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int liczbaZ, int wynik, int idRegion) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.liczbaZ = liczbaZ;
	this.wynik = wynik;
	this.idRegion = idRegion;
}

public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int wynik, int zajeteMiejsceWKraju, int zajeteMiejsceWWojewodztwie,int zajeteMiejsceWRegionie, String woj) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.wynik = wynik;
	this.zajeteMiejsceWKraju = zajeteMiejsceWKraju;
	this.zajeteMiejsceWWojewodztwie = zajeteMiejsceWWojewodztwie;
	this.zajeteMiejsceWRegionie = zajeteMiejsceWRegionie;
	this.woj = woj;
}

public Klasa(int id_klasa, int wynik, int idRegion, int zajeteMiejsceWRegionie) {
	super();
	this.id_klasa = id_klasa;
	this.wynik = wynik;
	this.idRegion = idRegion;
	this.zajeteMiejsceWRegionie = zajeteMiejsceWRegionie;
}

public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int wynik, int idRegion) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.wynik = wynik;
	this.idRegion = idRegion;
}

public Klasa(int id_klasa, String nazwa, String nazwaSz, String miejscowosc, String nauczyciel, int liczbaUczniow,
		int wynik, int zajeteMiejsceWKraju, int idRegion, int zajeteMiejsceWRegionie) {
	super();
	this.id_klasa = id_klasa;
	this.nazwa = nazwa;
	this.nazwaSz = nazwaSz;
	this.miejscowosc = miejscowosc;
	this.nauczyciel = nauczyciel;
	this.liczbaUczniow = liczbaUczniow;
	this.wynik = wynik;
	this.zajeteMiejsceWKraju = zajeteMiejsceWKraju;
	this.idRegion = idRegion;
	this.zajeteMiejsceWRegionie = zajeteMiejsceWRegionie;
}

}
