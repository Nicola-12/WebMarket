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
        <title>Pedidos</title>
    </head>
    <body>
        <style>
            .btn {
                width: 50%;
                outline-color: black;
                align-self: center;
            }
        </style>

        <%@include file="../menu.jsp" %>

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
        <a class="pesq" href="#"><button class="btn btn-black">pesquisa</button></a>
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
        <h1 style="text-align: center;">MEUS PEDIDOS FEITOS ATÉ O MOMENTO</h1>
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

                <th>Descrição</th>
                <th>Nome</th>
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
                    <td><%= descricao%></td>
                    <td><%= nome%></td>
                    <td><%= quant%></td>
                    <td><%= total%></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(criado))%></td>
                </tr>
                <%
                    }

                %>

            </table>
        </div>
    </body>
</html>
