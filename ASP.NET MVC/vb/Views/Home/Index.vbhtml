@ModelType List(Of Dictionary(Of String, Object))
@Code
    ViewData("Title") = "Select Document"
    Dim newRow As Boolean = True
End Code

    @For Each doc In Model
        If newRow Then
            @Html.Raw("<div Class=""row"">")
        End If

        @<div Class="span6">
            <div Class="panel panel-button document-button" data-id="@doc("Id")" data-template-name="@doc("DefaultTemplateName")" data-show-search="@doc("ShowSearch")">
                <div Class="panel-header @doc("CssClass")"><a href="/Home/SearchOptions/@doc("Id")" class="fg-white">@doc("Name")</a></div>
                <div class="panel-content">
                    <div class="row">
                        @If doc("ImageUrl") IsNot Nothing Then
                            @<img src="@doc("ImageUrl")" class="span4" />
                        End If
                        <div class="span8">
                            @Html.Raw(doc("Description"))
                        </div>
                    </div>
                </div>
            </div>
        </div>

        If newRow = False Then
            @Html.Raw("</div><br/><br/>")
            newRow = True
        Else
            newRow = False
        End If

    Next

<script>
    $(document).ready(function () {
        $('.panel-button').click(function (e) {
            e.preventDefault();
            var ctrl = $(this);
            if (ctrl.attr("data-show-search") == 1)
                window.location.href = "/Home/SearchOptions/" + ctrl.attr("data-id");
            else {
                window.open('/PDF/Generate/' + ctrl.attr("data-template-name"), '_blank');
            }
        });
    });
</script>
