@Code
    ViewData("Title") = "Error"
End Code
<div class="panel">
    <div class="panel-header bg-red fg-white">An error has occured</div>
    <div class="panel-content">
        <div class="row">
            <h2>@Model.errorMessage</h2>
            <p>@Model.errorDescription</p>
            <p><a href="#" id="btnClose">Close</a></p>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#btnClose').click(function () {
            window.close();

            return false;
        });
    });
</script>