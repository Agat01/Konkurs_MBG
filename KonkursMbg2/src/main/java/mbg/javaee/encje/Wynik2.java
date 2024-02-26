package mbg.javaee.encje;

public class Wynik2 {
	private int id_wynik;
	private int wynik;
	private int id_zadanie;
	private int id_klasa;
	public int getId_wynik() {
		return id_wynik;
	}
	public void setId_wynik(int id_wynik) {
		this.id_wynik = id_wynik;
	}
	public int getWynik() {
		return wynik;
	}
	public void setWynik(int wynik) {
		this.wynik = wynik;
	}
	public int getId_zadanie() {
		return id_zadanie;
	}
	public void setId_zadanie(int id_zadanie) {
		this.id_zadanie = id_zadanie;
	}
	public int getId_klasa() {
		return id_klasa;
	}
	public void setId_klasa(int id_klasa) {
		this.id_klasa = id_klasa;
	}
	public Wynik2(int id_wynik, int wynik, int id_zadanie, int id_klasa) {
		super();
		this.id_wynik = id_wynik;
		this.wynik = wynik;
		this.id_zadanie = id_zadanie;
		this.id_klasa = id_klasa;
	}
	
}
