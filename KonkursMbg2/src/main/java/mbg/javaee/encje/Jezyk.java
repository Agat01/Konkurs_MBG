package mbg.javaee.encje;

public class Jezyk {
private int id_jezyk;
private String nazwa;
public int getId_jezyk() {
	return id_jezyk;
}
public void setId_jezyk(int id_jezyk) {
	this.id_jezyk = id_jezyk;
}
public String getNazwa() {
	return nazwa;
}
public void setNazwa(String nazwa) {
	this.nazwa = nazwa;
}
public Jezyk(int id_jezyk, String nazwa) {
	super();
	this.id_jezyk = id_jezyk;
	this.nazwa = nazwa;
}


}
