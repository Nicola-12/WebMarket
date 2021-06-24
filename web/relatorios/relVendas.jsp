<%-- 
    Document   : relVendas
    Created on : 30 de mai de 2021, 10:20:32
    Author     : STI
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.Date"%>
<%@page import="dao.CompraDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            String dataIni = request.getParameter("dataInicial");
            String dataFinal = request.getParameter("dataFinal");

            Date v1 = dataIni == null || dataIni.isEmpty() ? null : Date.valueOf(dataIni);
            Date v2 = dataFinal == null || dataFinal.isEmpty() ? null : Date.valueOf(dataFinal);
            System.out.println(v1);
            System.out.println(v2);

            byte[] bytes = new CompraDao().gerarRelatorioData(v1, v2);

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
