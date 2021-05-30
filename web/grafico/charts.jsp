<%-- 
    Document   : charts
    Created on : 29 de mai de 2021, 22:31:49
    Author     : STI
--%>

<%@page import="managers.ChartManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Estatisticas</title>
    </head>
    <body>

        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <link href="/WebMarket/css/chart.css" rel="stylesheet">
        <main>
            <h2>Estatisticas</h2>
            <h5>Vendas da semana por categoria</h5>
            <div id="bar-chart"></div>
        </main>

        <script>
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(() => {
                const data = JSON.parse(
                        '<%=ChartManager.jsonVendasSemana()%>'
                        ).reverse();

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

                    const dayData = [date];
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
                    colors: ["cornflowerblue", "tomato"],
                    fontName: "Open Sans",
                    chartArea: {
                        left: 50,
                        top: 10,
                        width: "100%",
                        height: "70%",
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
                            count: 4,
                        },
                        textStyle: {
                            fontSize: 11,
                        },
                    },
                    legend: {
                        position: "bottom",
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
                new google.visualization.ColumnChart(
                        document.getElementById("bar-chart")
                        ).draw(chartDataTable, chartOptions);
            });

        </script>
    </body>
</html>
