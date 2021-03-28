<%-- 
    Document   : index
    Created on : 15 de mar. de 2021, 19:26:47
    Author     : Usuario
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <% 
        String dataAtual = String.valueOf(new Date());
        int x = 10;
        System.out.println("X : "+ x);
        %>
    </body>
</html>
