@Code
    ViewData("Title") = "Login"
End Code
@ModelType FreeHealthApps.OutcomeForm.LoginModel
<div class="row login">
    <div class="span3">&nbsp;</div>
    <div class="span6">
        <div class="text-right">
            <img src="~/img/logo.jpg" alt="Medway Founadtion Trust" class="text-right" />
        </div>
        <div>
            <h2>Dynamic Outcome Form</h2>
            <br /><br /><br />
        </div>
        @If Model.Message IsNot Nothing Then
            @<div class="panel" id="pnlError">
                <div Class="panel-header bg-red fg-white">@Model.Message</div>
            </div>
        End If

        @If Model.Demo Then
            @<div Class="panel">
                <div Class="panel-header bg-lightRed fg-white">DEMO Login</div>
                <div Class="panel-content">
                    <div> Please use "guest" and "p@ssword" And click login (Or hit enter) To Continue.</div>
                    <br />
                            @Using Html.BeginForm("Login", "Account")
                            @<div class="row">
                                <div class="span2 text-right padding5">Username</div>
                                <div class="span9">
                                    <div class="input-control text">
                                        @Html.TextBox("username", "", New With {.autocomplete = "off", .class = "username"})
                                    </div>
                                </div>
                            </div>
                            @<div class="row">
                                <div class="span2 text-right padding5">Password</div>
                                <div class="span9">
                                    <div class="input-control text">
                                        @Html.Password("password", "", New With {.autocomplete = "off"})
                                    </div>
                                </div>
                            </div>
                            @<div class="row">
                                <div class="span2">&nbsp;</div>
                                <div class="span9">
                                    <input type="submit" class="button span12 bg-green fg-white" value="Login" />
                                </div>
                            </div>
                            End Using
                </div>
            </div>
        Else
                @<div Class="panel">
                    <div Class="panel-header bg-lightBlue fg-white">Trust Login</div>
                    <div Class="panel-content">
                        <div> Please enter your Trust account details below And click login (Or hit enter) To Continue.</div>
                        <br />
                                @Using Html.BeginForm("Login", "Account")
                                @<div class="row">
                                    <div class="span2 text-right padding5">Username</div>
                                    <div class="span9">
                                        <div class="input-control text">
                                            @Html.TextBox("username", "", New With {.autocomplete = "off", .class = "username"})
                                        </div>
                                    </div>
                                </div>
                                @<div class="row">
                                    <div class="span2 text-right padding5">Password</div>
                                    <div class="span9">
                                        <div class="input-control text">
                                            @Html.Password("password", "", New With {.autocomplete = "off"})
                                        </div>
                                    </div>
                                </div>
                                @<div class="row">
                                    <div class="span2">&nbsp;</div>
                                    <div class="span9">
                                        <input type="submit" class="button span12 bg-green fg-white" value="Login" />
                                    </div>
                                </div>
                                End Using
                    </div>
                </div>
        End If
    </div>
    <div class="span3">&nbsp;</div>
</div>
<script>
    $(document).ready(function () {
        $('.username').focus();
    });
</script>
