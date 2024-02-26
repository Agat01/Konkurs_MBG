package mbg.javaee.encje;

public class KlasaRegion {
	private int id_klasa_region;
	private int id_klasa;
	private int id_region;
	public int getId_klasa_region() {
		return id_klasa_region;
	}
	public void setId_klasa_region(int id_klasa_region) {
		this.id_klasa_region = id_klasa_region;
	}
	public int getId_klasa() {
		return id_klasa;
	}
	public void setId_klasa(int id_klasa) {
		this.id_klasa = id_klasa;
	}
	public int getId_region() {
		return id_region;
	}
	public void setId_region(int id_region) {
		this.id_region = id_region;
	}
	public KlasaRegion(int id_klasa_region, int id_klasa, int id_region) {
		super();
		this.id_klasa_region = id_klasa_region;
		this.id_klasa = id_klasa;
		this.id_region = id_region;
	}
	
}
