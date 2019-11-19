<cffunction name="epochTime">
	
	<cfscript>
	
		// set the base time from when epoch time starts
		startDate = createdatetime( '1970','01','01','00','00','00' );
		
		datetimeNow = dateConvert( "local2Utc", now() );
		
		return datediff( 's', startdate, datetimeNow );
	
	</cfscript>
	
</cffunction>


<cfscript>
param url.action = "";

param form.secretkey 	= "Banana";
param form.jti 		= 0;
param form.issued 		= 0;
param form.iss 		= "Default ISS";
param form.OrgUnitId 	= "The merchant SSO OrgUnitID";
param form.algorithm 	= "HS256";
param form.payload 		= '{ "OrderDetails" : {
            "OrderNumber" : "0e5c5bf2-ea64-42e8-9ee1-71fff6522e15",
            "Amount" : "1500",
            "CurrencyCode" : "840"
        }}'; // string
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
		<div class="form-check">
			<input class="form-check-input" type="checkbox" name="jti" value="1" <cfif form.jti>checked</cfif> />
			<label class="form-check-label" for="defaultCheck1">
				JWT ID (jti)
			</label>
		</div>
	</div>

	<div class="form-group row">
		<div class="form-check">
			<input class="form-check-input" type="checkbox" name="issued" value="1" <cfif form.issued>checked</cfif> />
			<label class="form-check-label" for="defaultCheck1">
				Issued At (iat)
			</label>
		</div>
	</div>

	<div class="form-group row">
		<label>Issuer</label>
		<input type="text" class="form-control" name="iss" value="#encodeForHTMLAttribute(form.iss)#">
	</div>

	<div class="form-group row">
		<label>Org Unit ID</label>
		<input type="text" class="form-control" name="orgunitid" value="#encodeForHTMLAttribute(form.orgunitid)#">
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
	


	objJwt = new jwt.jwt(form.secretkey);

	variables.data["payload"] = DeserializeJSON(form.payload);
	if (form.jti)	{
		variables.data["jti"] = createuuid();
	}

	if (form.issued)	{
		variables.data["iat"] = epochTime();
	}

	if (form.iss != "")	{
		variables.data["iss"] = form.iss;
	}

	if (form.orgunitid != "")	{
		variables.data["OrgUnitId"] = form.orgunitid;
	}

	variables.data["ReferenceId"] = createuuid();

	variables.token = objJwt.encode(variables.data, form.algorithm);

	writeoutput("<tt style= 'white-space: pre-wrap; overflow-wrap : break-word;'>" & variables.token & "</tt>");

	variables.result = objJwt.decode(variables.token);

	writedump(variables.result);
	</cfscript>

</cfif>



	</div>

</body>
</html>



