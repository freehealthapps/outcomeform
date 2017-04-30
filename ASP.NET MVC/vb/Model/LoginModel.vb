Public Class LoginModel
    Private _message As String
    Private _demo As Boolean
    Public Property Message() As String
        Get
            Return _message
        End Get
        Set(ByVal value As String)
            _message = value
        End Set
    End Property

    Public Property Demo() As Boolean
        Get
            Return _demo
        End Get
        Set(ByVal value As Boolean)
            _demo = value
        End Set
    End Property
End Class
