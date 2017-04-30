@ModelType Integer
<div class="panel">
    <div class="panel-header bg-lightBlue fg-white">Search By Hospital Number</div>
    <div class="panel-content">
        <div class="row">
            @Using Ajax.BeginForm("SearchByCRNResult", "Search", FormMethod.Post, New AjaxOptions With {.InsertionMode = InsertionMode.Replace, .HttpMethod = "POST", .UpdateTargetId = "search-results", .LoadingElementId = "loading", .OnBegin = "validateForm"})
                @<div class="span2 text-right padding5 no-wrap">Hospital Number</div>
                @<div class="span4">
                    <div class="input-control text">
                        @Html.TextBox("crn", "", New With {.autocomplete = "off", .class = "crn input-upper"})
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
        $('.crn').focus().focus();  //stupid IE8 need to call focus twice
    });

    function validateForm() {
        //Clear the previous search first
        $("#search-results").html("");

        if ($(".crn").val() == '')
        {
            alert("Please enter a CRN");
            return false;
        }

        return true;
    }
</script>