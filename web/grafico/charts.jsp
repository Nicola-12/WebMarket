<%-- 
    Document   : charts
    Created on : 29 de mai de 2021, 22:31:49
    Author     : STI
--%>

<%@page import="managers.ChartManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            out.println("<script>console.log(JSON.parse('" + ChartManager.jsonVendasSemana() + "'))</script>");
        %>
    </body>
</html>
