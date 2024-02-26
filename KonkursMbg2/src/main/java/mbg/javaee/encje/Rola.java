package mbg.javaee.encje;

public class Rola {
	private int id_rola;
	private String nazwa;
	public int getId_rola() {
		return id_rola;
	}
	public void setId_rola(int id_rola) {
		this.id_rola = id_rola;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public Rola(int id_rola, String nazwa) {
		super();
		this.id_rola = id_rola;
		this.nazwa = nazwa;
	}
	
}
