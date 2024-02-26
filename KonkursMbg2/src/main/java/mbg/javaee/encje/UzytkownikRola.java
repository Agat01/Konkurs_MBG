package mbg.javaee.encje;

public class UzytkownikRola {
	int id_uzytkownik_rola;
	int id_uzytkownik;
	int id_rola;
	public int getId_uzytkownik_rola() {
		return id_uzytkownik_rola;
	}
	public void setId_uzytkownik_rola(int id_uzytkownik_rola) {
		this.id_uzytkownik_rola = id_uzytkownik_rola;
	}
	public int getId_uzytkownik() {
		return id_uzytkownik;
	}
	public void setId_uzytkownik(int id_uzytkownik) {
		this.id_uzytkownik = id_uzytkownik;
	}
	public int getId_rola() {
		return id_rola;
	}
	public void setId_rola(int id_rola) {
		this.id_rola = id_rola;
	}
	public UzytkownikRola(int id_uzytkownik_rola, int id_uzytkownik, int id_rola) {
		super();
		this.id_uzytkownik_rola = id_uzytkownik_rola;
		this.id_uzytkownik = id_uzytkownik;
		this.id_rola = id_rola;
	}
	
}
