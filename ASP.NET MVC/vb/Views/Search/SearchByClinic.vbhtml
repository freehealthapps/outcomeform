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

<div class="panel">
    <div class="panel-header bg-lightBlue fg-white">Search By Clinic</div>
    <div class="panel-content">
        <div class="row">
            @Using Ajax.BeginForm("SearchByClinicResult", "Search", FormMethod.Post, New AjaxOptions With {.InsertionMode = InsertionMode.Replace, .HttpMethod = "POST", .UpdateTargetId = "search-results", .LoadingElementId = "loading"})
                @<div class="span1 text-right padding5">Code</div>
                @<div class="span2">
                    <div class="input-control text">
                        @Html.TextBox("ClinicCode", "", New With {.autocomplete = "off", .class = "clinicCode input-upper"})
                    </div>
                </div>
                @<div class="span1 text-right padding5">Date</div>
                @<div class="span2">
                    <div class="input-control text">
                        @Html.TextBox("ClinicDate", "", New With {.autocomplete = "off", .class = "clinicDate input-upper"})
                    </div>
                </div>
                @<div class="span3">
                    <div class="input-control select">
                        <select id="SortOrder" name="SortOrder">
                            <option value="APPT_TIME">Sort by Appointment Date</option>
                            <option value="PATIENT_NAME">Sort by Patient Name</option>
                        </select>
                    </div>
                </div>
                @<div class="span3">
                     @Html.Hidden("templateId", Model)
                    <input type="submit" class="button primary span10" value="Search" />
                </div>
            End Using
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#ClinicCode').focus().focus(); //stupid IE8 need to call focus twice
        $('.clinicDate').inputmask("d/m/y", { "placeholder": "dd/mm/yyyy" });
    });

    function validateForm() {
        //Clear the previous search first
        $("#search-results").html("");

        if ($(".clinicCode").val() == '')
        {
            alert("Please enter a Clinic Code");
            return false;
        }

        if ($(".clinicDate").val() == '') {
            alert("Please enter a Clinic Date");
            return false;
        }

        return true;
    }
</script>