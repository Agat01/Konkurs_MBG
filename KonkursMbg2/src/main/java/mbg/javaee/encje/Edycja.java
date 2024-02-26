package mbg.javaee.encje;

public class Edycja {
private int id_edycja;
private String nazwa;
private String url;
private String active;
private String wszystkieWyniki;
public int getId_edycja() {
	return id_edycja;
}
public void setId_edycja(int id_edycja) {
	this.id_edycja = id_edycja;
}
public String getNazwa() {
	return nazwa;
}
public void setNazwa(String nazwa) {
	this.nazwa = nazwa;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}

public String getActive() {
	return active;
}
public void setActive(String active) {
	this.active = active;
}
public String getWszystkieWyniki() {
	return wszystkieWyniki;
}
public void setWszystkieWyniki(String wszystkieWyniki) {
	this.wszystkieWyniki = wszystkieWyniki;
}
public Edycja(String nazwa, String url) {
	super();
	this.nazwa = nazwa;
	this.url = url;
}

public Edycja(String nazwa, String url, String wszystkieWyniki) {
	super();
	this.nazwa = nazwa;
	this.url = url;
	this.wszystkieWyniki = wszystkieWyniki;
}

public Edycja(int id_edycja, String nazwa, String url, String active, String wszystkieWyniki) {
	super();
	this.id_edycja = id_edycja;
	this.nazwa = nazwa;
	this.url = url;
	this.active = active;
	this.wszystkieWyniki = wszystkieWyniki;
}

}
