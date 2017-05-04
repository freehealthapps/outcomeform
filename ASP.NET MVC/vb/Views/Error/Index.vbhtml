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