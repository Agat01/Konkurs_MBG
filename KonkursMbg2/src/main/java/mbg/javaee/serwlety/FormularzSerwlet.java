package mbg.javaee.serwlety;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.Barcode;
import com.itextpdf.text.pdf.BarcodeEAN;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;

import mbg.javaee.MyFooter;
import mbg.javaee.encje.Nauczyciel;
import mbg.javaee.utils.DatabaseConnectionManager;

import com.itextpdf.text.pdf.BaseFont;

@WebServlet("/formularz.pdf")
public class FormularzSerwlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("text/plain; charset=utf-8");
		PrintWriter out = res.getWriter();
		res.getWriter().append("Served at: ").append(req.getContextPath());
	}
	
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
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("formularz/pdf");
		LocalDate data= LocalDate.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
		String data2 = data.format(dateTimeFormatter);
		String wojewodztwo=req.getParameter("wojewodztwo");
		String powiat = req.getParameter("powiat");
		String miejscowosc = req.getParameter("miejscowosc");
		String nazwaZespolu = req.getParameter("nazwaZespolu");
		String nazwa = req.getParameter("nazwa");
		String imienia = req.getParameter("imienia");
		String ulica = req.getParameter("ulica");
		String nrDomu = req.getParameter("nrDomu");
		String kodPocztowy = req.getParameter("kodPocztowy");
		String miejscowosc2 = req.getParameter("miejscowosc2");
		String telefon = req.getParameter("telefon");
		String email = req.getParameter("email");
		int idDyrektor = 0;
		int idSzkola = 0;
		int idPowiat = 0;
		int idTyp = 0;
		int idNauczycielk = 0;
		int idNauczyciel = 0;
		int idJezyk=0;
		int idKlasa=0;
		int idRola=3;
		int idUzytkownik=0;
		String komisja="0";
		
		String tytul = req.getParameter("tytul");
		String imie = req.getParameter("imie");
		String nazwisko = req.getParameter("nazwisko");
		String demail=req.getParameter("demail");

		String ktytul = req.getParameter("ktytul");
		String kimie = req.getParameter("kimie");
		String knazwisko = req.getParameter("knazwisko");
		String kemail = req.getParameter("kemail");
		String ktelefon = req.getParameter("ktelefon");
		
		if(req.getParameter("udzialKomisja") != null) {
			komisja="1";
		}

		String haslo = req.getParameter("haslo");
		String haslo2 = req.getParameter("powtorzHaslo");

		String hashHaslo = "";

		String liczba_klas="";
		if(req.getParameter("liczba_klas")!=null && req.getParameter("liczba_klas")!="") {
		liczba_klas=req.getParameter("liczba_klas");
		}
