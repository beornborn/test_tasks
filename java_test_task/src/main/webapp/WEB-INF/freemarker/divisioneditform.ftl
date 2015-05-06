<#import "spring.ftl" as spring/>
<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}
</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="body">
	<a href="divisionlist.htm">${resloc["listdiv"]}</a>
	<h1 ALIGN="center">${resloc["editingdiv"]}</h1>

	<form method="POST">
		<table>
			<tr>
				<td>${resloc["division"]}:</td>
				<td><@spring.formInput "formdivision.division"/></td>
				<td><span class="error"> <@spring.showErrors "<br>"/></span></td>
				<td><@spring.formHiddenInput path="formdivision.id"/></td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="${edit}"/>
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a	href="divisionlist.htm">${resloc["back"]}</a></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</form>

</body>
</html>
