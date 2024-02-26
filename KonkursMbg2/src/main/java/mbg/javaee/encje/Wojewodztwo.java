package mbg.javaee.encje;

public class Wojewodztwo {
	private static final long serialVersionUID = -3299291830280417103L;
	private int id_wojewodztwo;
	private String nazwa;
	public int getId_wojewodztwo() {
		return id_wojewodztwo;
	}
	public void setId_wojewodztwo(int id_wojewodztwo) {
		this.id_wojewodztwo = id_wojewodztwo;
	}
	public String getNazwa() {
		return nazwa;
	}
	public void setNazwa(String nazwa) {
		this.nazwa = nazwa;
	}
	public Wojewodztwo(int id_wojewodztwo, String nazwa) {
		super();
		this.id_wojewodztwo = id_wojewodztwo;
		this.nazwa = nazwa;
	}
	@Override
	public String toString() {
		return "Wojewodztwo [id_wojewodztwo=" + id_wojewodztwo + ", nazwa=" + nazwa + "]";
	}
	
}
