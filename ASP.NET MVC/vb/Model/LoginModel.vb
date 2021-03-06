﻿'/********************************************************************************************************/
'  Original Copyright Matt Cutting & Matthew Bishop 2017
'  Contact for more details: 
'  Matt Cutting: 	matt@responsivehealth.co.uk
'  Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
'  See https://github.com/freehealthapps/outcomeform
'  Or www.freehealthapps.org for more details, the latest version, and the license agreement
'/********************************************************************************************************/
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
