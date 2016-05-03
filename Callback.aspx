<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Callback.aspx.cs" Inherits="Callback" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="refresh" content="10; url=http://www.polleymotorsport.co.uk"/>
    <link rel="stylesheet" href="/i/295654/style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <img alt="" src="/i/295654/PolleysportLogo.png"/>
    <div class="content_std">
    
    <h1>
            Thank you</h1>
            
            <p>Your order is now complete</p>
            <asp:Literal runat="server" id="TransMessage" Text="" />
            <p>For your reference the transaction ID for this order is . You will receive a confirmation email shortly.</p>
    </div>
    </form>
</body>
</html>
