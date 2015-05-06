<#import "/spring.ftl" as spring />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#-- ${resloc[]} - localization variables--> 
<title>${resloc["title"]}</title>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="body">
	<br />
	<br />
	<br />
	<h1 align="center" class="hcenter">${resloc["manageofpers"]}</h1>
	<br />
	<h2 align="center" class="hcenter">${resloc["authisneed"]}</h2>
	<br />
	<div class="hcenter">
	 <#if Session.SPRING_SECURITY_LAST_EXCEPTION?? && Session.SPRING_SECURITY_LAST_EXCEPTION.message?has_content>
			<font color="red"> ${resloc["loginnotsuccess"]}.
			<br />
			<br /> ${resloc["reason"]}: 
			${SPRING_SECURITY_LAST_EXCEPTION.message}
			</font>
		</#if>
	</div>
	
	 <form method="POST"	action="perman/j_spring_security_check">
		<table class="hcentertab">
			<tr>
				<td align="center">${resloc["login"]}</td>
				<td><input type="text" name="j_username" /></td>
			</tr>
			<tr>
				<td align="center">${resloc["password"]}</td>
				<td><input type="password" name="j_password" /></td>
			</tr>
			<tr>
				<td align="center">${resloc["remember"]}</td>
				<td><input type="checkbox" name="_spring_security_remember_me" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
				value=${login} /> <input type="reset" value=${reset} /></td>
			</tr>
		</table>
		</form>
</body>
</html>
		 

		 