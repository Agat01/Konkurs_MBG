package mbg.javaee.encje;

public class Szkola2 {
	private static final long serialVersionUID = -3299291830280417103L;
	private int liczbaKlas;
	private int id_szkola;
	private String miejscowosc;
	private String nazwa;
	private String region;
	
	public int getLiczbaKlas() {
		return liczbaKlas;
	}
	public void setLiczbaKlas(int liczbaKlas) {
		this.liczbaKlas = liczbaKlas;
	}
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
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public Szkola2(int id_szkola, String nazwa, String miejscowosc, String region) {
		super();
		this.id_szkola = id_szkola;
		this.nazwa = nazwa;
		this.miejscowosc = miejscowosc;
		this.region = region;
	}
	public Szkola2(int liczbaKlas, int id_szkola, String nazwa, String miejscowosc, String region) {
		super();
		this.liczbaKlas = liczbaKlas;
		this.id_szkola = id_szkola;
		this.nazwa = nazwa;
		this.miejscowosc = miejscowosc;
		this.region = region;
	}
	
	
}
