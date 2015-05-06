<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body class="body">
	<h1 ALIGN="center">${resloc["viewemp"]}</h1>
	<table CELLPADDING="5">
  		<tr>
      		<th>${resloc["id"]}</th>
      		<th>${resloc["firstname"]}</th>
    		<th>${resloc["lastname"]}</th>
      		<th>${resloc["division"]}</th>
      		<th>${resloc["salary"]}</th>
      		<th>${resloc["birthday"]}</th>
      		<th>${resloc["isactive"]}</th>
      		<th></th>
   		<tr>
		<tr> 
			<td>${emp.id?string("0")}</td>
			<td>${emp.firstname}</td>
			<td>${emp.lastname}</td>
			<td>${emp.division.division}</td>
			<td>${salary}</td>
			<td>${day} ${month} ${year}</td>
			<td>${emp.active?string("true", "false")}</td>
			<td width="150" align="right">&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="delete.htm?deleteId=${emp.id?string("0")}">${resloc["delete"]}</a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="editform.htm?editId=${emp.id?string("0")}">${resloc["edit"]}</a></td>
		</tr>
	</table> 
   
    <a href="list.htm"/>${resloc["back"]}</a>
</body>
</html>
		 
