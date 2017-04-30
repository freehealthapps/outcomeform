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