<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="body">
<h1 ALIGN="center">${resloc["viewdiv"]}</h1>
  
	<table CELLPADDING="5">
		<tr>
			<th>${resloc["id"]}</th>
			<th>${resloc["division"]}</th>
			<th></th>
		</tr>
		<tr> 
			<td>${divis.id?string("0")}</td><td>${divis.division}</td>
			<td width="150" align="right">	
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="divisiondelete.htm?deleteId=${divis.id?string("0")}">${resloc["delete"]}</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="divisioneditform.htm?editId=${divis.id?string("0")}">${resloc["edit"]}</a></td>
		</tr>
	</table> 
	
    <a href="divisionlist.htm"/>${resloc["back"]}</a>
    </body>
</html>
		 