//		out.println("liczba_klas:"+liczba_klas);
		String[] typ = req.getParameterValues("typ");
		String[] nazwaKlasy = req.getParameterValues("nazwaKlasy");
		String[] ntytul = req.getParameterValues("ntytul");
		String[] nimie = req.getParameterValues("nimie");
		String[] nnazwisko = req.getParameterValues("nnazwisko");
		String[] liczbaUczniow = req.getParameterValues("liczbaUczniow");
		String[] jezyk = req.getParameterValues("jezyk");

		try {
			Connection conn = DatabaseConnectionManager.getConnection();

			Statement id_d = conn.createStatement();
			Statement id_sz = conn.createStatement();
			Statement id_p = conn.createStatement();
			Statement id_t = conn.createStatement();
			Statement id_nk = conn.createStatement();
			Statement id_n = conn.createStatement();
			Statement id_j = conn.createStatement();
			Statement id_k = conn.createStatement();
			Statement id_u = conn.createStatement();

			id_d.execute("SELECT dyrektor_seq.NEXTVAL+1 as idDyrektora FROM DUAL");
			ResultSet rs = id_d.getResultSet();
			while (rs.next()) {
				idDyrektor = rs.getInt(1);
	//			out.println("idDyrektor:"+idDyrektor);
			}

			id_sz.execute("SELECT szkola_seq.NEXTVAL+1 as idSzkoly FROM DUAL");
			ResultSet rs2 = id_sz.getResultSet();
			while (rs2.next()) {
				idSzkola = rs2.getInt(1);
//				out.println("idSzkola:"+idSzkola);
			}

			id_p.execute("SELECT id_powiat FROM powiat where nazwa='" + powiat + "'");
			ResultSet rs3 = id_p.getResultSet();
			while (rs3.next()) {
				idPowiat = rs3.getInt(1);
			}

			id_nk.execute("SELECT nauczyciel_seq.NEXTVAL+1 as idNauczyciela FROM DUAL");
			ResultSet rs5 = id_nk.getResultSet();
			while (rs5.next()) {
				idNauczycielk = rs5.getInt(1);
//				out.println("idNauczycielk:"+idNauczycielk);
			}
			idNauczyciel=idNauczycielk+1;
//			out.println("idNauczyciel:"+idNauczyciel);

			id_k.execute("SELECT klasa_seq.NEXTVAL+1 as idKlasy FROM DUAL");
			ResultSet rs6 = id_k.getResultSet();
			while (rs6.next()) {
				idKlasa = rs6.getInt(1);
//				out.println("idKlasa:"+idKlasa);
			}
			id_u.execute("SELECT uzytkownik_seq.NEXTVAL+1 as idUzytkownik FROM DUAL");
			ResultSet rs6r = id_u.getResultSet();
			while (rs6r.next()) {
				idUzytkownik = rs6r.getInt(1);
			}
			int idEdycja=0;
			Statement id_e = conn.createStatement();
			id_e.execute("SELECT id_edycja FROM edycja WHERE id_edycja = (SELECT MAX(id_edycja) FROM edycja)");
			ResultSet rsE = id_e.getResultSet();
			while (rsE.next()) {
				idEdycja = rsE.getInt(1);
			}
			
			if (haslo.equals(haslo2)) {
				PreparedStatement stmt = conn.prepareStatement("Insert into dyrektor values(null,?,?,?,?)");
				PreparedStatement stmt2 = conn.prepareStatement("Insert into szkola values(null,?,?,?,?,?,?,?,?,?,?,?,?,0)");
				PreparedStatement stmt3 = conn.prepareStatement("Insert into nauczyciel values(null,?,?,?,?,?,1,?,?)");
				PreparedStatement stmt4 = conn.prepareStatement("Insert into uzytkownik values(null,?,?)");
				PreparedStatement stmt4r = conn.prepareStatement("Insert into uzytkownik_rola values(null,?,?)");
				PreparedStatement stmt5 = conn.prepareStatement("Insert into nauczyciel values(null,?,?,?,null,?,0,null,0)");
				PreparedStatement stmt6 = conn.prepareStatement("Insert into klasa values(null,?,?,?,?,?,?,?)");
				PreparedStatement stmt7 = conn.prepareStatement("Insert into klasa_region values(null,?,?)");

				stmt.setString(1, tytul);
				stmt.setString(2, imie);
				stmt.setString(3, nazwisko);
				stmt.setString(4, demail);
				if (stmt.executeUpdate() > 0) {
			
				} 
				
				stmt2.setString(1, miejscowosc);
				stmt2.setString(2, nazwaZespolu);
				stmt2.setString(3, nazwa);
				stmt2.setString(4, imienia);
				stmt2.setString(5, telefon);
				stmt2.setString(6, email);
				stmt2.setInt(7, idDyrektor);
				stmt2.setInt(8, idPowiat);
				stmt2.setString(9, ulica);
				stmt2.setString(10, nrDomu);
				stmt2.setString(11, kodPocztowy);
				stmt2.setString(12, miejscowosc2);

				if (stmt2.executeUpdate() > 0) {
				//	res.getWriter().println("Szkoła została dodana");
	
				} 
				
	//			String idU=Integer.toString(idUzytkownik);
				
				stmt3.setString(1, ktytul);
				stmt3.setString(2, kimie);
				stmt3.setString(3, knazwisko);
				stmt3.setString(4, kemail);
				//stmt3.setString(4, idU);
				stmt3.setInt(5, idSzkola);
				stmt3.setString(6, ktelefon);
				stmt3.setString(7, komisja);
				
				if (stmt3.executeUpdate() > 0) {
					
		//			res.getWriter().println("Nauczyciel koordynujący został dodany");
					
				} 
				
				hashHaslo=getMd5(haslo);
				stmt4.setString(1, kemail);
			//	stmt4.setString(1, idU);
				stmt4.setString(2, hashHaslo);
	
				if (stmt4.executeUpdate() > 0) {

		//			res.getWriter().println("Dane logowania:");

				} 
				
				stmt4r.setInt(1, idUzytkownik);
				stmt4r.setInt(2, idRola);

				if (stmt4r.executeUpdate() > 0) {
					
				} 
				
		int liczba=Integer.parseInt(liczba_klas);

		int idN = 0;
		String naucz = "";
		int idSz = 0;
		ArrayList<Nauczyciel> nauczyciele = new ArrayList<Nauczyciel>();
		Map<String, Nauczyciel> nauczycieleMap = new HashMap<>();

		Statement n = conn.createStatement();
		n.execute("SELECT id_nauczyciel, tytul || ' ' || imie || ' ' || nazwisko FROM nauczyciel where id_szkola=" + idSzkola);
		ResultSet rs7 = n.getResultSet();
		while (rs7.next()) {
		    idN = rs7.getInt(1);
		    naucz = rs7.getString(2);
		    nauczyciele.add(new Nauczyciel(idN, naucz, idSzkola));
		}

		idNauczyciel = idNauczycielk + 1;

		for (int i = 0; i < liczba; i++) {

		    id_t.execute("SELECT id_typ_klasy FROM typ_klasy where nazwa='" + typ[i] + "'");
		    ResultSet rs4 = id_t.getResultSet();
		    while (rs4.next()) {
		        idTyp = rs4.getInt(1);
		    }

		    id_j.execute("SELECT id_jezyk FROM jezyk where nazwa='" + jezyk[i] + "'");
		    ResultSet rs8 = id_j.getResultSet();
		    while (rs8.next()) {
		        idJezyk = rs8.getInt(1);
		    }

		    String nauczycielData = ntytul[i] + " " + nimie[i] + " " + nnazwisko[i];

		    if (nauczycieleMap.containsKey(nauczycielData)) {
		        Nauczyciel existingNauczyciel = nauczycieleMap.get(nauczycielData);
		        idN = existingNauczyciel.getId_nauczyciel();
		    } else {
		        stmt5.setString(1, ntytul[i]);
		        stmt5.setString(2, nimie[i]);
		        stmt5.setString(3, nnazwisko[i]);
		        stmt5.setInt(4, idSzkola);
		        if (stmt5.executeUpdate() > 0) {
		            idN = idNauczyciel;
		            idNauczyciel++;
		        } else {
		   //         res.getWriter().println("nie udało się");
		            continue;
		        }

		        nauczycieleMap.put(nauczycielData, new Nauczyciel(idN, nauczycielData, idSzkola));
		    }

		    stmt6.setString(1, nazwaKlasy[i]);
		    stmt6.setString(2, liczbaUczniow[i]);
		    stmt6.setInt(3, idJezyk);
		    stmt6.setInt(4, idSzkola);
		    stmt6.setInt(5, idTyp);
		    stmt6.setInt(6, idN);
		    stmt6.setInt(7, idEdycja);

		    if (stmt6.executeUpdate() > 0) {

		    } 
		    
		    int idRegion=0;
		    
		    if((idPowiat>=1 && idPowiat<=31) || (idPowiat>=180 && idPowiat<=191)) {
		    	idRegion=1;
		    }
		    else if(idPowiat>=32 && idPowiat<=54) {
		    	idRegion=2;
		    }
		    else if((idPowiat>=80 && idPowiat<=91) || (idPowiat>=360 && idPowiat<=380)) {
		    	idRegion=3;
		    }
		    else if(idPowiat>=116 && idPowiat<=137 && idTyp<=2) {
		    	idRegion=4;
		    }
		    else if(idPowiat>=116 && idPowiat<=137 && idTyp>=3) {
		    	idRegion=5;
		    }
		    else if(idPowiat>=138 && idPowiat<=179) {
		    	idRegion=6;
		    }
		    else if(idPowiat>=192 && idPowiat<=216) {
		    	idRegion=7;
		    }
		    else if(idPowiat>=217 && idPowiat<=233 && idTyp>=3) {
		    	idRegion=8;
		    }
		    if(idPowiat>=234 && idPowiat<=253 && idTyp<=2) {
		    	idRegion=9;
		    }
		    if(idPowiat>=234 && idPowiat<=253 && idTyp>=3) {
		    	idRegion=10;
		    }
		    if(idPowiat>=254 && idPowiat<=289 && idTyp<=2) {
		    	idRegion=11;
		    }
		    if(idPowiat>=254 && idPowiat<=289 && idTyp>=3) {
		    	idRegion=15;
		    }
		    if(idPowiat>=325 && idPowiat<=359 && idTyp<=2) {
		    	idRegion=12;
		    }
		    if(idPowiat>=325 && idPowiat<=359 && idTyp>=3) {
		    	idRegion=13;
		    }
		    else idRegion=14;
		    

		    stmt7.setInt(1, idKlasa);
		    stmt7.setInt(2, idRegion);
		    
		    if (stmt7.executeUpdate() > 0) {

		    } 
		    
		    idKlasa = idKlasa + 1;

		}
		String region="";
		String adres1="";
		String ulica1="";
		String nrDomu1="";
		String kodPocztowy1="";
		miejscowosc2="";
		String dopisek="";
		
		Statement r = conn.createStatement();
		r.execute("select nazwa, adres1,ulica,nr_domu,kod_pocztowy,miejscowosc,z_dopiskiem\r\n"
				+ "from region\r\n"
				+ "where id_region=1");
		ResultSet rs9 = r.getResultSet();
		while (rs9.next()) {
		    region = rs9.getString(1);
		    adres1 = rs9.getString(2);
		    ulica1=rs9.getString(3);
		    nrDomu1=rs9.getString(4);
		    kodPocztowy1=rs9.getString(5);
		    miejscowosc2=rs9.getString(6);
		    dopisek=rs9.getString(7);
		}

		Document d=new Document();
		d.setPageSize(PageSize.A4);
		PdfWriter writer=PdfWriter.getInstance(d, res.getOutputStream());
		 MyFooter footerEvent = new MyFooter();
		 writer.setPageEvent(footerEvent);
		BaseFont bf = BaseFont.createFont("C:\\Windows\\Fonts\\ARIAL.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		BaseFont bf2 = BaseFont.createFont("C:\\Windows\\Fonts\\CALIBRIL.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\CALIBRI.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font font = new Font(bf, 11);
			Font font2 = new Font(bf, 16,Font.BOLD);
			Font font3 = new Font(bf2, 11);
			Font font4 = new Font(bf3, 11);
			Font font5 = new Font(bf3, 11,Font.ITALIC,BaseColor.RED);
			Font font6 = new Font(bf2, 9);
	//	float col=280f;
	d.open();
		PdfContentByte cb = writer.getDirectContent();
        BarcodeEAN barcodeEAN = new BarcodeEAN();
        barcodeEAN.setBarHeight(50);
        String s = String.valueOf(idSzkola);
        s = "0000000000000".substring(s.length()) + s; 
        barcodeEAN.setCode(s);
        barcodeEAN.setCodeType(Barcode.EAN13);
        PdfTemplate template = barcodeEAN.createTemplateWithBarcode(cb, BaseColor.BLACK, BaseColor.BLACK);
        float x = 36;
        float y = 750;
        float w = template.getWidth()+50;
        float h = template.getHeight()-10;
        Rectangle rect = new Rectangle(x,y,w,h);
        rect.setBorder(Rectangle.BOX);
        rect.setBorderColor(BaseColor.WHITE);
        rect.setBorderWidth(0.5f);
        cb.rectangle(rect);
        cb.stroke();
        cb.addTemplate(template, 36, 750);

	Image logo=Image.getInstance("http://www.mbg.uz.zgora.pl/logo.php");
	logo.setAbsolutePosition(200,750);
	logo.scalePercent(80);
	d.add(logo);
		d.add(new Paragraph("      "));
		d.add(new Paragraph("      "));
		d.add(new Paragraph("      "));
		Paragraph p=new Paragraph("ZGŁOSZENIE UDZIAŁU W KONKURSIE",font2);
		p.setAlignment(Element.ALIGN_CENTER);
		d.add(p);
		d.add(new Paragraph("      "));
		
		float columnWidth[] = {120F, 160F, 80F,60F};
		PdfPTable t = new PdfPTable(columnWidth);
//		t.setTotalWidth(400F);
		t.getDefaultCell().setBorder(0);
		PdfPCell pcell = new PdfPCell(new Paragraph("Kod zgłoszenia:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+idSzkola,font3));
		t.addCell(new Paragraph("Data zgłoszenia:",font4));
		t.addCell(new Paragraph("  "+data2,font3));
		
		pcell = new PdfPCell(new Paragraph("Województwo:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+wojewodztwo,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("Powiat:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+powiat,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		if(nazwaZespolu!=null && nazwaZespolu!="") {
		pcell = new PdfPCell(new Paragraph("Nazwa Zespołu Szkół:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+nazwaZespolu,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		}
		pcell = new PdfPCell(new Paragraph("Nazwa Szkoły:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+nazwa,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		if(imienia!=null && imienia!="") {
		pcell = new PdfPCell(new Paragraph("Patron Szkoły:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+imienia,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		}
		pcell = new PdfPCell(new Paragraph("Adres Szkoły:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+ulica+" "+nrDomu+"\n "+kodPocztowy+" " +miejscowosc2,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("Telefon:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+telefon,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		if(email!=null && email!="") {
		pcell = new PdfPCell(new Paragraph("Adres e-mail:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+email,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		}
		pcell = new PdfPCell(new Paragraph("Dyrektor:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+tytul+" "+imie+" "+nazwisko,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("E-mail:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+demail,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("Nauczyciel koordynujący:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+ktytul+" "+kimie+" "+knazwisko,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("E-mail:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+kemail,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		pcell = new PdfPCell(new Paragraph("Telefon kontaktowy:   ",font4));
		pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		pcell.setBorder(0);
		t.addCell(pcell);
		t.addCell(new Paragraph("  "+ktelefon,font3));
		t.addCell(new Paragraph(" "));
		t.addCell(new Paragraph(" "));
		d.add(t);
	if(komisja=="1") {
		p=new Paragraph("Deklaruję udział w sprawdzaniu prac finałowych uczestników konkursu",font3);
		p.setAlignment(Element.ALIGN_CENTER);
		d.add(p);
	}
		p=new Paragraph(" ",font4);
        p.setLeading(12, 0);
        d.add(p);
        
		float columnWidth2[] = {1, 1, 2,1,1};   
		  PdfPTable table = new PdfPTable(columnWidth2);
		  table.setWidthPercentage(100);
	       table.addCell(new Paragraph("typ klasy",font4));
	       table.addCell(new Paragraph("nazwa klasy",font4));
	       table.addCell(new Paragraph("nauczyciel",font4));
	       table.addCell(new Paragraph("liczba uczniów",font4));
	       table.addCell(new Paragraph("język",font4));

		  for (int i = 0; i <liczba ; i++) {
	        table.addCell(new Paragraph(typ[i],font3));
	        table.addCell(new Paragraph(nazwaKlasy[i],font3));
	        table.addCell(new Paragraph(ntytul[i]+" "+nimie[i]+" "+nnazwisko[i],font3));
	        table.addCell(new Paragraph(liczbaUczniow[i],font3));
	        table.addCell(new Paragraph(jezyk[i],font3));
		  }
	        d.add(table); 
	        
	        p=new Paragraph("Proszę dołączyć listy uczniów z poszczególnych klas.\r\n"
	        		+ "Zgłoszenia udziału w konkursie należy przesłać do 22-02-2023r na adres:",font5); 
	        p.setLeading(12, 0);
	        d.add(p);
	        p=new Paragraph(" ",font4);
	        p.setLeading(10, 0);
	        d.add(p);
	        
	        String text = "RKO MK „Matematyka bez granic”\r\n"
	                + region +"\n"
	                + adres1+"\n"
	                + ulica1+" "+nrDomu1+"\n"
	                + kodPocztowy1+" "+miejscowosc2+"\n";
	        if(dopisek!=null) {
	        text=text+"z dopiskiem "+dopisek;	
	        }
	    p = new Paragraph(text, font4);
	   
	        p.setLeading(12, 0);
	        d.add(p);
	        d.add(new Paragraph(" "));
	        float columnWidth3[] = {1,1};
			PdfPTable t2 = new PdfPTable(columnWidth3);
			t2.setWidthPercentage(100);
			t2.getDefaultCell().setBorder(0);
			pcell = new PdfPCell(new Paragraph("Liczba klas zgłoszonych do konkursu= "+liczba,font6));
			pcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			pcell.setBorder(0);
			t2.addCell(pcell);
			pcell = new PdfPCell(new Paragraph("Pieczątka szkoły",font6));
			pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			pcell.setBorder(0);
			t2.addCell(pcell);
			t2.addCell(new Paragraph(" "));
			t2.addCell(new Paragraph(" "));
			t2.addCell(new Paragraph(" "));
			t2.addCell(new Paragraph(" "));
			pcell = new PdfPCell(new Paragraph("Podpisy nauczycieli",font6));
			pcell.setHorizontalAlignment(Element.ALIGN_LEFT);
			pcell.setBorder(0);
			t2.addCell(pcell);
			pcell = new PdfPCell(new Paragraph("Podpis dyrektora",font6));
			pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			pcell.setBorder(0);
			t2.addCell(pcell);
			d.add(t2);
			
			PdfPTable t3 = new PdfPTable(columnWidth3);
			t3.setTotalWidth(504);
			t3.getDefaultCell().setBorder(0);
			
			d.close();
			
			conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		catch(DocumentException de) {
			throw new IOException(de.getMessage());
		}
}
}
