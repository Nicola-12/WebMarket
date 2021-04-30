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

            html, body {
                width: 100%;
                height: 100vh;
            }

            main {
                display: grid;
                grid-template-columns: 1fr;
                grid-template-rows: 1fr 1fr;
                place-items: center;
               
         
            }
            body {
                display: grid;

                align-items: center;

            }
            form {
                width: 70%;
                max-width: 700px;
            }

            label, input {
                width: 100%;
            }

            button {
                width: 100%;
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

        <main>
            <form method="post" enctype="multipart/form-data" action="/WebMarket/Produto?param=cadastroProduto">            

                <h1 class="h3 mb-3 fw-normal">Cadastro de Produto</h1>       

                <input type="hidden" name="id" value="<%= p.id%>">

                <label for="inputNome">Nome*
                    <input type="text" name="nome" class="form-control" autofocus required value="<%= p.nome%>"  > 
                </label>

                <label for="inputDescricao">Descrição do Produto*
                    <textarea class="form-control" name="descricao" placeholder="Descrição Detalhada do Produto*" type="text" required value="<%=p.descricao%>" ></textarea>
                </label>

                <label for="inputQuantidade">Quantidade*
                    <input type="text" name="estoque" class="form-control" placeholder="Quantidade*" pattern="\d|[1-9]\d+" title="Somente Valores Inteiros" required value="<%= p.estoque%>" >
                </label>

                <label for="inputValor" >Valor*
                    <input type="text" name="valor" pattern="\d+(?:.\d+)?" class="form-control" value="<%= p.valor%>" >
                </label>
                
                <label for="inputValor" >Valor*
                    <input type="file" >
                </label>

                <label for="inputCategoria" >Categoria do Produto*
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
                </label>
                <label>Ativo: <input type="checkbox" name="checkbox"></input></label>

                <button class="btn btn-lg btn-dark" type="submit" value="Salvar" >Cadastrar</button>

               
                <p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
            </form>

        </main>

    </body>
</html>
