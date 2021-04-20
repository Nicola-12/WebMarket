

<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script language="JavaScript" src="../js/validacao.js"></script>
        <%@include file="../menu.jsp" %>

        <%            Categoria tg = (Categoria) request.getAttribute("objetoCategoria");
            if (tg == null) {
                tg = new Categoria();

                tg.id = 0;
                tg.descricao = "";
            }
        %>

        <h1>Cadastro de Categorias</h1>

        <form style="padding: 20px" name='formCateg' method='post' action='/WebMarket/Categoria?param=salvarCategoria' onsubmit="return validardados()">
            <input type="hidden" name="id" value="<%= tg.id%>">


            <input type="text" name="descricao" placeholder="Descrição" value="<%= tg.descricao%>">
            <br>

            <input type="submit" value="salvar">

            <br>
            <br>
            <br>
            <%@include file = "listagemCategoria.jsp" %>
        </form>
    </body>
</html>
