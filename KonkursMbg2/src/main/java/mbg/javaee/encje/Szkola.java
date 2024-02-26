package mbg.javaee.encje;

public class Szkola {
	private static final long serialVersionUID = -3299291830280417103L;
	private int id_szkola;
	private String miejscowosc;
	private String nazwa_zespolu_szkol;
	private String nazwa;
	private String imienia;
	private String nr_tel;
	private String email;
	private int id_dyrektor;
	private int id_powiat;
	private String ulica;
	private String nr_domu;
	private String kod_pocztowy;
	private String miejscowosc2;
	private String active;
	
	public int getId_szkola() {
		return id_szkola;
	}
	public void setId_szkola(int id_szkola) {
		this.id_szkola = id_szkola;
	}
	public String getMiejscowosc() {
		return miejscowosc;
	}
	public void setMiejscowosc(String miejscowosc) {
		this.miejscowosc = miejscowosc;
	}
	public String getNazwa_zespolu_szkol() {
		return nazwa_zespolu_szkol;
	}
	public void setNazwa_zespolu_szkol(String nazwa_zespolu_szkol) {
		this.nazwa_zespolu_szkol = nazwa_zespolu_szkol;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public String getImienia() {
		return imienia;
	}
	public void setImienia(String imienia) {
		this.imienia = imienia;
	}
	
	public String getNr_tel() {
		return nr_tel;
	}
	public void setNr_tel(String nr_tel) {
		this.nr_tel = nr_tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getId_dyrektor() {
		return id_dyrektor;
	}
	public void setId_dyrektor(int id_dyrektor) {
		this.id_dyrektor = id_dyrektor;
	}
	public int getId_powiat() {
		return id_powiat;
	}
	public void setId_powiat(int id_powiat) {
		this.id_powiat = id_powiat;
	}
	public String getUlica() {
		return ulica;
	}
	public void setUlica(String ulica) {
		this.ulica = ulica;
	}
	public String getNr_domu() {
		return nr_domu;
	}
	public void setNr_domu(String nr_domu) {
		this.nr_domu = nr_domu;
	}
	public String getKod_pocztowy() {
		return kod_pocztowy;
	}
	public void setKod_pocztowy(String kod_pocztowy) {
		this.kod_pocztowy = kod_pocztowy;
	}
	public String getMiejscowosc2() {
		return miejscowosc2;
	}
	public void setMiejscowosc2(String miejscowosc2) {
		this.miejscowosc2 = miejscowosc2;
	}
	
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public Szkola(String nazwa_zespolu_szkol, String nazwa, String imienia) {
		super();
		this.nazwa_zespolu_szkol = nazwa_zespolu_szkol;
		this.nazwa = nazwa;
		this.imienia = imienia;
	}
	public Szkola(int id_dyrektor,String nazwa, String imienia, String miejscowosc,int id_szkola) {
		super();
		this.id_dyrektor=id_dyrektor;
		this.nazwa = nazwa;
		this.imienia = imienia;
		this.miejscowosc = miejscowosc;
		this.id_szkola = id_szkola;
	}
	public Szkola(int id_szkola, String nazwa) {
		super();
		this.id_szkola = id_szkola;
		this.nazwa = nazwa;
	}
	public Szkola(int id_szkola, String miejscowosc, String nazwa_zespolu_szkol, String nazwa, String imienia,
			String nr_tel, String email, int id_dyrektor, int id_powiat, String ulica, String nr_domu,
			String kod_pocztowy, String miejscowosc2, String active) {
		super();
		this.id_szkola = id_szkola;
		this.miejscowosc = miejscowosc;
		this.nazwa_zespolu_szkol = nazwa_zespolu_szkol;
		this.nazwa = nazwa;
		this.imienia = imienia;
		this.nr_tel = nr_tel;
		this.email = email;
		this.id_dyrektor = id_dyrektor;
		this.id_powiat = id_powiat;
		this.ulica = ulica;
		this.nr_domu = nr_domu;
		this.kod_pocztowy = kod_pocztowy;
		this.miejscowosc2 = miejscowosc2;
		this.active = active;
	}
	
	
	
}
