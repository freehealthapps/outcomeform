@ModelType List(Of Dictionary(Of String, Object))
@Code 
    ViewData("Title") = "Search"
End Code

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

<div class="row">
    <div class="span12">
        <div class="horizontal-menu">
            <ul>
                <li><a href="/" class="fg-darkGreen">Home</a></li>
                @For Each searchType In Model
                    @<li><a href="@searchType("SearchUrl")/@searchType("TemplateId")" class="fg-darkRed searchLink">[@searchType("SearchDescription")]</a></li>
                Next
            </ul>
        </div>
        <div id="searchForm"></div>
        <br /><br />
        <div id="loading" class="panel" style="display: none;">
            <div class="panel-header bg-amber fg-white">Searching please wait...</div>
        </div>
        <div id="search-results"></div>
    </div>
</div>
<script>
    $.ajaxSetup({ cache: false });
    $(document).ready(function () {
        //load first search option
        var url = '@Model.FirstOrDefault()("SearchUrl")/@Model.FirstOrDefault()("TemplateId")';
        populateSearchForm(url);

        $('.searchLink').click(function () {
            var url = $(this).attr('href');
            populateSearchForm(url);

            return false;
        });
    });

    function populateSearchForm(url)
    {
        $.get(url, function (result) {
            $('#searchForm').html(result);
        });
    }

</script>