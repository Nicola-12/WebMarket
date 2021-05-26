
<%@page import="entidade.Categoria"%>
<%@page import="dao.CategoriaDao"%>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <title>Página Inicial</title>
    </head>
    <body>

        <%            Produto pd = new Produto();
            ArrayList<Categoria> c = new CategoriaDao().consultarTodos();
            ArrayList<Produto> product = new ProdutoDao().consultarTodos();
            String pesquisa = request.getParameter("pesquisa");
            if (pesquisa == null) {
                pesquisa = "";
            }
            String pesquisaPreco = request.getParameter("preco");
            if (pesquisaPreco == null)
                pesquisaPreco = "0";
        %>


        <div class="sideBar">

            <form class="pesquisa text-center" onsubmit="sub(event)">

                <input style=" margin: auto;" class="form-control inpPes" type="text" value="<%= pesquisa%>" name="pesquisa" placeholder="Pesquisar...">

                <button style=" margin: auto; margin-top: 15px; " type="submit" class=" btn btn-lg btn-success">Pesquisar</button>

                <div class="range">
                    <label class="coment">0</label>
                    <input class="range" type="range" name="preco" min="0" max="5000" value="<%= pesquisaPreco%>">
                    <label class="coment">5000</label>
                </div>
                <label style="color: white"><%= pesquisaPreco%></label>
            </form>
            <button class="dropdown-btnn btn-sucess">Categorias
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-container">
                <%for (int x = 0; x < c.size(); x++) {
                        Categoria categ = c.get(x);
                %>
                <a onclick="setCategoria('<%= categ.id%>')" href="#"><%= categ.descricao%></a>
                <% }%>
            </div>

        </div>


    </div>
    <script>
        var dropdown = document.getElementsByClassName("dropdown-btnn");
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

        function setCategoria(categoria) {

            const url = new URL(location.href);

            url.searchParams.set("categoria", categoria);

            location.href = url.toString();
        }

        function sub(evt) {
            evt.preventDefault();
            const fd = new FormData(evt.target);

            const url = new URL(location.href);

            url.searchParams.set("pesquisa", fd.get('pesquisa'));
            url.searchParams.set("preco", fd.get('preco'));

            location.href = url.toString();
        }

        function setPrecoProduto(value) {

            const url = new URL(location.href);

            url.searchParams.set("preco", value);

            location.href = url.toString();
        }
    </script>
    <main>

        <%

            product = new ProdutoDao().consultarProdAndCategAndPreco(
                    pesquisa, request.getParameter("categoria"), request.getParameter("preco")
            );

            if (product.size() == 0) {
        %>
        <script>

            swal({
                title: "Oopa!",
                text: "Nenhum Produto Cadastrado!",
                icon: "warning",
                button: "ok!"
            })
                    .then(() => {
                        history.back();
                    })


        </script>        
        <%
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
        <form class="card" method="post" action="/WebMarket/cart?param=addProd">
            <input type="text" value="<%=pd.id%>" name="idCart" hidden >
            <img src="http://localhost:7777/images/<%=pd.file%>" alt="Alguma Coisa" style="width:100%; height: 250px">
            <h1><%= pd.nome%></h1>
            <p class="price"><%= pd.valor%> R$</p>
            <p class="parcela" style="color: grey; font-size: 15px" ><%= vezes%>x de <%= parcela%> no cartão sem juros</p>
            <%
                if (pd.estoque == 0 || pd.ativo.equals("false")) {
            %>
            <p><button>Produto Indisponivel</button></p>
            <%} else { %>
            <p><button>Add to Cart</button></p>
            <%
                }
            %>
        </form>
        <% }
            }

        %>


    </main>
</body>s
</html>
