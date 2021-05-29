<%-- 
    Document   : carrinho
    Created on : 24 de mai. de 2021, 21:41:37
    Author     : Usuario
--%>

<%@page import="entidade.Compra"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.ItemCarrinho"%>
<%@page import="entidade.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrinho</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link href="/WebMarket/css/cart.css" rel="stylesheet">
    </head>
    <body>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <%@include file="../menu.jsp" %>
        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">WEB MARKET CART</h1>
            </div>
        </section>

        <script>
            document.addEventListener('readystatechange', () => {
                if (document.readyState !== "complete")
                    return

                const params = new URL(location.href).searchParams
                if (params.get('erro') === 'ERRO') {
                    swal.fire({
                        title: "Houve um Problema!",
                        text: "erro ao comprar o(s) produto(s)",
                        icon: "error",
                        button: "OK",
                    })
                }
            })
        </script>

        <%            HttpSession ses = ((HttpServletRequest) request).getSession();
            ArrayList<ItemCarrinho> prods = (ArrayList<ItemCarrinho>) ses.getAttribute("cart");

            double subTotal = 0.0;
        %>

        <div class="container mb-4">
            <form method="post" action="/WebMarket/cart?param=compra" class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table table-dark">
                            <thead>
                                <tr>
                                    <th scope="col"> </th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Available</th>
                                    <th scope="col" class="text-center">Quantity</th>
                                    <th scope="col" class="text-right">Price</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    if (prods.size() == 0) {
                                        out.print("NAO CONTEM NADA");
                                    } else {
                                        for (int i = 0; i < prods.size(); i++) {
                                            Produto c = new ProdutoDao().consultarId(prods.get(i).id_produto);
                                %>
                            <input type="text" hidden name="idProd" value="<%=c.id%>">
                            <tr class="table-light">
                                <td><img src="http://localhost:7777/images/<%= c.file%>" /> </td>
                                <td><%=c.nome%></td>
                                <td>In stock: <%=c.estoque%></td>
                                <td class="quant">
                                    <a class="btn btn-outline-info" href="/WebMarket/cart?param=qrem&id=<%=c.id%>"><i class="fas fa-minus"></i></a>
                                    <span><%=prods.get(i).quant%></span>
                                    <a class="btn btn-outline-info" href="/WebMarket/cart?param=qadd&id=<%=c.id%>"><i class="fas fa-plus"></i></a>                                 
                                </td>
                                <td class="text-right"><%=c.valor * prods.get(i).quant%> R$</td>
                                <td class="text-right"><a href="/WebMarket/cart?param=exCart&id=<%=c.id%>" class="btn btn-sm btn-danger" ><i class="fa fa-trash"></i></a> </td>
                            </tr>
                            <%

                                    subTotal += c.valor * prods.get(i).quant;
                                }
                            %>
                            <tr class="table-light">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>Parcelas</td>
                                <td class="text-right">                       
                                    <input type="number" name="parcelas" class="parcelas" min="1" max="12" step="1" value="1"/>
                                </td>
                            </tr>

                            <tr class="table-light">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>Sub-Total</td>
                                <td class="text-right"><%=String.format("%.2f", subTotal)%></td>
                            </tr>
                            <%                                    }

                                double taxa = subTotal * 0.05;
                                double totalCompra = subTotal + taxa;
                            %>
                            <tr class="table-light">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>Taxas - 5%</td>
                                <td class="text-right"><%=String.format("%.2f", taxa)%> R$</td>
                            </tr>
                            <tr class="table-light">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><strong>Total</strong></td>
                                <td><input name="totalCompra" value="<%= totalCompra%>" hidden><strong><%=String.format("%.2f", totalCompra)%> R$ </strong></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col mb-2">
                    <div class="row">
                        <div class="col-sm-12  col-md-6">
                            <a href="/WebMarket/index.jsp"><button class="btn w-100 btn-outline-secondary">Continuar Comprando</button> </a>
                        </div>
                        <div class="col-sm-12 col-md-6 text-right">
                            <button class="btn w-100 btn-success">Finalizar Compra</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>


    </body>

    <!-- Footer -->
    <footer class="text-light">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-lg-4 col-xl-3">
                    <h5>About</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <p class="mb-0">
                        Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.
                    </p>
                </div>

                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto">
                    <h5>Informations</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <ul class="list-unstyled">
                        <li><a href="">Link 1</a></li>
                        <li><a href="">Link 2</a></li>
                        <li><a href="">Link 3</a></li>
                        <li><a href="">Link 4</a></li>
                    </ul>
                </div>

                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto">
                    <h5>Others links</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <ul class="list-unstyled">
                        <li><a href="">Link 1</a></li>
                        <li><a href="">Link 2</a></li>
                        <li><a href="">Link 3</a></li>
                        <li><a href="">Link 4</a></li>
                    </ul>
                </div>

                <div class="col-md-4 col-lg-3 col-xl-3">
                    <h5>Contact</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <ul class="list-unstyled">
                        <li><i class="fa fa-home mr-2"></i> My company</li>
                        <li><i class="fa fa-envelope mr-2"></i> email@example.com</li>
                        <li><i class="fa fa-phone mr-2"></i> + 33 12 14 15 16</li>
                        <li><i class="fa fa-print mr-2"></i> + 33 12 14 15 16</li>
                    </ul>
                </div>
                <div class="col-12 copyright mt-3">
                    <p class="float-left">
                        <a href="#">Back to top</a>
                    </p>
                    <p class="text-right text-muted">created with <i class="fa fa-heart"></i> by <a href="https://t-php.fr/43-theme-ecommerce-bootstrap-4.html"><i>t-php</i></a> | <span>v. 1.0</span></p>
                </div>
            </div>
        </div>
    </footer>
</html>
