package mbg.javaee.encje;

public class Region {
	private int id_region;
	private String nazwa;
	private String adres1;
	private String ulica;
	private String nr_domu;
	private String kod_pocztowy;
	private String miejscowosc;
	private String przewodniczacy;
	private String email;
	private String nr_tel;
	private String www;
	private String z_dopiskiem;
	
	public int getId_region() {
		return id_region;
	}
	public void setId_region(int id_region) {
		this.id_region = id_region;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	
	public String getAdres1() {
		return adres1;
	}
	public void setAdres1(String adres1) {
		this.adres1 = adres1;
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
	public String getMiejscowosc() {
		return miejscowosc;
	}
	public void setMiejscowosc(String miejscowosc) {
		this.miejscowosc = miejscowosc;
	}
	public String getPrzewodniczacy() {
		return przewodniczacy;
	}
	public void setPrzewodniczacy(String przewodniczacy) {
		this.przewodniczacy = przewodniczacy;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNr_tel() {
		return nr_tel;
	}
	public void setNr_tel(String nr_tel) {
		this.nr_tel = nr_tel;
	}
	public String getWww() {
		return www;
	}
	public void setWww(String www) {
		this.www = www;
	}
	public String getZ_dopiskiem() {
		return z_dopiskiem;
	}
	public void setZ_dopiskiem(String z_dopiskiem) {
		this.z_dopiskiem = z_dopiskiem;
	}
	public Region(int id_region, String nazwa) {
		super();
		this.id_region = id_region;
		this.nazwa = nazwa;
	}
	public Region(int id_region, String nazwa, String adres1, String ulica, String nr_domu, String kod_pocztowy,
			String miejscowosc, String przewodniczacy, String email, String nr_tel, String www, String z_dopiskiem) {
		super();
		this.id_region = id_region;
		this.nazwa = nazwa;
		this.adres1 = adres1;
		this.ulica = ulica;
		this.nr_domu = nr_domu;
		this.kod_pocztowy = kod_pocztowy;
		this.miejscowosc = miejscowosc;
		this.przewodniczacy = przewodniczacy;
		this.email = email;
		this.nr_tel = nr_tel;
		this.www = www;
		this.z_dopiskiem = z_dopiskiem;
	}
}
