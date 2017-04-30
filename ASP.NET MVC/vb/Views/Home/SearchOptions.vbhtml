@ModelType List(Of Dictionary(Of String, Object))
@Code 
    ViewData("Title") = "Search"
End Code
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