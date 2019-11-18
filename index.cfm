
<cfscript>
param url.action = "";

param form.secretkey 	= "Banana";
param form.algorithm 	= "HS256";
param form.payload 		= '{ "animal" : "cat" }'; // string
</cfscript>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>JWT Demo</title>


	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
	
	<link rel="start"  	href="index.cfm" />
	<link rel="made" 	href="mailto:james@webworldinc.com" />
</head>	


<body>


<div class="container">

<div class="jumbotron">
	<h1>JWT</h1>
	<p>Get HTML out of a Word Document</p>
</div>


<cfoutput>
<form action="index.cfm?action=extract" method="post" enctype="multipart/form-data">
	<div class="form-group row">
		<label>Secret key</label>
		<input type="text" class="form-control" name="secretkey" value="#encodeForHTMLAttribute(form.secretkey)#">
	</div>

	<div class="form-group row">
		<label>ALGORITHM</label>
		<select class="form-control" name="algorithm">
			<option value="HS256" <cfif form.algorithm EQ "HS256">selected</cfif> >HS256</option>
			<option value="HS384" <cfif form.algorithm EQ "HS384">selected</cfif>>HS384</option>
			<option value="HS512" <cfif form.algorithm EQ "HS512">selected</cfif>>HS512</option>
		</select>
	</div>

	<div class="form-group row">
		<label>Example textarea</label>

		<textarea class="form-control" name="payload" rows="3">#encodeForHTML(form.payload)#</textarea>
	</div>

	<div class="form-group row">
		<button type="submit" class="btn btn-primary btn-large">Process</button>
	</div>
</form>
</cfoutput>

<cfif url.action EQ "extract">
	<h4>Results</h4>

	<cfscript>
	

	variables.data = DeserializeJSON(form.payload);

	objJwt = new jwt.jwt(form.secretkey);

	variables.token = objJwt.encode(variables.data, form.algorithm);

	writeoutput("<tt style= 'white-space: pre-wrap; overflow-wrap : break-word;'>" & variables.token & "</tt>");

	variables.result = objJwt.decode(variables.token);

	writedump(variables.result);
	</cfscript>

</cfif>



	</div>

</body>
</html>



