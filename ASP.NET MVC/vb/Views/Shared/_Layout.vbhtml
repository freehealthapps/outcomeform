<!--
/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details:
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@ViewBag.Title - Dynamic Outcome Form</title>
    <link href="/css/site.css?v=3" rel="stylesheet" />
    <link href="~/css/site-responsive.css" rel="stylesheet" />

    <!--[if IE]>
    <style type="text/css">
        .button {filter:chroma(color=#000000);border:0px;margin-top:-2px;}
    </style>
    <![endif]-->

    <!--[if lt IE 9]>
        <script src="/scripts/respond.min.js"></script>
    <![endif]-->


    <script src="~/scripts/jquery-1.10.2.min.js"></script>
    <script src="~/scripts/jquery.inputmask.bundle.min.js"></script>
    <script src="~/scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="~/scripts/jquery.validate.min.js"></script>
    <script src="~/scripts/jquery.validate.unobtrusive.min.js"></script>
</head>
<body>
        @If User.Identity.IsAuthenticated Then
            @<div class="grid fluid">
                <div class="row page-layout">
                    <div class="span1"></div>
                    <div class="span10">
                        <span style="float:left;">
                                <b>Logged in as: </b> @User.Identity.Name <a href="/account/logout">Logout</a><br/>
                        </span>
                        <span style="float:right;"><a href="/"><img src="~/img/logo.jpg" alt="Medway Founadtion Trust" /></a></span>
                    </div>
                </div>
            </div>
            @<div class="grid fluid">
                <div class="row page-layout">
                    <div class="span1"></div>
                    <div class="span10">
                        @RenderBody()
                    </div>
                </div>
            </div>
        Else
            @<div Class="grid fluid">
                @RenderBody()
            </div>
        End If
</body>
</html>