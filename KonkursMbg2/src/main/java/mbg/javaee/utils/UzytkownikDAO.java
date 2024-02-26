package mbg.javaee.utils;


import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mbg.javaee.config.SecurityConfig;
import mbg.javaee.encje.Uzytkownik;

public class UzytkownikDAO {

	public static String getMd5(String input)
    {
        try {
 
            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
 
            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());
 
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
 
            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
 
        // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
	
	 private static final Map<String, Uzytkownik> mapUzytkownicy = new HashMap<String, Uzytkownik>();

	   static {
	      initUzytkownicy();
	   }

	private static void initUzytkownicy() {
		
		String nazwa_uzytkownika="";
		String hashHaslo="";
		int id_rola=0;
		String rola="";
		int id_uzytkownik=0;
//		mapUzytkownicy.clear();
		try {
			Connection conn = DatabaseConnectionManager.getConnection();

			String sql = "select id_uzytkownik, nazwa_uzytkownika, haslo from uzytkownik";
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				id_uzytkownik=rs.getInt(1);
				nazwa_uzytkownika=rs.getString(2);
				hashHaslo=rs.getString(3);
				
				List<String> role = new ArrayList<String>();
				String sql2 = "select id_rola from uzytkownik_rola where id_uzytkownik="+id_uzytkownik;
				Statement stmt2 = conn.createStatement();
				ResultSet rs2=stmt2.executeQuery(sql2);
					while(rs2.next()){
						id_rola=rs2.getInt(1);
					if(id_rola==1){
						rola=SecurityConfig.ROLA_ADMIN;
						role.add(rola);
					}
					else if(id_rola==2) {
						rola=SecurityConfig.ROLA_MODERATOR;
						role.add(rola);
					}
					else if(id_rola==3) {
						rola=SecurityConfig.ROLA_NAUCZYCIEL;
						role.add(rola);
					}
					else if(id_rola>=4) {
						rola=SecurityConfig.ROLA_KOORDYNATOR;
						role.add(rola);
					}
					
				}

				Uzytkownik uzytkownik=new Uzytkownik(nazwa_uzytkownika,hashHaslo,role);
				mapUzytkownicy.put(uzytkownik.getNazwa_uzytkownika(),uzytkownik);

			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<String> role = new ArrayList<String>();
		role.add(SecurityConfig.ROLA_ADMIN);
		Uzytkownik admin=new Uzytkownik("admin",hashHaslo=getMd5("admin"),role);
		role.clear();
		mapUzytkownicy.put(admin.getNazwa_uzytkownika(), admin);
	}
	public static Uzytkownik znajdzUzytkownika(String nazwa_uzytkownika,String haslo) {
		Uzytkownik u=mapUzytkownicy.get(nazwa_uzytkownika);
		if(u!=null&&u.getHaslo().equals(haslo)) {
			return u;
		}
		return null;
	}
}
