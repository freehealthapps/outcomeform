@If Model.results.Count <> 0 Then
    @<div Class="panel">
        <div Class="panel-header bg-green fg-white">Search Results</div>
        <div Class="panel-content">
            <table class="table">
                <tr>
                    <td>
                        Clinic<br />
                        @If Model.results(0).ContainsKey("CLINIC_DESCRIPTION") Then
                            @<b>@Model.results(0)("CLINIC_DESCRIPTION")</b>
                        End If
                    </td>
                    <td>
                        Clinician<br/>
                        @If Model.results(0).ContainsKey("CONSULTANT_NAME") Then
                            @<b>@Model.results(0)("CONSULTANT_NAME")</b>
                        End If
                    </td>
                    <td>
                        Specialty<br />
                        @If Model.results(0).ContainsKey("SPECIALTY_DESCRIPTION") Then
                            @<b>@Model.results(0)("SPECIALTY_DESCRIPTION")</b>
                        End If
                    </td>
                    <td>
                        Clinic Date<br />
                        @If Model.results(0).ContainsKey("APPT_DATE") Then
                            @<b>@Model.results(0)("APPT_DATE")</b>
                        End If
                    </td>
                    <td>
                        <a href="/@Model.template("AllGeneratorUrl")/@Model.template("AllTemplateName")/@Model.results(0)("CLINIC_CODE")/@Model.results(0)("APPT_DATE")/@Model.template("SortOrder")/" target="_blank">Print All</a>
                    </td>
                </tr>
            </table>
            <table class="table">
                <tr>
                    <td class="no-wrap"><b>Patient Name</b></td>
                    <td class="no-wrap"><b>Date of Birth</b></td>
                    <td class="no-wrap"><b>NHS Number</b></td>
                    <td class="no-wrap"><b>Appt Time</b></td>
                    <td>&nbsp;</td>
                </tr>
                @For Each item In Model.results
                @<tr>
                    <td class="no-wrap">
                        @If item.ContainsKey("PATIENT_NAME") Then
                            @item("PATIENT_NAME")
                        End If
                    </td>
                    <td>
                        @If item.ContainsKey("DATE_OF_BIRTH") Then
                            @item("DATE_OF_BIRTH")
                        End If
                    </td>
                    <td class="no-wrap">
                        @If item.ContainsKey("NHS_NUMBER") Then
                            @item("NHS_NUMBER")
                        End If
                    </td>
                    <td class="no-wrap">
                        @If item.ContainsKey("APPT_TIME") Then
                            @item("APPT_TIME")
                        End If
                    </td>
                    <td style="vertical-align: middle;">
                        @If item.ContainsKey("APPOINTMENT_ID") Then
                            @<a href="/@Model.template("GeneratorUrl")/@Model.template("TemplateName")/@item("APPOINTMENT_ID")" target="_blank">Print</a>
                        End If
                    </td>
                </tr>
                Next
            </table>
        </div>
    </div>
Else
    @<div class="panel">
        <div class="panel-header bg-red fg-white">
            No results found.  Please check and try again.
        </div>
    </div>
End If