package mbg.javaee.encje;

public class Zadanie {
	private int id_zadanie;
	private String nazwa;
	private int max_liczba_pkt;
	public int getId_zadanie() {
		return id_zadanie;
	}
	public void setId_zadanie(int id_zadanie) {
		this.id_zadanie = id_zadanie;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public int getMax_liczba_pkt() {
		return max_liczba_pkt;
	}
	public void setMax_liczba_pkt(int max_liczba_pkt) {
		this.max_liczba_pkt = max_liczba_pkt;
	}
	
	public Zadanie(int id_zadanie, String nazwa) {
		super();
		this.id_zadanie = id_zadanie;
		this.nazwa = nazwa;
	}
	public Zadanie(int id_zadanie, String nazwa, int max_liczba_pkt) {
		super();
		this.id_zadanie = id_zadanie;
		this.nazwa = nazwa;
		this.max_liczba_pkt = max_liczba_pkt;
	}
	
}
