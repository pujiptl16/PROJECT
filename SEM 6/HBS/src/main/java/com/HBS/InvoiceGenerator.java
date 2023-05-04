package com.HBS;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.FontSelector;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class InvoiceGenerator {

	public static void GeneratePDF(String Name, HttpServletRequest request, HttpServletResponse response) {
	
		//String pdfFilename = "C:\\Users\\Parth\\OneDrive\\Desktop\\" + Name;
		String pdfFilename = Name;
		
		try {
			createPDF(pdfFilename, request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	} 
	
	private static void createPDF (String pdfFilename, HttpServletRequest request, HttpServletResponse response) throws SQLException{

		Connection con = null;
		try {
		   	con = DatabaseConnection.InitializeDatabase("dormzz");
		    if(con != null) {
		    	//out.println("<script>alert('Database Connected Successfully.')</script>");
		    } else {
		    	System.out.println("Database Not Connected.");
		    }
		}
		catch (Exception e) {
			System.out.println("Error Establishing Database Connection. "+e.toString());
		}
		
		String query = "SELECT RG.EnrollmentNo, RG.FirstName, RG.LastName, RG.Email, RG.PhoneNo, RG.Gender, PK.Package_Name, PK.Package_Price, TR.Trn_Timestamp, TR.Trn_Amount, TR.Trn_Mode, TR.Trn_refference_id FROM tbltransaction TR LEFT JOIN tblhostel_record HR ON TR.Record_id = HR.Record_id LEFT JOIN tblpackage PK ON HR.Package_id = PK.Package_id LEFT JOIN tblregister RG ON TR.user_id = RG.user_id WHERE TR.Trn_id = ?";
		
		String id = request.getParameter("invoice_id");
		PreparedStatement statement = con.prepareStatement(query);
	    statement.setString(1, id);
	    ResultSet rs = statement.executeQuery();
		
	    if (rs.next()) {
	    	 
	    	String EnNo = rs.getString("EnrollmentNo");
	    	String Fname = rs.getString("FirstName");
	    	String Lname = rs.getString("LastName");
	    	String Email = rs.getString("Email");
	    	String PhoneNo = rs.getString("PhoneNo");
	    	String Gender = rs.getString("Gender");
	    	String PackageName = rs.getString("Package_Name");
	    	String PackagePrice = rs.getString("Package_Price");
	    	String inputDate = rs.getString("Trn_Timestamp");
	    	String TrnDate = "";
	    	String TrnAmount = rs.getString("Trn_Amount");
	    	String TrnMode = rs.getString("Trn_Mode");
	    	String TrnRefferenceID = rs.getString("Trn_refference_id");
	    	String InvoiceNo = "";
	    	String BillTo = "";
	    	
	    	DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    	LocalDateTime dateTime = LocalDateTime.parse(inputDate, inputFormatter);
	    	DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
	    	TrnDate = dateTime.format(outputFormatter);
	    	
	    	if(Gender.equals("Girls"))
	    		BillTo = "Ms. " + Fname + " " + Lname;
	    	else if(Gender.equals("Boys"))
	    		BillTo = "Mr. " + Fname + " " + Lname;
	    	
	    	if(Integer.parseInt(id)<10)
	    		InvoiceNo = "D" + Fname.charAt(0)+Lname.charAt(0)+ TrnDate.substring(0, 2) + TrnDate.substring(3, 5)+  "00" + id;
	    	else if(Integer.parseInt(id)>9 && Integer.parseInt(id)<100)
	    		InvoiceNo = "D" + Fname.charAt(0)+Lname.charAt(0)+ TrnDate.substring(0, 2) + TrnDate.substring(3, 5)+ "0" + id;
	    	else if(Integer.parseInt(id)>99 && Integer.parseInt(id)<1000)
	    		InvoiceNo = "D" + Fname.charAt(0)+Lname.charAt(0)+ TrnDate.substring(0, 2) + TrnDate.substring(3, 5)+ id;
	    	
	    		
	    		
			try {
	
				//OutputStream file = new FileOutputStream(new File(pdfFilename));
				Document document = new Document();
	
				response.setContentType("application/pdf");
				response.setHeader("Content-disposition", "attachment; filename=" + pdfFilename);
				ServletOutputStream out = response.getOutputStream();
				PdfWriter.getInstance(document, out);
				
				//PdfWriter.getInstance(document, file);
	
				//Defining Fonts
				/*FontSelector fs = new FontSelector();
				Font font = FontFactory.getFont(FontFactory.TIMES_ROMAN, 10, Font.BOLD);
				fs.addFont(font);*/
	
				String PoppinsRegular_path = "/WEB-INF/Poppins-Regular.ttf";
				String PoppinsBold_path = "/WEB-INF/Poppins-Bold.ttf";
				
				String fontname = request.getServletContext().getRealPath(PoppinsRegular_path);  
				FontFactory.register(fontname); 
				
				fontname = request.getServletContext().getRealPath(PoppinsBold_path);  
				FontFactory.register(fontname); 
				
				// Fonts to be Used
				Font PoppinsLightFont = FontFactory.getFont("Poppins-Regular", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 7, Font.NORMAL, BaseColor.GRAY);
				Font PoppinsRegularFont = FontFactory.getFont("Poppins-Regular", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 10, Font.NORMAL); 
				Font PoppinsBoldFont = FontFactory.getFont("Poppins-Bold", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 10, Font.NORMAL);
				
				//System.out.println(FontFactory.getRegisteredFonts().toString());
				FontSelector fs = new FontSelector();
				fs.addFont(PoppinsBoldFont);
				
				
				//BEGINING OF DOCUMENT
				
				//Inserting Image in PDF
				Image image = Image.getInstance ("C:\\Users\\Parth\\eclipse-workspace\\Demo1\\src\\main\\webapp\\Dormzz Receipt Header.png");//Header Image
				image.scaleAbsolute(540f, 132f);//image width,height 
				
				PdfPTable irdTable = new PdfPTable(2);
				PdfPCell cell;
	
				cell = new PdfPCell(new Phrase("Invoice No : ", PoppinsRegularFont));
				cell.setBorder(0);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				irdTable.addCell(cell);
	
				cell = new PdfPCell(new Phrase(InvoiceNo, PoppinsRegularFont));
				cell.setBorder(0);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				irdTable.addCell(cell);
	
				cell = new PdfPCell(new Phrase("Invoice Date : ", PoppinsRegularFont));
				cell.setBorder(0);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				irdTable.addCell(cell);
	
				cell = new PdfPCell(new Phrase(TrnDate, PoppinsRegularFont));
				cell.setBorder(0);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				irdTable.addCell(cell);
	
				
				
				PdfPTable irhTable = new PdfPTable(3);
				irhTable.setWidthPercentage(100);
	
				irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
				irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
				irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
				
				/*PdfPCell cell = new PdfPCell(new Phrase("Invoice", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				irhTable.addCell(cell);*/
				
				irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
				irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
				
				PdfPCell invoiceTable = new PdfPCell (irdTable);
				invoiceTable.setBorder(0);
				irhTable.addCell(invoiceTable);
	
				Phrase bill = fs.process("Bill To : "); // customer information
				Paragraph name = new Paragraph(BillTo + "\n" + EnNo, PoppinsRegularFont);
				name.setIndentationLeft(20);
				Paragraph contact = new Paragraph(PhoneNo, PoppinsRegularFont);
				contact.setIndentationLeft(20);
				Paragraph address = new Paragraph(Email, PoppinsRegularFont);
				address.setIndentationLeft(20);
	
				PdfPTable billTable = new PdfPTable(6); //one page contains 15 records 
				billTable.setWidthPercentage(100);
				billTable.setWidths(new float[] { 1, 2,5,2,1,2 });
				billTable.setSpacingBefore(30.0f);
				/*
				billTable.addCell(getBillHeaderCell("Index"));
				billTable.addCell(getBillHeaderCell("Item"));
				billTable.addCell(getBillHeaderCell("Description"));
				billTable.addCell(getBillHeaderCell("Unit Price"));
				billTable.addCell(getBillHeaderCell("Qty"));
				billTable.addCell(getBillHeaderCell("Amount"));
	
				billTable.addCell(getBillRowCell("1"));
				billTable.addCell(getBillRowCell("Package"));
				billTable.addCell(getBillRowCell("Dormzz : Premium Package"));
				billTable.addCell(getBillRowCell("39000.0"));
				billTable.addCell(getBillRowCell("1"));
				billTable.addCell(getBillRowCell("39000.0"));*/
	
				// Add table headers
				cell = new PdfPCell(new Phrase("No.", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Particular", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Description", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Price", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Qty", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Amount", PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				billTable.addCell(cell);
	
				// Add table data
				cell = new PdfPCell(new Phrase("1", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Package", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthLeft(0);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("Dormzz : " + PackageName + " Package", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPadding (5.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthLeft(0);
				cell.setBorderWidthRight(0);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase(PackagePrice, PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthRight(0);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase("1", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthRight(0);
				billTable.addCell(cell);
				
				cell = new PdfPCell(new Phrase(TrnAmount, PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding (5.0f);
				cell.setBorderWidthTop(0);
				cell.setBorderWidthBottom(0);
				billTable.addCell(cell);
	
				
	/*
				billTable.addCell(getBillRowCell("2"));
				billTable.addCell(getBillRowCell("Accessories"));
				billTable.addCell(getBillRowCell("Nokia Lumia 610 Panel \n Serial:TIN3720 "));
				billTable.addCell(getBillRowCell("200.0"));
				billTable.addCell(getBillRowCell("1"));
				billTable.addCell(getBillRowCell("200.0"));
	
	
				billTable.addCell(getBillRowCell("3"));
				billTable.addCell(getBillRowCell("Other"));
				billTable.addCell(getBillRowCell("16Gb Memorycard \n Serial:UR8531 "));
				billTable.addCell(getBillRowCell("420.0"));
				billTable.addCell(getBillRowCell("1"));
				billTable.addCell(getBillRowCell("420.0"));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
	
				billTable.addCell(getBillRowCell(" "));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));
				billTable.addCell(getBillRowCell(""));*/
				
				for(int i=0; i<14; i++) {
					cell = new PdfPCell(new Phrase(" ", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					billTable.addCell(cell);
					cell = new PdfPCell(new Phrase("", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidth(1);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					cell.setBorderWidthLeft(0);
					billTable.addCell(cell);
					cell = new PdfPCell(new Phrase("", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidth(1);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					cell.setBorderWidthLeft(0);
					cell.setBorderWidthRight(0);
					billTable.addCell(cell);
					cell = new PdfPCell(new Phrase("", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidth(1);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					cell.setBorderWidthRight(0);
					billTable.addCell(cell);
					cell = new PdfPCell(new Phrase("", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidth(1);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					cell.setBorderWidthRight(0);
					billTable.addCell(cell);
					cell = new PdfPCell(new Phrase("", PoppinsBoldFont));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setPadding (5.0f);
					cell.setBorderWidthTop(0);
					cell.setBorderWidthBottom(0);
					billTable.addCell(cell); 
				}
				PdfPTable validity = new PdfPTable(1);
				validity.setWidthPercentage(100);
	
				validity.setHorizontalAlignment(Element.ALIGN_LEFT); // set the horizontal alignment of the table
	
				cell = new PdfPCell(new Phrase(" Note :", PoppinsLightFont));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT); // set the horizontal alignment of the cell
				cell.setBorder(0);
				validity.addCell(cell);
	
				cell = new PdfPCell(new Phrase(" * At the time of deposit refund, submit original deposit receipt.", PoppinsLightFont));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT); // set the horizontal alignment of the cell
				cell.setBorder(0);
				validity.addCell(cell);
	
				cell = new PdfPCell(new Phrase(" * Any disputes Subject to Mahuva, Dist. Surat Jurisdiction", PoppinsLightFont));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT); // set the horizontal alignment of the cell
				cell.setBorder(0);
				validity.addCell(cell);
	
				cell = new PdfPCell(new Phrase(" * Any refund of fees subject to UTU rules and regulations.", PoppinsLightFont));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT); // set the horizontal alignment of the cell
				cell.setBorder(0);
				validity.addCell(cell);
				
				PdfPCell summaryL = new PdfPCell (validity);
				summaryL.setColspan (3);
				summaryL.setPadding (1.0f);	                   
				billTable.addCell(summaryL);
	
				PdfPTable accounts = new PdfPTable(2);
				accounts.setWidthPercentage(100);
				
				cell = new PdfPCell(new Phrase("Subtotal", PoppinsRegularFont));
				cell.setBorder(0);
				cell.setPadding (5.0f);
				cell.setPaddingRight(20.0f);
				accounts.addCell(cell);
				
				cell = new PdfPCell(new Phrase("0.00", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setBorder(0);
				cell.setPadding (5.0f);
				accounts.addCell(cell);
	
				cell = new PdfPCell(new Phrase("Discount (0%)", PoppinsRegularFont));
				cell.setBorder(0);
				cell.setPadding (5.0f);
				cell.setPaddingRight(20.0f);
				accounts.addCell(cell);
				
				cell = new PdfPCell(new Phrase("0.00", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setBorder(0);
				cell.setPadding (5.0f);
				accounts.addCell(cell);
	
				cell = new PdfPCell(new Phrase("Tax(0%)", PoppinsRegularFont));
				cell.setBorder(0);
				cell.setPadding (5.0f);
				cell.setPaddingRight(20.0f);
				accounts.addCell(cell);
				
				cell = new PdfPCell(new Phrase("0.0", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setBorder(0);
				cell.setPadding (5.0f);
				accounts.addCell(cell);
	
				cell = new PdfPCell(new Phrase("Total", PoppinsBoldFont));
				cell.setPadding (5.0f);
				cell.setPaddingRight(20.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthLeft(0);
				cell.setBorderWidthRight(0);
				accounts.addCell(cell);
				
				cell = new PdfPCell(new Phrase(PackagePrice, PoppinsBoldFont));
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPadding (5.0f);
				cell.setBorderWidth(1);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthLeft(0);
				cell.setBorderWidthRight(0);
				accounts.addCell(cell);
				
				PdfPCell summaryR = new PdfPCell (accounts);
				summaryR.setColspan (3);         
				billTable.addCell(summaryR);  
	
				PdfPTable describer = new PdfPTable(1);
				describer.setWidthPercentage(100);
				
				cell = new PdfPCell(new Phrase(" ", PoppinsRegularFont));
				cell.setBorder(0);
				describer.addCell(cell);
	
				cell = new PdfPCell(new Phrase("This is a computer generated receipt and does not require a signature and stamp.", PoppinsRegularFont));
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setBorder(0);
				describer.addCell(cell);	
	
				document.open();//PDF document opened........	
	
				document.add(image);
				document.add(irhTable);
				document.add(bill);
				document.add(name);
				document.add(contact);
				document.add(address);			
				document.add(billTable);
				document.add(describer);
	
				document.close();
	
				//file.close();
				out.close();
	
				System.out.println("Pdf created successfully..");
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		
	    }
	}

	public static void setHeader() {

	}


	public static PdfPCell getIRHCell(String text, int alignment) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 16);
		/*	font.setColor(BaseColor.GRAY);*/
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell(phrase);
		cell.setPadding(5);
		cell.setHorizontalAlignment(alignment);
		cell.setBorder(PdfPCell.NO_BORDER);
		return cell;
	}

	public static PdfPCell getIRDCell(String text) {
		PdfPCell cell = new PdfPCell (new Paragraph (text));
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setPadding (5.0f);
		cell.setBorderColor(BaseColor.LIGHT_GRAY);
		return cell;
	}

	public static PdfPCell getBillHeaderCell(String text) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 11);
		font.setColor(BaseColor.GRAY);
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell (phrase);
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setPadding (5.0f);
		return cell;
	}

	public static PdfPCell getBillRowCell(String text) {
		PdfPCell cell = new PdfPCell (new Paragraph (text));
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setPadding (5.0f);
		cell.setBorderWidthBottom(0);
		cell.setBorderWidthTop(0);
		return cell;
	}

	public static PdfPCell getBillFooterCell(String text) {
		PdfPCell cell = new PdfPCell (new Paragraph (text));
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setPadding (5.0f);
		cell.setBorderWidthBottom(0);
		cell.setBorderWidthTop(0);
		return cell;
	}

	public static PdfPCell getValidityCell(String text) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
		font.setColor(BaseColor.GRAY);
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell (phrase);		
		cell.setBorder(0);
		return cell;
	}

	public static PdfPCell getAccountsCell(String text) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell (phrase);		
		cell.setBorderWidthRight(0);
		cell.setBorderWidthTop(0);
		cell.setPadding (5.0f);
		return cell;
	}
	public static PdfPCell getAccountsCellR(String text) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell (phrase);		
		cell.setBorderWidthLeft(0);
		cell.setBorderWidthTop(0);
		cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
		cell.setPadding (5.0f);
		cell.setPaddingRight(20.0f);
		return cell;
	}

	public static PdfPCell getdescCell(String text) {
		FontSelector fs = new FontSelector();
		Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
		font.setColor(BaseColor.GRAY);
		fs.addFont(font);
		Phrase phrase = fs.process(text);
		PdfPCell cell = new PdfPCell (phrase);	
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setBorder(0);
		return cell;
	}

}

