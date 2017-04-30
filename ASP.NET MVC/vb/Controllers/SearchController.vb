Imports System.Web.Mvc
Imports NPoco

Namespace Controllers
    <Authorize>
    Public Class SearchController
        Inherits Controller

        ' GET: Search
        Function Index() As ActionResult
            Return View()
        End Function

        Function SearchByCRN(ByVal id As Integer) As ActionResult
            Return PartialView(id)
        End Function


        <HttpPost>
        Function SearchByCRNResult(ByVal crn As String, ByVal templateId As Integer) As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing
            Dim template As Dictionary(Of String, Object) = Nothing
            Dim query As Dictionary(Of String, Object) = Nothing

            'Get the template
            Using db As New Database("cnApplication")
                'Get the template details
                template = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetFormTemplateById] @0", templateId).FirstOrDefault()
                'Get the sql string for the search to pass to the PAS connectin below
                query = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetPASQueryByNameTemplateId] @0, @1", "SearchByCRN", templateId).FirstOrDefault()
            End Using

            'Connect to PAS and execute the query
            Using db As New Database("cnPAS")
                model = db.Fetch(Of Dictionary(Of String, Object))(query("SQL"), crn.Trim().ToUpper())
            End Using

            Return PartialView("_SearchResults", New With {.results = model, .template = template})
        End Function


        Function SearchByNHS(ByVal id As Integer) As ActionResult
            Return PartialView(id)
        End Function

        <HttpPost>
        Function SearchByNHSNumberResult(ByVal nhsNumber As String, ByVal templateId As Integer) As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing
            Dim template As Dictionary(Of String, Object) = Nothing
            Dim query As Dictionary(Of String, Object) = Nothing

            'Get the template
            Using db As New Database("cnApplication")
                'Get the template details
                template = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetFormTemplateById] @0", templateId).FirstOrDefault()
                'Get the sql string for the search to pass to the PAS connection below
                query = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetPASQueryByNameTemplateId] @0, @1", "SearchByNHSNumber", templateId).FirstOrDefault()
            End Using

            'Connect to PAS and execute the query
            Using db As New Database("cnPAS")
                model = db.Fetch(Of Dictionary(Of String, Object))(query("SQL"), nhsNumber.Trim())
            End Using

            Return PartialView("_SearchResults", New With {.results = model, .template = template})
        End Function

        Function SearchByPathway(ByVal id As Integer) As ActionResult
            Return PartialView(id)
        End Function


        <HttpPost>
        Function SearchByPathwayResult(ByVal pathway As String, ByVal templateId As Integer) As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing
            Dim template As Dictionary(Of String, Object) = Nothing
            Dim query As Dictionary(Of String, Object) = Nothing

            'Get the template
            Using db As New Database("cnApplication")
                'Get the template details
                template = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetFormTemplateById] @0", templateId).FirstOrDefault()
                'Get the sql string for the search to pass to the PAS connection below
                query = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetPASQueryByNameTemplateId] @0, @1", "SearchByPathway", templateId).FirstOrDefault()
            End Using

            'Connect to PAS and execute the query
            Using db As New Database("cnPAS")
                model = db.Fetch(Of Dictionary(Of String, Object))(query("SQL"), pathway.Trim().ToUpper())
            End Using

            Return PartialView("_SearchResults", New With {.results = model, .template = template})
        End Function


        Function SearchByClinic(ByVal id As Integer) As ActionResult
            Return PartialView(id)
        End Function


        <HttpPost>
        Function SearchByClinicResult(ByVal ClinicCode As String, ByVal ClinicDate As Date, ByVal SortOrder As String, ByVal templateId As Integer) As ActionResult
            Dim model As List(Of Dictionary(Of String, Object)) = Nothing
            Dim template As Dictionary(Of String, Object) = Nothing
            Dim query As Dictionary(Of String, Object) = Nothing

            'Get the template
            Using db As New Database("cnApplication")
                'Get the template details
                template = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetFormTemplateById] @0", templateId).FirstOrDefault()
                'Get the sql string for the search to pass to the PAS connection below
                query = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetPASQueryByNameTemplateId] @0, @1", "SearchByClinicCodeDate", templateId).FirstOrDefault()
            End Using
            template.Add("SortOrder", SortOrder)

            'Connect to PAS and execute the query
            Using db As New Database("cnPAS")
                Dim sql As String = query("SQL").ToString().Replace("@0", "'" + ClinicCode.Trim().ToUpper() + "'").Replace("@1", "'" + ClinicDate.ToString("yyyy-MM-dd") + "'").Replace("@2", SortOrder)
                model = db.Fetch(Of Dictionary(Of String, Object))(sql)
            End Using

            Return PartialView("_SearchResultsClinic", New With {.results = model, .template = template})
        End Function
    End Class
End Namespace