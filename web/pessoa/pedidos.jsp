<%-- 
    Document   : pedidos
    Created on : 21 de jun. de 2021, 21:38:11
    Author     : Usuario
--%>

<%@page import="apoio.Formatacao"%>
<%@page import="java.util.Date"%>
<%@page import="dao.PessoaDao"%>
<%@page import="apoio.ConexaoBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">
        <link href="/WebMarket/css/bootstrap.min.css.map">
        <title>Pedidos</title>
        <%@include file="../menu.jsp" %>
    </head>
    <body>
        <style>
            body {
                align-items: center;
                justify-content: center;
            }

            .pesquisar {
                display: flex;
                margin: auto;
                justify-content: center;
                width: 25%;
            }
            .pesq {
                margin: 10px;
                text-decoration: none;
            }
        </style>



        <%  String name = request.getParameter("nome");
            String dataIni = request.getParameter("data1");
            String dataFinal = request.getParameter("data2");

            if (dataIni == null || dataFinal == null) {
                dataIni = "10-10-1970";
                dataFinal = "10-10-2050";
            }
            if (name == null) {
                name = "";
            }
        %>


        <h1 style="text-align: center;">MEUS PEDIDOS FEITOS ATÉ O MOMENTO</h1>
        <a class="pesq" href="#"><button class="btn btn-dark pesquisar">pesquisa</button></a>
        <%            f = new PessoaDao().consultarEmail(f.email);

            ResultSet set = ConexaoBD.getInstance().getConnection().createStatement()
                    .executeQuery("SELECT "
                            + "categoria.descricao AS descricao,  "
                            + "produto.nome AS pNome,  "
                            + "iten.quant AS quant,  "
                            + "compra.created_at AS create,  "
                            + "iten.total "
                            + "FROM categoria,   "
                            + "produto,  "
                            + "itencarrinho AS iten,  "
                            + "carrinho,  "
                            + "pessoa,  "
                            + "compra   "
                            + "WHERE   "
                            + "(compra.created_at IS NULL "
                            + "OR compra.created_at BETWEEN '" + dataIni + "' AND '" + dataFinal + "') "
                            + "AND (produto.nome IS NULL OR produto.nome ILIKE '%" + name + "%') "
                            + "AND produto.id_categoria = categoria.id  "
                            + "AND iten.id_produto = produto.id   "
                            + "AND compra.id = carrinho.id_compra  "
                            + "AND compra.id_pessoa = " + f.id
                            + "AND carrinho.id_iten = iten.id "
                            + "ORDER BY compra.created_at DESC ");
        %>


        <div class="table-responsive">
            <table class="table table-bordered table-sm table-dark">

                <th>Nome</th>
                <th>Descrição</th>
                <th>Quantidade</th>
                <th>Total</th>
                <th>Data</th>
                    <%
                        while (set.next()) {
                            String descricao = set.getString("descricao");
                            String nome = set.getString("pNome");
                            int quant = set.getInt("quant");
                            double total = set.getDouble("total");
                            Date criado = set.getDate("create");
                    %>

                <tr class="table-light">            
                    <td><%= nome%></td>
                    <td><%= descricao%></td>
                    <td><%= quant%></td>
                    <td><%= total%></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(criado))%></td>
                </tr>
                <%
                    }

                %>

            </table>
        </div>
        <script>

            document.querySelector(".pesq").addEventListener('click', async () => {
                const {value} = await Swal.fire({
                    title: "Por favor insira valores válidos!",
                    html: '<input class="sw-dataInicial" type="date">' +
                            '<input class="sw-dataFinal" type="date">' +
                            '<input class="nome" type="text">',
                    preConfirm: () => {
                        var data1 = document.querySelector('.sw-dataInicial').value;
                        var data2 = document.querySelector('.sw-dataFinal').value;
                        if (data1 === null || data1 === "") {
                            data1 = '10/10/1970';

                        }
                        if (data2 === null || data2 === "") {
                            data2 = '10/10/2050';
                        }
                        return [
                            data1,
                            data2,
                            document.querySelector('.nome').value,
                        ]
                    }
                })
                const [data1, data2, nome] = value;
                location.href = "/WebMarket/pessoa/pedidos.jsp?"
                        + new URLSearchParams({
                            data1,
                            data2,
                            nome,
                        }).toString();
            })

        </script>
    </body>
</html>
