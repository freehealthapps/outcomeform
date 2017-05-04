'/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details: 
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/
Public Class ClinicList
    Sub New()
        _ds = New Dataset()
    End Sub

    Private _ds As Dataset
    Public Property Dataset() As Dataset
        Get
            Return _ds
        End Get
        Set(ByVal value As Dataset)
            _ds = value
        End Set
    End Property
End Class
