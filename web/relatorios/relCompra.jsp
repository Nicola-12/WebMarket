<%-- 
    Document   : relCompra
    Created on : 30 de mai. de 2021, 22:08:22
    Author     : Usuario
--%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.ProdutoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
    </head>
    <body>
        <%
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            
            String dataIni = request.getParameter("dataInicial");
            String dataFinal = request.getParameter("dataFinal");
            
            Date v1 = formatter.parse(dataIni);
            Date v2 = formatter.parse(dataFinal);
            System.out.println(v1);
            System.out.println(v2);
            byte[] bytes = new ProdutoDao().gerarRelatorioData(v1, v2);
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
