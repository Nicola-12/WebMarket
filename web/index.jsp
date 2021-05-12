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
        <link href="/WebMarket/css/paginaPrincipal.css" rel="stylesheet">
        <script src="/WebMarket/js/Search.js"></script>
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <link href="/WebMarket/css/navbar.css" rel="stylesheet">
        <title>Página Inicial</title>
    </head>
    <body>
        <%            ArrayList<Produto> product = (ArrayList) request.getAttribute("campoProd");
            if (product == null) {
                product = new ProdutoDao().consultarTodos();
            }
            Produto pd = new Produto();

        %>


        <div class="sideBar">

            <form class="pesquisa text-center" method="post" action="/WebMarket/pesquisa?param=pesquisarProd">

                <input style=" margin: auto;" class="form-control inpPes" type="text" name="searchProd" placeholder="Digite o que deseja pesquisar">

                <button style=" margin: auto; margin-top: 15px; " type="submit" class=" btn btn-lg btn-success">Pesquisar</button>

            </form>
            <button class="dropdown-btn btn-sucess">Categorias
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-container">
                <a onclick="setCategoria('placadevideo')" href="#">Placa de video</a>
                <a onclick="setCategoria('ssd')" href="#">SSD</a>
                <a href="#">Link 3</a>
            </div>

        </div>
        <script>
            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;

            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        </script>

    </div>

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
            <p class="parcela" style="color: grey; font-size: 15px" ><%= vezes%>x de <%= parcela%> no cartão sem juros</p>
            <p><button>Add to Cart</button></p>
        </div>
        <% }
                }
            }
        %>

    </main>
</body>
<script src="/WebMarket/js/bootstrap.bundle.min.js"></script>
</html>
