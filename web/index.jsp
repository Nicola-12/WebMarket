<%-- 
    Document   : index
    Created on : 15 de mar. de 2021, 19:35:50
    Author     : Usuario
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@page import="apoio.Formatacao"%>
<%@page contentType="text/html" pageEncoding="ISO8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="menu.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <link href="css/paginaPrincipal.css" rel="stylesheet">
        <title>Web Market</title>
    </head>
    <body>
        <style>

            @media screen and (max-width: 700px){
                main {

                    grid-template-columns: 1fr;
                    grid-template-rows: 1fr 1fr;
                }
            }
        </style>
        <%            ArrayList<Produto> product = (ArrayList) request.getAttribute("campoProd");
            if (product == null) {
                product = new ProdutoDao().consultarTodos();
            }
            Produto pd = new Produto();

        %>
        <h1 style="color: red">PROJETO WEB MARKET</h1>

        <form class="pesquisa text-center" method="post" action="/WebMarket/pesquisa?param=pesquisarProd">

            <input style="width: 40%; margin: auto;" class="form-control inpPes" type="text" name="searchProd" placeholder="Digite o que deseja pesquisar">

            <button style="width: 40%; margin: auto; margin-top: 15px; " type="submit" class=" btn btn-lg btn-dark">Pesquisar</button>

        </form>

        <main>

            <%                if (product != null) {
                    if (product.size() == 0) {
                        out.print("Nenhum Produto Cadastrado");
                    } else {
                        for (int i = 0; i < product.size(); i++) {
                            pd = product.get(i);
                            String parcela = "";
                            double parcelas = 0.0;
                            int vezes = 0;
                            if (pd.valor >= 2000) {
                                parcela = String.format("%.2f", parcelas = pd.valor / 12);
                                vezes = 12;
                            } else {
                                parcela = String.format("%.2f", parcelas = pd.valor / 6);
                                vezes = 6;
                            }
            %>          
            <div class="card">
                <img src="http://localhost:7777/images/<%=pd.file%>" alt="Alguma Coisa" style="width:100%; height: 250px">
                <h1><%= pd.nome%></h1>
                <p class="price"><%= pd.valor%> R$</p>
                <p><%= pd.descricao%></p>
                <p class="parcela" style="color: grey; font-size: 15px" ><%= vezes%>x de <%= parcela%> no cartão sem juros</p>
                <p><button>Add to Cart</button></p>
            </div>
            <% }
                    }
                }
            %>

        </main>
    </body>
</html>
