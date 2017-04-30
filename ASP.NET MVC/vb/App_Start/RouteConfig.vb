Imports System.Web.Mvc
Imports System.Web.Routing

Public Module RouteConfig
    Public Sub RegisterRoutes(ByVal routes As RouteCollection)
        'routes.IgnoreRoute("")
        routes.IgnoreRoute("{resource}.axd/{*pathInfo}")

        routes.MapRoute(
         name:="Default",
         url:="{controller}/{action}/{id}",
         defaults:=New With {.controller = "Home", .action = "Index", .id = UrlParameter.Optional}
         )

        routes.MapRoute(name:="GeneratorByEncounter", url:="{controller}/{action}/{templateName}/{id}")
        routes.MapRoute(name:="GenerateByClinic", url:="{controller}/{action}/{templateName}/{clinicCode}/{clinicDate}/{sortOrder}")
    End Sub
End Module