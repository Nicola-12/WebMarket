<%-- 
    Document   : checkout
    Created on : 7 de jun. de 2021, 19:20:34
    Author     : Usuario
--%>

<%@page import="dao.PessoaDao"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@page import="entidade.Compra"%>
<%@page import="dao.CompraDao"%>
<%@page import="entidade.Pessoa"%>
<%@page import="entidade.ItemCarrinho"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%@include file="../menu.jsp" %>

    <style>
        body {
            width: 100%;
            height: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
        }

        .nav {
            width: 100%;
        }

        table {
            width: 90%;
            height: 100%;
        }
    </style>

    <body>
        <%            ProdutoDao pdao = new ProdutoDao();
            ArrayList<ItemCarrinho> items = (ArrayList<ItemCarrinho>) request.getAttribute("itens");
            Compra compra = (Compra) request.getAttribute("compra");
            Pessoa pess = (Pessoa) sessao.getAttribute("usuarioLogado");
            pess = new PessoaDao().consultarEmail(pess.email);
        %>

        <h1>Obrigado Por Comprar, <%=pess.nome%>!</h1>

        <table class="table table-bordered table-sm table-dark">
            <tr>
                <th></th>
                <th>Produto</th>
                <th>Quantidade</th>
                <th>Preço</th>
                <th>Parcelas</th>
            </tr>
            <% for (int iten = 0; iten < items.size(); iten++) {
                    ItemCarrinho i = items.get(iten);
                    Produto p = pdao.consultarId(i.id_produto);
            %>
            <tr class="table-light">
                <td><img src="http://localhost:7777/images/<%= p.file%>" /> </td>
                <td><%= p.nome%></td>
                <td><%= i.quant%></td>
                <td><%= p.valor%></td>
                <td><%= compra.parcelas%></td>
            </tr>
            <% }%>
        </table>

    </body>
</html>
