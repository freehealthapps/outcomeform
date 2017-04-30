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