'/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details: 
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/

Public Class Dataset
    Sub New()
        _encounter = Nothing
        _ds1 = Nothing
        _ds2 = Nothing
        _ds3 = Nothing
        _ds4 = Nothing
        _ds5 = Nothing
        _ds6 = Nothing
        _ds7 = Nothing
        _ds8 = Nothing
        _ds9 = Nothing
        _ds10 = Nothing
    End Sub

    Private _encounter As Dictionary(Of String, Object)
    Public Property encounter As Dictionary(Of String, Object)
        Get
            Return _encounter
        End Get
        Set(ByVal value As Dictionary(Of String, Object))
            _encounter = value
        End Set
    End Property

    Private _ds1 As List(Of Dictionary(Of String, Object))
    Public Property ds1 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds1
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds1 = value
        End Set
    End Property

    Private _ds2 As List(Of Dictionary(Of String, Object))
    Public Property ds2 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds2
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds2 = value
        End Set
    End Property

    Private _ds3 As List(Of Dictionary(Of String, Object))
    Public Property ds3 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds3
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds3 = value
        End Set
    End Property

    Private _ds4 As List(Of Dictionary(Of String, Object))
    Public Property ds4 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds4
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds4 = value
        End Set
    End Property

    Private _ds5 As List(Of Dictionary(Of String, Object))
    Public Property ds5 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds5
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds5 = value
        End Set
    End Property

    Private _ds6 As List(Of Dictionary(Of String, Object))
    Public Property ds6 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds6
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds6 = value
        End Set
    End Property

    Private _ds7 As List(Of Dictionary(Of String, Object))
    Public Property ds7 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds7
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds7 = value
        End Set
    End Property

    Private _ds8 As List(Of Dictionary(Of String, Object))
    Public Property ds8 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds8
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds8 = value
        End Set
    End Property

    Private _ds9 As List(Of Dictionary(Of String, Object))
    Public Property ds9 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds9
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds9 = value
        End Set
    End Property

    Private _ds10 As List(Of Dictionary(Of String, Object))
    Public Property ds10 As List(Of Dictionary(Of String, Object))
        Get
            Return _ds10
        End Get
        Set(ByVal value As List(Of Dictionary(Of String, Object)))
            _ds10 = value
        End Set
    End Property
End Class
