package mbg.javaee.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SecurityConfig {
	public static final String ROLA_ADMIN = "ADMIN";
	public static final String ROLA_NAUCZYCIEL = "NAUCZYCIEL";
	public static final String ROLA_MODERATOR = "MODERATOR";
	public static final String ROLA_KOORDYNATOR = "KOORDYNATOR";

	private static final Map<String, List<String>> mapConfig = new HashMap<String, List<String>>();
	static {
		init();
	}
	private static void init() {
//		mapConfig.clear();
		List<String> urlPatterns1 = new ArrayList<String>();

		urlPatterns1.add("/konto.jsp");
//		System.out.print(mapConfig.isEmpty());

		mapConfig.put(ROLA_NAUCZYCIEL, urlPatterns1);

		List<String> urlPatterns2 = new ArrayList<String>();
		urlPatterns2.add("/rejestracjaZgloszen");
		urlPatterns2.add("/rejestracjaZgloszen.jsp");
		urlPatterns2.add("/wprowadzanieWynikow");
		urlPatterns2.add("/wprowadzanieWynikow.jsp");
		urlPatterns2.add("/wysylanieEmaili");
		urlPatterns2.add("/wysylanieEmaili.jsp");
		urlPatterns2.add("/dyrektorzy.jsp");
		urlPatterns2.add("/edycje.jsp");
		urlPatterns2.add("/jezyki.jsp");
		urlPatterns2.add("/klasy.jsp");
		urlPatterns2.add("/klasyRegion.jsp");
		urlPatterns2.add("/nauczyciele.jsp");
		urlPatterns2.add("/powiaty.jsp");
		urlPatterns2.add("/regiony.jsp");
		urlPatterns2.add("/rodzaje.jsp");
		urlPatterns2.add("/role.jsp");
		urlPatterns2.add("/szkoly.jsp");
		urlPatterns2.add("/typyKlas.jsp");
		urlPatterns2.add("/uzytkownicy.jsp");
		urlPatterns2.add("/uzytkownicyRole.jsp");
		urlPatterns2.add("/wojewodztwa.jsp");
		urlPatterns2.add("/zadania.jsp");
		urlPatterns2.add("/wyniki.jsp");
		urlPatterns2.add("/dyrektor");
		urlPatterns2.add("/edycja");
		urlPatterns2.add("/jezyk");
		urlPatterns2.add("/klasa");
		urlPatterns2.add("/klasaRegion");
		urlPatterns2.add("/nauczyciel");
		urlPatterns2.add("/powiat");
		urlPatterns2.add("/region");
		urlPatterns2.add("/rodzaj");
		urlPatterns2.add("/rola");
		urlPatterns2.add("/szkola");
		urlPatterns2.add("/typKlasy");
		urlPatterns2.add("/uzytkownik");
		urlPatterns2.add("/uzytkownikRola");
		urlPatterns2.add("/wojewodztwo");
		urlPatterns2.add("/zadanie");
		urlPatterns2.add("/wynik");
		urlPatterns2.add("/admin.jsp");
		urlPatterns2.add("/menu2.jsp");

		mapConfig.put(ROLA_ADMIN, urlPatterns2);
		List<String> urlPatterns3 = new ArrayList<String>();
		urlPatterns3.add("/rejestracjaZgloszen");
		urlPatterns3.add("/rejestracjaZgloszen.jsp");
		urlPatterns3.add("/wprowadzanieWynikow");
		urlPatterns3.add("/wprowadzanieWynikow.jsp");	
		urlPatterns3.add("/wysylanieEmaili");
		urlPatterns3.add("/wysylanieEmaili.jsp");
		urlPatterns3.add("/edycje.jsp");
		urlPatterns3.add("/edycja");
		urlPatterns3.add("/menu2.jsp");
		urlPatterns3.add("/admin2.jsp");
		mapConfig.put(ROLA_MODERATOR, urlPatterns3);
		
		List<String> urlPatterns4 = new ArrayList<String>();
		urlPatterns4.add("/rejestracjaZgloszen");
		urlPatterns4.add("/rejestracjaZgloszen.jsp");
		urlPatterns4.add("/wprowadzanieWynikow");
		urlPatterns4.add("/wprowadzanieWynikow.jsp");
		urlPatterns4.add("/menu2.jsp");
		urlPatterns4.add("/admin2.jsp");

		mapConfig.put(ROLA_KOORDYNATOR, urlPatterns4);

	}

	public static Set<String> getAllAppRoles() {
		return mapConfig.keySet();
	}

	public static List<String> getUrlPatternsForRole(String role) {
		return mapConfig.get(role);
	}


}
