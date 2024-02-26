package mbg.javaee;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;

public class MyFooter extends PdfPageEventHelper {
	 PdfTemplate total;
	 Font font = new Font(Font.FontFamily.HELVETICA, 9);
	 public void onOpenDocument(PdfWriter writer, Document document) {
		 total=writer.getDirectContent().createTemplate(30, 12);
	 }
	 public void onEndPage(PdfWriter writer, Document document) {
		 PdfPTable table = new PdfPTable(3);
		 LocalDate data= LocalDate.now();
			DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
			String data2 = data.format(dateTimeFormatter);
		 try {
		        table.setWidths(new int[]{24, 24, 2});
		        table.getDefaultCell().setFixedHeight(11);
		        table.getDefaultCell().setBorder(Rectangle.TOP);
		        PdfPCell cell = new PdfPCell();
		        cell.setBorder (0);
		        cell.setBorderWidthTop (1);
		        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		        cell.setPhrase(new Phrase(data2, font));
		        table.addCell(cell);

		        cell = new PdfPCell();
		        cell.setBorder (0);
		        cell.setBorderWidthTop (1);
		        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		        cell.setPhrase(new Phrase(String.format("Strona %d z", writer.getPageNumber()), font));
		        table.addCell(cell);

		        cell = new PdfPCell(Image.getInstance(total));
		        cell.setBorder (0);
		        cell.setBorderWidthTop (1);
		        table.addCell(cell);
		        table.setTotalWidth(document.getPageSize().getWidth()
		                - document.leftMargin() - document.rightMargin());
		        table.writeSelectedRows(0, -1, document.leftMargin(),
		                document.bottomMargin() - 10, writer.getDirectContent());
		    }catch(DocumentException de) {
		        throw new ExceptionConverter(de);
		    }
		 /*
		 int x=writer.getCurrentPageNumber();
		 int y=writer.getPageNumber();
		 LocalDate data= LocalDate.now();
			DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
			String data2 = data.format(dateTimeFormatter);
			
	        PdfContentByte cb = writer.getDirectContent();
	        Phrase footer = new Phrase(data2, font);
	        Phrase footer2 = new Phrase(String.format("Page %d of %d", x, y), font);
	        
	        ColumnText.showTextAligned(cb, Element.ALIGN_LEFT,
	                footer,
	                document.left(),
	                document.bottom() - 10, 0);
	        ColumnText.showTextAligned(cb, Element.ALIGN_LEFT,
	                footer2,
	                document.right()-document.rightMargin()-20,
	                document.bottom() - 10, 0);
	     */
	 }
		 public void onCloseDocument(PdfWriter writer, Document document) {
			    ColumnText.showTextAligned(total, Element.ALIGN_LEFT,
			            new Phrase(String.valueOf(writer.getPageNumber() - 1), font),
			            1, 1, 0);
			    
			}  
	}

