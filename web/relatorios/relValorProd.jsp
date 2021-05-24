<%-- 
    Document   : relValorProd
    Created on : 23 de mai de 2021, 18:56:12
    Author     : STI
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="dao.ProdutoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Relatório de Valor</title>
    </head>
    <body>
        <%
            String valorIni = request.getParameter("valorIni");
            String valorFinal = request.getParameter("valorFinal");

            Double v1 = null;
            Double v2 = null;
     
            if (valorIni.length() != 0) {
                v1 = Double.parseDouble(valorIni);
            }
            if (valorFinal.length() != 0) {
                v2 = Double.parseDouble(valorFinal);
            }
            byte[] bytes = new ProdutoDao().gerarRelatorioValor(v1, v2);

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
