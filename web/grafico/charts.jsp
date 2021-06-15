<%-- 
    Document   : charts
    Created on : 29 de mai de 2021, 22:31:49
    Author     : STI
--%>

<%@page import="managers.VendaDia"%>
<%@page import="java.time.LocalDate"%>
<%@page import="apoio.ConexaoBD"%>
<%@page import="java.sql.*"%>
<%@page import="managers.ChartManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Estatisticas</title>
        <%@include file="../menu.jsp" %>
    </head>
    <body class="google">

        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <link href="/WebMarket/css/chart.css" rel="stylesheet">
        <main class="charts">
            <h2>Estatisticas</h2>
            <h5>Vendas da semana por categoria</h5>
            <div id="bar-chart"></div>
        </main>

        <script>

            const format = (d) => `\${d.getDate()}/\${d.getMonth() + 1}/\${d.getFullYear()}`;
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(() => {
            const data = JSON.parse(
                    '<%=ChartManager.jsonVendasSemana()%>'
                    );
            const chartData = [];
            // extract categories list
            const categories = new Set();
            data.flat().forEach((vendas) => {
            categories.add(vendas["categoria"]);
            });
            // add categories label
            chartData.push(["Dia da Semana", ...categories]);
            // add days
            const today = Date.now();
            for (let offset = 6; offset >= 0; offset--) {
            const date = new Date(today);
            date.setDate(date.getDate() - offset);
            const dayData = [format(date)];
            for (const c of categories) {
            const vendas = data[offset].find(r => r.categoria === c);
            dayData.push(vendas?.quantidade ?? 0);
            }
            chartData.push(dayData);
            }

            const chartDataTable = google.visualization.arrayToDataTable(chartData);
            const chartOptions = {
            focusTarget: "category",
                    backgroundColor: "transparent",
                    colors: ["cornflowerblue", "tomato", '#a9c413', '#e673F0'],
                    fontName: "Open Sans",
                    chartArea: {
                    left: 50,
                            top: 20,
                            width: "100%",
                            height: "60%",
                    },
                    bar: {
                    groupWidth: "75%",
                    },
                    hAxis: {
                    textStyle: {
                    fontSize: 11,
                    },
                    },
                    vAxis: {
                    baselineColor: "#DDD",
                            gridlines: {
                            color: "#DDD",
                                    count: 5,
                            },
                            textStyle: {
                            fontSize: 11,
                            },
                    },
                    legend: {
                    position: "bottom",
                            maxLines: 3,
                            textStyle: {
                            fontSize: 12,
                            },
                    },
                    animation: {
                    duration: 1200,
                            easing: "out",
                            startup: true,
                    },
                    isStacked: true,
            };
            // draw chart
            var table = new google.visualization.ColumnChart(document.getElementById("bar-chart"));
            table.draw(chartDataTable, chartOptions);
            google.visualization.events.addListener(table, 'select', selectHandler);
            function selectHandler(e) {
            var selectedItem = table.getSelection();
            console.log(selectedItem[0]?.row);
            location = "/WebMarket/grafico/charts.jsp?dia=" + selectedItem[0]?.row;
            }
            });

        </script>

        <%
            int dia = 6;
            try {
                dia = Integer.parseInt(request.getParameter("dia"));
                if (dia < 0 || dia > 6) {
                    dia = 6;
                }
            } catch (NumberFormatException e) {

            }

            dia = 6 - dia;

            ArrayList<VendaDia> vendaDia = new ArrayList<>();

            String data = LocalDate.now().minusDays(dia).toString();

            ResultSet resultSet = ConexaoBD.getInstance().getConnection()
                    .createStatement()
                    .executeQuery(
                            "SELECT \n"
                            + "  produto.*, \n"
                            + "  SUM(item.quant) AS quantidade,\n"
                            + "  SUM(item.quant*item.total) AS total\n"
                            + "FROM \n"
                            + "  categoria, \n"
                            + "  compra, \n"
                            + "  itencarrinho AS item, \n"
                            + "  carrinho, \n"
                            + "  produto\n"
                            + "WHERE compra.created_at = '" + data + "' \n"
                            + "  AND categoria.id = produto.id_categoria \n"
                            + "  AND produto.id = item.id_produto\n"
                            + "  AND carrinho.id_compra = compra.id \n"
                            + "  AND carrinho.id_iten = item.id \n"
                            + "GROUP BY produto.id, item.id_produto\n"
                            + "HAVING SUM(item.quant) > 0");

            while (resultSet.next()) {
                VendaDia v = new VendaDia();
                v.id = resultSet.getInt("id");
                v.descricao = resultSet.getString("descricao");
                v.valor = resultSet.getDouble("valor");
                v.estoque = resultSet.getInt("estoque");
                v.id_categoria = resultSet.getInt("id_categoria");
                v.ativo = resultSet.getString("ativo");
                v.nome = resultSet.getString("nome");
                v.file = resultSet.getString("file");
                v.quantidade = resultSet.getLong("quantidade");
                v.total = resultSet.getLong("total");

                vendaDia.add(v);
            }
        %>

        <table class="table table-bordered table-sm table-dark">
            <th>Id</th>
            <th>Nome</th>
            <th>Valor</th>
            <th>Quantidade</th>
            <th>Total Vendido</th>
                <%      for (int i = 0; i < vendaDia.size(); i++) {
                        VendaDia ven = vendaDia.get(i);
                %>

            <tr class="table-light">
                <td><%= ven.id%></td>                
                <td><%= ven.nome%></td>
                <td><%= ven.valor%></td>
                <td><%= ven.quantidade%></td>
                <td><%= ven.total%></td>
            </tr>
            <%
                }

            %>

        </table>

        <a href="/WebMarket/index.jsp"><button class="btn btn-dark">Voltar ao Inicio</button></a>
    </body>
</html>
