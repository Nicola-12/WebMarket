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


        <title>Cadastro de Produto</title>
    </head>
    <body>
        <%@include file="../menu.jsp" %>

        <style>

            html, body {
                width: 100%;
                height: 100vh;
            }

            .mainProd {
                display: grid;
                grid-template-columns: 1fr;
                grid-template-rows: 1fr;
                place-items: center;
            }
            body {
                display: grid;
                align-items: center;

            }
            .prod {
                width: 70%;
                max-width: 700px;
            }

            label, input {
                width: 100%;
            }

            h1 {
                text-align: center;
            }

            .cadastro {
                width: 100%;
                margin-bottom: 2em;
            }

            a{
                text-decoration: none;
                align-self: center;
            }

            button:hover {
                transition: 2s;
                opacity: 0.8;
            }

            .checkBox {
                text-align: center;
                margin-bottom: 15px;
            }

            .Cheeck {
                width: 2%;
            }

            .inputt {
                margin-bottom: 1.5em;
            }

            .labell {
                padding: 5px;
            }

            .table-responsive {
                width: 90%;
            }

        </style>

        <main class="mainProd">
            <%                Produto prod = null;

                String id = request.getParameter("id");

                if (id != null) {
                    try {
                        prod = new ProdutoDao().consultarId(Integer.parseInt(id));
                    } catch (NumberFormatException e) {
                    }
                }
                if (prod == null) {
                    prod = new Produto();
                    prod.id = 0;
                    prod.nome = "";
                    prod.descricao = "";
                    prod.estoque = 0;
                    prod.id_categoria = 0;
                    prod.valor = 0.0;
                }
            %>

            <form method="post" class="prod" enctype="multipart/form-data" action="/WebMarket/uploadTest.jsp">            

                <h1 class="h3 mb-3 fw-normal">Cadastro de Produto</h1>       

                <input type="hidden" name="id" value="<%= prod.id%>">

                <label for="inputNome" class="labell">Nome*
                    <input type="text" name="nome" class="form-control inputt" autofocus required value="<%= prod.nome%>"  > 
                </label>

                <label for="inputDescricao" class="labell">Descrição do Produto*
                    <textarea class="form-control inputt" name="descricao" placeholder="Descrição Detalhada do Produto*" type="text" required><%=prod.descricao%></textarea>
                </label>

                <label for="inputQuantidade" class="labell">Quantidade*
                    <input type="text" name="estoque" class="form-control inputt" placeholder="Quantidade*" pattern="\d|[1-9]\d+" title="Somente Valores Inteiros" required value="<%= prod.estoque%>" >
                </label>

                <label for="inputValor" class="labell">Valor*
                    <input type="text" name="valor" pattern="\d+(?:.\d+)?" class="form-control inputt" value="<%= prod.valor%>" >
                </label>

                <input class="inputt" type="file" name="file" size="50" />

                <label for="inputCategoria" class="labell" >Categoria do Produto*
                    <select name="comboCategoria" class="form-select form-select-lg inputt" aria-label=".form-select-sm example">
                        <option value="0">Selecione</option>
                        <%
                            ArrayList<Categoria> categorias = new CategoriaDao().consultarTodos();

                            for (Categoria categ : categorias) {
                        %>

                        <option 
                            <%= prod.id_categoria == categ.id ? "selected" : ""%>
                            value="<%= categ.id%>"><%= categ.descricao%></option>
                        <%
                            }
                        %>
                    </select>
                </label>
                <label class="checkBox">Ativo:
                    <input  <%= prod.id != 0 && prod.ativo.equals("ativo") ? "checked" : "!"%>
                        type="checkbox" class="Cheeck" name="checkbox"></input></label>

                <button class="btn btn-lg btn-dark cadastro" type="submit" value="Salvar" >Cadastrar</button>

            </form>

            <%@include file="listagemProduto.jsp" %>

        </main>

    </body>
    <footer><p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p></footer>
</html>
