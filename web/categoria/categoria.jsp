

<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Categorias</title>
    </head>
    <body >
        <script language="JavaScript" src="../js/validacao.js"></script>
        <%@include file="../menu.jsp" %>

        <%            Categoria tg = (Categoria) request.getAttribute("objetoCategoria");
            if (tg == null) {
                tg = new Categoria();

                tg.id = 0;
                tg.descricao = "";
            }
        %>

        <style>
            .search {
                justify-content: center;
                width: 30%;
                height: 48px;
            }
            
            button { 
                width: 30%;
            }

            form {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;

            }

            h1 {
                text-align: center;
                margin-bottom: 15px;
            }

            .table-responsive {
                width: 80%;
            }
        </style>
        <h1>Cadastro de Categorias</h1>

        <form name='formCateg' method='post' action='/WebMarket/Categoria?param=salvarCategoria' onsubmit="return validardados()">
            <input type="hidden" name="id" value="<%= tg.id%>">


            <input type="text" class="search" name="descricao" placeholder="Descrição" value="<%= tg.descricao%>">
            <br>

            <button type="submit" value="salvar" class="btn btn-lg btn-dark">Pesquisar</button>

            <br>
            <br>
            <br>
            <%@include file = "listagemCategoria.jsp" %>
        </form>
    </body>
</html>
