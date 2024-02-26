package mbg.javaee.encje;

public class Dyrektor {
	private int id_dyrektor;
	private String tytul;
	private String imie;
	private String nazwisko;
	private String email;
	public int getId_dyrektor() {
		return id_dyrektor;
	}
	public void setId_dyrektor(int id_dyrektor) {
		this.id_dyrektor = id_dyrektor;
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
	public Dyrektor(int id_dyrektor, String tytul, String imie, String nazwisko, String email) {
		super();
		this.id_dyrektor = id_dyrektor;
		this.tytul = tytul;
		this.imie = imie;
		this.nazwisko = nazwisko;
		this.email = email;
	}
	
	
}
