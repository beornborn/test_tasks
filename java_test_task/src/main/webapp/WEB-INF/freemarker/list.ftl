<#import "spring.ftl" as spring/>
<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body class="body">
	<div style="height: 50;width: 300;float: left;">
	<a href="list.htm">${resloc["listemp"]}</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="divisionlist.htm">${resloc["listdiv"]}</a>
	</div>
	
	<div align="right" style="height: 50;width: 100; float: right;">
	<a href="j_spring_security_logout">Log Out</a>
	<a href="rnd.htm" style=""><img src="images/rnd.png" 
	alt="generate random list of employees" style="vertical-align: middle; "></a>
	</div>
	
	<br>
	<br>
	<h1 ALIGN="center">${resloc["listemp"]}</h1>
	<a href="addform.htm">${resloc["addemp"]}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<br>
	<div>
	<form method="POST">
	<@spring.formInput "searchentity.searchentity"/>
	<INPUT TYPE="submit" VALUE=${search}>
	</form>
	</div>
	<br>
	
	<div class="${style}">${state}</div>
		<table CELLPADDING="5">
			<tr>
      			<th>${resloc["id"]}</th>
      			<th>${resloc["firstname"]}</th>
      			<th>${resloc["lastname"]}</th>
  			 <tr>
	<#list model as emp>
			<tr>
				<td>${emp.id?string("0")}</td>
				<td>${emp.firstname}</td>
				<td>${emp.lastname}</td>
				<td width="150" align="right">
					<a href="employee.htm?viewId=${emp.id?string("0")}">${resloc["view"]}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;<a href="delete.htm?deleteId=${emp.id?string("0")}">${resloc["delete"]}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;<a href="editform.htm?editId=${emp.id?string("0")}">${resloc["edit"]}</a>
				</td>
			</tr>
	</#list>
	</table>

</body>
</html>