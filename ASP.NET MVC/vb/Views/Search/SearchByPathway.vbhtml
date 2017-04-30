@ModelType Integer
<div class="panel">
    <div class="panel-header bg-lightBlue fg-white">Search By Pathway Number</div>
    <div class="panel-content">
        <div class="row">
            @Using Ajax.BeginForm("SearchByPathwayResult", "Search", FormMethod.Post, New AjaxOptions With {.InsertionMode = InsertionMode.Replace, .HttpMethod = "POST", .UpdateTargetId = "search-results", .LoadingElementId = "loading", .OnBegin = "validateForm"})
                @<div class="span2 text-right padding5 no-wrap">Pathway Number</div>
                @<div class="span4">
                    <div class="input-control text">
                        @Html.TextBox("pathway", "", New With {.autocomplete = "off", .class = "pathway input-upper"})
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
        $('.pathway').focus().focus(); //stupid IE8 need to call focus twice
    });

    function validateForm() {
        //Clear the previous search first
        $("#search-results").html("");

        if ($(".pathway").val() == '')
        {
            alert("Please enter a Pathway Number");
            return false;
        }

        return true;
    }
</script>