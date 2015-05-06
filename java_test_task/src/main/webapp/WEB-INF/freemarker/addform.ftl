<#import "spring.ftl" as spring />
<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}
</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="body">
	<a href="list.htm">${resloc["listemp"]}</a>
	<h1 ALIGN="center">${resloc["addingemp"]}</h1>
		
		<form method="POST">
		<table>
		
			<tr>
				<td>${resloc["firstname"]}:</td>
			<td>	 <@spring.formInput "formemployee.firstname"/></td>
				<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
			</tr>
			
			<tr>
				<td>${resloc["lastname"]}:</td>
			<td>	 <@spring.formInput "formemployee.lastname"/></td>
				<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
			</tr>

	
			<tr>
				<td>${resloc["division"]}:</td>
			<td>
			 <@spring.formSingleSelect "formemployee.division" , divarr/>
				<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
			</tr>
			
			<tr>
				<td>${resloc["salary"]}:</td>
			<td>	 <@spring.formInput "formemployee.salary"/></td>
				<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
			</tr>
			
			<tr>
				<td>${resloc["birthday"]}:</td>
				<td>${resloc["year"]}:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 <@spring.formSingleSelect "formemployee.year" , arryear/><br>
			 		${resloc["month"]}:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 <@spring.formSingleSelect "formemployee.month", arrmonth/><br>
			 		${resloc["day"]}:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 <@spring.formSingleSelect "formemployee.day", arrday/><br></td>
			 	<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
			</tr>
			
			<tr>
				<td>${resloc["isactive"]}:</td>
				<td><@spring.formSingleSelect "formemployee.active", arrbool/></td>
				<td></td>
			</tr>
			
			<tr>
				<td align="center" colspan="2">
			 	<input type="submit" value="${add}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 	<a href="list.htm">${resloc["back"]}</a></td>
				<td></td>
			</tr>
			
		</table>
	</form>
	
</body>
</html>
