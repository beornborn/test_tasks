<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body class="body">
	<a href="list.htm">${resloc["listemp"]}</a> &nbsp;&nbsp;&nbsp;&nbsp;
	<a href="divisionlist.htm">${resloc["listdiv"]}</a>
	<h1 ALIGN="center">${resloc["listdiv"]}</h1>
	<a href="divisionaddform.htm">${resloc["adddiv"]}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="${style}">${state}</div>
	
	<table CELLPADDING="5">
		<tr>
			<th>${resloc["id"]}</th>
			<th>${resloc["division"]}</th>
			<th></th>
		</tr>
	<#list model as divis>
		<tr>
			<td>${divis.id?string("0")}</td>
			<td>${divis.division}</td>
			<td width="150" align="right">
				<a href="divisionview.htm?viewId=${divis.id?string("0")}">
				${resloc["view"]}</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="divisiondelete.htm?deleteId=${divis.id?string("0")}">
				${resloc["delete"]}</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="divisioneditform.htm?editId=${divis.id?string("0")}">
				${resloc["edit"]}</a>
			</td>
		</tr>
	</#list>
    </table> 
  
  </body>
</html>