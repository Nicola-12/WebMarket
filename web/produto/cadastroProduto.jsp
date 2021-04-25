<%-- 
    Document   : cadastroProduto
    Created on : 19 de abr. de 2021, 19:55:58
    Author     : Usuario
--%>

<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">

        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
        <link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
        <link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
        <meta name="theme-color" content="#7952b3">


        <title>Produto</title>
    </head>
    <body>

        <style>
            form {
                margin: 5px;
            }

            input, textarea, select, button {
                margin-top: 15px;
            }

        </style>

        <%
            Produto p = (Produto) request.getAttribute("objetoProduto");
            if (p == null) {
                p = new Produto();

                p.id = 0;
                p.nome = "";
                p.descricao = "";
                p.estoque = 0;
                p.id_categoria = 0;
                p.valor = 0.0;
            }
        %>

        <main class="form-signin">
            <form method="post" action="/WebMarket/Produto?param=cadastroProduto">            

                <h1 class="h3 mb-3 fw-normal">Cadastro de Produto</h1>       

                <input type="hidden" name="id" value="<%= p.id%>">

                <label for="inputNome" class="visually-hidden">Nome</label>
                <input type="text" name="nome" class="form-control" autofocus required value="<%= p.nome%>"  > 

                <label for="inputEndereco" class="visually-hidden">Descrição do Produto</label>
                <textarea class="form-control" name="descricao" type="text" required value="<%=p.descricao%>" ></textarea>

                <label for="inputEmail" class="visually-hidden">Quantidade</label>
                <input type="text" name="estoque" class="form-control" pattern="\d|[1-9]\d+" title="Somente Valores Inteiros" required value="<%= p.estoque%>">

                <label for="inputEndereco" class="visually-hidden">Valor</label>
                <input type="text" name="valor" pattern="\d+(?:.\d+)?" class="form-control" value="<%= p.valor%>" >

                <label for="inputEndereco" class="visually-hidden">Categoria do Produto</label>
                <select name="comboCategoria" class="form-select form-select-lg" aria-label=".form-select-sm example">
                    <option value="0">Selecione</option>
                    <%
                        ArrayList<Categoria> categorias = new CategoriaDao().consultarTodos();

                        for (int i = 0; i < categorias.size(); i++) {
                    %>

                    <option value="<%= categorias.get(i).id%>"><%= categorias.get(i).descricao%></option>
                    <%
                        }
                    %>
                </select>
                <label>Ativo: <input type="checkbox" name="checkbox"></input></label>

                <button class="w-100 btn btn-lg btn-dark" type="submit" value="Salvar" >Cadastrar</button>

                <p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
            </form>
        </main>

    </body>
</html>
