'/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details: 
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/

Imports System.Web.Mvc
Imports NPoco

Namespace Controllers
    <Authorize>
    Public Class HomeController
        Inherits Controller

        Function Index() As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing

            Using db As New Database("cnApplication")
                model = db.Fetch(Of Dictionary(Of String, Object))("EXEC APP.uspFormGenerator_GetFormGroup")
            End Using

            Return View(model)
        End Function

        Function SearchOptions(ByVal id As Integer) As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing

            Using db As New Database("cnApplication")
                model = db.Fetch(Of Dictionary(Of String, Object))("EXEC APP.uspFormGenerator_GetFormSearchByGroupId @0", id)
            End Using

            Return View(model)
        End Function
    End Class
End Namespace