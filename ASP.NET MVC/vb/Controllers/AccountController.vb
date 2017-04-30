Imports System.Web.Mvc
Imports System.DirectoryServices.AccountManagement

Namespace Controllers
    Public Class AccountController
        Inherits Controller

        Function Index(ByVal message As String) As ActionResult
            Dim demo As Boolean = ConfigurationManager.AppSettings("EnableDemo")
            Dim lm As LoginModel = New LoginModel() With {.Demo = demo, .Message = message}
            Return View("Index", Nothing, lm)
        End Function

        Function RedirectToLogin() As ActionResult
            Dim demo As Boolean = ConfigurationManager.AppSettings("EnableDemo")
            Dim lm As LoginModel = New LoginModel() With {.Demo = demo}
            Return PartialView("_RedirectToLogin", lm)
        End Function

        Function Login(ByVal username As String, ByVal password As String, ByVal returnUrl As String) As ActionResult
            Dim demo As Boolean = ConfigurationManager.AppSettings("EnableDemo")
            If demo Then
                Dim demoUser As String = ConfigurationManager.AppSettings("DemoUser")
                Dim demoPassword As String = ConfigurationManager.AppSettings("DemoPassword")
                If demoUser = username And demoPassword = password Then
                    FormsAuthentication.SetAuthCookie(demoUser, False)
                    Return Redirect("/home")
                Else
                    Return RedirectToAction("Index", "Account", New With {.message = "The username or password is incorrect.  Please check and try again."})
                End If
            Else
                Dim authType As ContextType = ContextType.Domain
                Dim domain As String = ConfigurationManager.AppSettings("Domain")
                Dim container As String = ConfigurationManager.AppSettings("DomainContainer")
                Dim group As String = ConfigurationManager.AppSettings("DomainGroup")
                Dim msgAccessDenied As String = ConfigurationManager.AppSettings("msgAccessDenied")
                Dim msgInvalidCredentials As String = ConfigurationManager.AppSettings("msgInvalidCredentials")

                Using ctx As New PrincipalContext(authType, domain, container)
                    If (ctx.ValidateCredentials(username, password)) Then
                        Dim upUser As UserPrincipal = UserPrincipal.FindByIdentity(ctx, username)
                        If (upUser IsNot Nothing) Then
                            Try
                                If (upUser.IsMemberOf(ctx, IdentityType.SamAccountName, group)) Then
                                    FormsAuthentication.SetAuthCookie(upUser.Surname.ToUpper + ", " + upUser.GivenName, False)
                                    Return Redirect("/home")
                                Else
                                    Return RedirectToAction("Index", "Account", New With {.message = msgAccessDenied})
                                End If
                            Catch ex As Exception
                                Return RedirectToAction("Index", "Account", New With {.message = msgAccessDenied})
                            End Try
                        Else
                            Return RedirectToAction("Index", "Account", New With {.message = msgAccessDenied})
                        End If
                    Else
                        Return RedirectToAction("Index", "Account", New With {.message = msgInvalidCredentials})
                    End If
                End Using
            End If
        End Function

        Sub Logout()
            If User.Identity.IsAuthenticated Then
                FormsAuthentication.SignOut()
                FormsAuthentication.RedirectToLoginPage()
            End If
        End Sub
    End Class
End Namespace