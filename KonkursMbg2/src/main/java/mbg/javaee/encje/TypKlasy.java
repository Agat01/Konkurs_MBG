package mbg.javaee.encje;

public class TypKlasy {
	private int id_typ_klasy;
	private String nazwa;
	private int id_rodzaj;
	public int getId_typ_klasy() {
		return id_typ_klasy;
	}
	public void setId_typ_klasy(int id_typ_klasy) {
		this.id_typ_klasy = id_typ_klasy;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public int getId_rodzaj() {
		return id_rodzaj;
	}
	public void setId_rodzaj(int id_rodzaj) {
		this.id_rodzaj = id_rodzaj;
	}
	public TypKlasy(int id_typ_klasy, String nazwa, int id_rodzaj) {
		super();
		this.id_typ_klasy = id_typ_klasy;
		this.nazwa = nazwa;
		this.id_rodzaj = id_rodzaj;
	}
	
}
