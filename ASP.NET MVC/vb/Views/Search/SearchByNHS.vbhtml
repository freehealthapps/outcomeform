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
    <div class="panel-header bg-lightBlue fg-white">Search By NHS Number</div>
    <div class="panel-content">
        <div class="row">
            @Using Ajax.BeginForm("SearchByNHSNumberResult", "Search", FormMethod.Post, New AjaxOptions With {.InsertionMode = InsertionMode.Replace, .HttpMethod = "POST", .UpdateTargetId = "search-results", .LoadingElementId = "loading", .OnBegin = "validateForm"})
                @<div class="span2 text-right padding5">NHS Number</div>
                @<div class="span4">
                    <div class="input-control text">
                        @Html.TextBox("nhsNumber", "", New With {.autocomplete = "off", .class = "nhsNumber"})
                        @Html.Hidden("templateId", Model)
                    </div>
                </div>
                @<div class="span4">
                    <input type="submit" class="button primary span10" value="Search" />
                </div>
            End Using
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('.nhsNumber').focus().focus(); //stupid IE8 need to call focus twice
    });

    function validateForm() {
        //Clear the previous search first
        $("#search-results").html("");

        if ($(".nhsNumber").val() == '')
        {
            alert("Please enter a NHS Number");
            return false;
        }

        return true;
    }
</script>