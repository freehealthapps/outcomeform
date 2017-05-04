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

@If Model.results.Count <> 0 Then
    @<div Class="panel">
        <div Class="panel-header bg-green fg-white">Search Results</div>
        <div Class="panel-content">
            <table Class="table">
                <tr>
                    <td class="no-wrap"><b>Patient Name</b></td>
                    <td class="no-wrap"><b>NHS Number</b></td>
                    <td> <b> Clinic</b></td>
                    <td> <b> Specialty</b></td>
                    <td class="no-wrap"><b>Appt</b></td>
                    <td>&nbsp;</td>
                </tr>
                @For Each item In Model.results
                @<tr>
                    <td class="no-wrap">
                        @If item.ContainsKey("PATIENT_NAME") Then
                            @item("PATIENT_NAME")
                        End If
                        <br />
                        @If item.ContainsKey("DATE_OF_BIRTH") Then
                            @<span>DoB:</span> @item("DATE_OF_BIRTH")
                        End If
                    </td>
                    <td class="no-wrap">
                        @If item.ContainsKey("NHS_NUMBER") Then
                            @item("NHS_NUMBER")
                        End If
                    </td>
                    <td>
                        @If item.ContainsKey("CLINIC_DESCRIPTION") Then
                            @item("CLINIC_DESCRIPTION")
                        End If
                        <br />
                        @If item.ContainsKey("CONSULTANT_NAME") Then
                            @item("CONSULTANT_NAME")
                        End If
                    </td>
                    <td>
                        @If item.ContainsKey("SPECIALTY_DESCRIPTION") Then
                            @item("SPECIALTY_DESCRIPTION")
                        End If
                    </td>
                    <td class="no-wrap">
                        @If item.ContainsKey("APPT_DATE") Then
                            @item("APPT_DATE")
                        End If
                        <br />
                        @If item.ContainsKey("APPT_TIME") Then
                            @<span>Time:</span>@item("APPT_TIME")
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