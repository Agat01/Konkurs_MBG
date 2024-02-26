package mbg.javaee.encje;

public class Wynik {
	private int id_klasa;
	private String nazwaSz;
	private String miejscowosc;
	private String nazwaK;
	private String zadanie;
	private int wynik;
	private int zajeteMiejsceWKraju;
    private int zajeteMiejsceWWojewodztwie;
	
	public int getId_klasa() {
		return id_klasa;
	}
	public void setId_klasa(int id_klasa) {
		this.id_klasa = id_klasa;
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
	public String getNazwaK() {
		return nazwaK;
	}
	public void setNazwaK(String nazwaK) {
		this.nazwaK = nazwaK;
	}
	public String getZadanie() {
		return zadanie;
	}
	public void setZadanie(String zadanie) {
		this.zadanie = zadanie;
	}
	public int getWynik() {
		return wynik;
	}
	public void setWynik(int wynik) {
		this.wynik = wynik;
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
	public Wynik(int id_klasa, String nazwaSz, String miejscowosc, String nazwaK, String zadanie, int wynik) {
		super();
		this.id_klasa = id_klasa;
		this.nazwaSz = nazwaSz;
		this.miejscowosc = miejscowosc;
		this.nazwaK = nazwaK;
		this.zadanie = zadanie;
		this.wynik = wynik;
	}
	public Wynik(int id_klasa, String nazwaSz, String miejscowosc, String nazwaK, String zadanie, int wynik,
			int zajeteMiejsceWKraju, int zajeteMiejsceWWojewodztwie) {
		super();
		this.id_klasa = id_klasa;
		this.nazwaSz = nazwaSz;
		this.miejscowosc = miejscowosc;
		this.nazwaK = nazwaK;
		this.zadanie = zadanie;
		this.wynik = wynik;
		this.zajeteMiejsceWKraju = zajeteMiejsceWKraju;
		this.zajeteMiejsceWWojewodztwie = zajeteMiejsceWWojewodztwie;
	}
	
	
	
}
