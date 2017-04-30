Imports System.Web.Mvc
Imports NPoco
Imports Pechkin
Imports Pechkin.Synchronized

Namespace Controllers
    Public Class PDFController
        Inherits Controller

        ''' <summary>
        '''  Generates a template that does not require populating with details from PAS
        ''' </summary>
        ''' <param name="id">The name of the template</param>
        ''' <returns></returns>
        Function Generate(id As String)
            Try
                Dim doc As Dictionary(Of String, Object) = Nothing
                Dim template As String = ""
                Dim serverUrl As String = Web.HttpContext.Current.Request.Url.Scheme + "://" + Web.HttpContext.Current.Request.Url.Authority

                'Get the template settings
                Using db As New Database("cnApplication")
                    doc = db.Fetch(Of Dictionary(Of String, Object))("EXEC " + ConfigurationManager.AppSettings("docGeneratorSP") + " @0", id).FirstOrDefault()
                End Using

                'Load partials
                If doc IsNot Nothing Then
                    'Load the template html into a string
                    template = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPath") + "/" + id + ".html"))

                    'Loop through the template to see if there are any partials defined using {{_<partialName>}} syntax
                    For Each partialTemplateName As Match In Regex.Matches(template, "{{_(?<partial>.*?)\}}")
                        'Load the partial template html into a string
                        Dim partialTemplate = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPartialPath") + "/" + partialTemplateName.Groups("partial").Value + ".html"))
                        'Replace the partial variable in the template string with the partial html
                        template = template.Replace("{{_" + partialTemplateName.Groups("partial").Value + "}}", partialTemplate)
                    Next

                    'Open the datawarehouse connection
                    Using db As New Database("cnDatawarehouse")
                        'Define datasets that will be passed to Nustache when rendering the template
                        Dim ds1 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds2 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds3 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds4 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds5 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds6 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds7 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds8 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds9 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds10 As List(Of Dictionary(Of String, Object)) = Nothing

                        'Call the stored procedures defined in the FormGeneratorTemplate table
                        If IsNothing(doc.Item("StoredProcedure1")) = False Then ds1 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure1"))
                        If IsNothing(doc.Item("StoredProcedure2")) = False Then ds2 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure2"))
                        If IsNothing(doc.Item("StoredProcedure3")) = False Then ds3 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure3"))
                        If IsNothing(doc.Item("StoredProcedure4")) = False Then ds4 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure4"))
                        If IsNothing(doc.Item("StoredProcedure5")) = False Then ds5 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure5"))
                        If IsNothing(doc.Item("StoredProcedure6")) = False Then ds6 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure6"))
                        If IsNothing(doc.Item("StoredProcedure7")) = False Then ds7 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure7"))
                        If IsNothing(doc.Item("StoredProcedure8")) = False Then ds8 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure8"))
                        If IsNothing(doc.Item("StoredProcedure9")) = False Then ds9 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure9"))
                        If IsNothing(doc.Item("StoredProcedure10")) = False Then ds10 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure10"))

                        'Render the html template replacing mustache variables with values from the dataset
                        Dim rendered = Nustache.Core.Render.StringToString(template, New With {.ServerUrl = serverUrl, .ds1 = ds1, .ds2 = ds2, .ds3 = ds3, .ds4 = ds4, .ds5 = ds5, .ds6 = ds6, .ds7 = ds7, .ds8 = ds8, .ds9 = ds9, .ds10 = ds10})

                        'Call the generate PDF function
                        Return GeneratePDF(rendered)
                    End Using
                Else
                    Throw New Exception("Template not found - ." + id)
                End If
            Catch ex As Exception
                'If there is an error display the Error view to the user
                Return RedirectToAction("Index", "Error", New With {.errorMessage = "An error occured generating the form", .errorDescription = ex.Message})
            End Try
        End Function

        ''' <summary>
        '''     Generates a template using the appoinment id as the identifier, PatientId and PathwayId are retieved and passed to the stored procedures
        ''' </summary>
        ''' <param name="templateName">Name of the template to render</param>
        ''' <param name="id">Appointment Id to retrieve</param>
        ''' <returns></returns>
        Function GenerateByAppointmentId(templateName As String, id As Integer)
            Try
                Dim encounter As Dictionary(Of String, Object) = Nothing
                Dim doc As Dictionary(Of String, Object) = Nothing
                Dim template As String = ""
                Dim serverUrl As String = Web.HttpContext.Current.Request.Url.Scheme + "://" + Web.HttpContext.Current.Request.Url.Authority

                'Get the template settings
                Using db As New Database("cnApplication")
                    doc = db.Fetch(Of Dictionary(Of String, Object))("EXEC " + ConfigurationManager.AppSettings("docGeneratorSP") + " @0", templateName).FirstOrDefault()
                End Using

                'Load partials
                If doc IsNot Nothing Then
                    'Get the appointment from PAS
                    Using db As New Database("cnPAS")
                        encounter = db.Fetch(Of Dictionary(Of String, Object))(doc("SQL"), id).SingleOrDefault()
                    End Using

                    'Load the template html into a string
                    template = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPath") + "/" + templateName + ".html"))

                    'Loop through the template to see if there are any partials defined using {{_<partialName>}} syntax
                    For Each partialTemplateName As Match In Regex.Matches(template, "{{_(?<partial>.*?)\}}")
                        'Load the partial template html into a string
                        Dim partialTemplate = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPartialPath") + "/" + partialTemplateName.Groups("partial").Value + ".html"))
                        'Replace the partial variable in the template string with the partial html
                        template = template.Replace("{{_" + partialTemplateName.Groups("partial").Value + "}}", partialTemplate)
                    Next

                    'Open the datawarehouse connection
                    Using db As New Database("cnDatawarehouse")
                        'Define datasets that will be passed to Nustache when rendering the template
                        Dim ds1 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds2 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds3 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds4 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds5 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds6 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds7 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds8 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds9 As List(Of Dictionary(Of String, Object)) = Nothing
                        Dim ds10 As List(Of Dictionary(Of String, Object)) = Nothing

                        'Call the stored procedures defined in the FormGeneratorTemplate table
                        If IsNothing(doc.Item("StoredProcedure1")) = False Then ds1 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure1") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure2")) = False Then ds2 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure2") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure3")) = False Then ds3 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure3") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure4")) = False Then ds4 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure4") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure5")) = False Then ds5 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure5") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure6")) = False Then ds6 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure6") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure7")) = False Then ds7 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure7") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure8")) = False Then ds8 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure8") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure9")) = False Then ds9 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure9") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure10")) = False Then ds10 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure10") & " @0, @1, @2", encounter.Item("PATIENT_ID"), encounter.Item("PATHWAY_ID"), encounter.Item("APPOINTMENT_ID"))

                        'Render the html template replacing mustache variables with values from the dataset
                        Dim rendered = Nustache.Core.Render.StringToString(template, New With {.ServerUrl = serverUrl, .encounter = encounter, .ds1 = ds1, .ds2 = ds2, .ds3 = ds3, .ds4 = ds4, .ds5 = ds5, .ds6 = ds6, .ds7 = ds7, .ds8 = ds8, .ds9 = ds9, .ds10 = ds10})

                        'Call the generate PDF function
                        Return GeneratePDF(rendered)
                    End Using
                Else
                    Throw New Exception("Template not found - ." + templateName)
                End If
            Catch ex As Exception
                'If there is an error display the Error view to the user
                Return RedirectToAction("Index", "Error", New With {.errorMessage = "An error occured generating the form", .errorDescription = ex.Message})
            End Try
        End Function

        Function GenerateByClinicCodeClinicDate(templateName As String, ClinicCode As String, ClinicDate As Date, ByVal SortOrder As String)
            Try
                Dim clinicList As List(Of Dictionary(Of String, Object)) = Nothing
                Dim query As Dictionary(Of String, Object) = Nothing

                Using db As New Database("cnApplication")
                    query = db.Fetch(Of Dictionary(Of String, Object))("EXEC [APP].[uspFormGenerator_GetPASQueryByName] @0", "SearchByClinicCodeDate").FirstOrDefault()
                End Using

                'Connect to PAS and execute the query
                Using db As New Database("cnPAS")
                    Dim sql As String = query("SQL").ToString().Replace("@0", "'" + ClinicCode.Trim().ToUpper() + "'").Replace("@1", "'" + ClinicDate.ToString("yyyy-MM-dd") + "'").Replace("@2", SortOrder)
                    clinicList = db.Fetch(Of Dictionary(Of String, Object))(sql)
                End Using

                Dim doc As Dictionary(Of String, Object) = Nothing
                Dim template As String = ""
                Dim serverUrl As String = Web.HttpContext.Current.Request.Url.Scheme + "://" + Web.HttpContext.Current.Request.Url.Authority

                'Get the template settings
                Using db As New Database("cnApplication")
                    doc = db.Fetch(Of Dictionary(Of String, Object))("EXEC " + ConfigurationManager.AppSettings("docGeneratorAllSP") + " @0", templateName).FirstOrDefault()
                End Using

                'Load partials
                If doc IsNot Nothing Then
                    'Load the template html into a string
                    template = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPath") + "/" + templateName + ".html"))

                    'Loop through the template to see if there are any partials defined using {{_<partialName>}} syntax
                    For Each partialTemplateName As Match In Regex.Matches(template, "{{_(?<partial>.*?)\}}")
                        'Load the partial template html into a string
                        Dim partialTemplate = IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings("TemplatesPartialPath") + "/" + partialTemplateName.Groups("partial").Value + ".html"))
                        'Replace the partial variable in the template string with the partial html
                        template = template.Replace("{{_" + partialTemplateName.Groups("partial").Value + "}}", partialTemplate)
                    Next
                Else
                    Throw New Exception("Template not found - ." + templateName)
                End If

                Dim lstClinicList As New List(Of ClinicList)
                For Each ptt In clinicList
                    Dim cl = New ClinicList()

                    'Get the appointment from PAS
                    Using db As New Database("cnPAS")
                        cl.Dataset.encounter = db.Fetch(Of Dictionary(Of String, Object))(doc("SQL"), ptt("APPOINTMENT_ID")).SingleOrDefault()
                    End Using

                    'Open the datawarehouse connection
                    Using db As New Database("cnDatawarehouse")
                        'Call the stored procedures defined in the FormGeneratorTemplate table
                        If IsNothing(doc.Item("StoredProcedure1")) = False Then cl.Dataset.ds1 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure1") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure2")) = False Then cl.Dataset.ds2 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure2") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure3")) = False Then cl.Dataset.ds3 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure3") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure4")) = False Then cl.Dataset.ds4 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure4") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure5")) = False Then cl.Dataset.ds5 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure5") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure6")) = False Then cl.Dataset.ds6 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure6") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure7")) = False Then cl.Dataset.ds7 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure7") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure8")) = False Then cl.Dataset.ds8 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure8") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure9")) = False Then cl.Dataset.ds9 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure9") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                        If IsNothing(doc.Item("StoredProcedure10")) = False Then cl.Dataset.ds10 = db.Fetch(Of Dictionary(Of String, Object))("EXEC " & doc.Item("StoredProcedure10") & " @0, @1, @2", cl.Dataset.encounter("PATIENT_ID"), cl.Dataset.encounter("PATHWAY_ID"), cl.Dataset.encounter("APPOINTMENT_ID"))
                    End Using

                    lstClinicList.Add(cl)
                Next

                'Render the html template replacing mustache variables with values from the dataset
                Dim rendered = Nustache.Core.Render.StringToString(template, New With {.ServerUrl = serverUrl, .cl = lstClinicList})

                'Call the generate PDF function
                Return GeneratePDF(rendered)
            Catch ex As Exception
                'If there is an error display the Error view to the user
                Return RedirectToAction("Index", "Error", New With {.errorMessage = "An error occured generating the form", .errorDescription = ex.Message})
            End Try
        End Function

        Private Function GeneratePDF(html As String)
            Dim pdfZoomFactor As Decimal = ConfigurationManager.AppSettings("PDFZoomFactor")

            Dim oc = New ObjectConfig()
            oc.SetPrintBackground(True)
            oc.SetScreenMediaType(True)

            'Set page size margins etc. in the html
            Dim gc = New GlobalConfig()
            gc.SetMargins(0, 0, 0, 0)
            gc.SetPaperOrientation(False)
            gc.SetPaperSize(Drawing.Printing.PaperKind.A4)
            oc.SetIntelligentShrinking(False) 'Disable to use actual mesurments (not sure if it's working)

            oc.SetZoomFactor(pdfZoomFactor) 'Pechkin renders a webkit browser in the background the page size will render differently dependant on the resolution and dpi on the server, can be adjusted in web.config if required.

            Dim pdf = New SynchronizedPechkin(gc).Convert(oc, html)
            Return File(pdf, "application/pdf")
        End Function
    End Class
End Namespace