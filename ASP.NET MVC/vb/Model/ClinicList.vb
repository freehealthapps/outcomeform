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
