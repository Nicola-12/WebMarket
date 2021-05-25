<%-- 
    Document   : listaUsuarios
    Created on : 21 de mai. de 2021, 08:12:56
    Author     : Usuario
--%>

<%@page import="dao.PessoaDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Usuários</title>
    </head>
    <body>
        <%
            String ativo = request.getParameter("ativo");
            if ("todos".equals(ativo)) {
                ativo = null;
            }
            byte[] bytes = new PessoaDao().gerarRelatorio(ativo);
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
