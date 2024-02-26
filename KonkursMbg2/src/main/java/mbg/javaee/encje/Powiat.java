package mbg.javaee.encje;

public class Powiat {
	private int id_powiat;
	private String nazwa;
	private int id_wojewodztwo;
	public int getId_powiat() {
		return id_powiat;
	}
	public void setId_powiat(int id_powiat) {
		this.id_powiat = id_powiat;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public int getId_wojewodztwo() {
		return id_wojewodztwo;
	}
	public void setId_wojewodztwo(int id_wojewodztwo) {
		this.id_wojewodztwo = id_wojewodztwo;
	}
	public Powiat(int id_powiat, String nazwa, int id_wojewodztwo) {
		super();
		this.id_powiat = id_powiat;
		this.nazwa = nazwa;
		this.id_wojewodztwo = id_wojewodztwo;
	}
	public Powiat(int id_powiat, String nazwa) {
		super();
		this.id_powiat = id_powiat;
		this.nazwa = nazwa;
	}
	
}
