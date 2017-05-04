'/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details: 
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/

Imports System.Web.Mvc

Namespace Controllers
    Public Class ErrorController
        Inherits Controller

        ' GET: Error
        Function Index(ByVal errorMessage As String, errorDescription As String) As ActionResult
            Return View(New With {.errorMessage = errorMessage, .errorDescription = errorDescription})
        End Function
    End Class
End Namespace