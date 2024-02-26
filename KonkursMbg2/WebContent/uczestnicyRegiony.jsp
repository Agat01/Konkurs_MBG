<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
 <link rel = "stylesheet" href="style.css"/>
 <script src="script.js"></script>
 <!-- 
  <script type="text/javascript" src="ajaxcore2.js"></script>
<script type="text/javascript" src="ajax2.js"></script> 
  --> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Uczestnicy wg regionów</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>


</head>
<body>
<div id="kontener">
<div id="left">
 <jsp:include page="menu.jsp"></jsp:include>
</div>
<div id="right">
<div class="header" id="header">
<a href="http://www.wmie.uz.zgora.pl/"> <img src="wmie_logo.png" height="100px" align="left" border="0" alt="Przejdź do strony głównej WMIiE"></a>
 <a href="http://www.uz.zgora.pl/"> <img src="uz_logo.png" border="0" align="right" height="100px"  alt="Przejdź do strony głównej UZ"></a>

Krajowy Komitet Organizacyjny<br/>
Międzynarodowego Konkursu<br/>
&quot;<i>Matematyka Bez Granic</i>&quot;
</div>

<div class="mainContent">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="mbg.javaee.encje.*" %>
<%@ page import="mbg.javaee.utils.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
request.setCharacterEncoding("UTF-8");
String nazwaEdycji = request.getParameter("edycja");

Connection conn = DatabaseConnectionManager.getConnection();
List<String> regiony = new ArrayList<String>();

String region="";
String regionS="";

String sql = "select nazwa from region order by nazwa";
Statement stmt = conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	region=rs.getString(1);
	regiony.add(region);
}
rs.close();
stmt.close();
%>
	<h2>Uczestnicy konkursu wg Regionów - <%= nazwaEdycji %></h2>

	<div id="selectorsDiv" class="mainDiv">
	<div style="width:50%;margin:0 auto;text-align:center;">
	<select id="region">
		<option value="0"> </option>
		<option value="1">wszyscy uczestnicy</option>
		 <%
	        for(int i=0;i<regiony.size();i++) {
	        	regionS=regiony.get(i).toString();
	        	int j=i+2;
	        %>
	        <option value="<%=j %>"><%=regionS %></option>
	        <%} %>
		
	</select> 
	</div>
</div>
<div id="dataDiv" class="dataDiv">
<script>
document.getElementById("region").addEventListener("change", function() {
    var selectedValue = this.value;

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "uczestnicyReg?region=" + selectedValue + "&edycja=<%= nazwaEdycji %>", true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        // Uaktualnij zawartość <div> z danymi uczestników
        document.getElementById("dataDiv").innerHTML = xhr.responseText;
      }
    };
    xhr.send();
  });
</script>
</div>
</div>
<footer>
<p>Wszelkie pytania i uwagi proszę kierować na adres xxx </p>
</footer>
</div>
</div>
</body>
</html>