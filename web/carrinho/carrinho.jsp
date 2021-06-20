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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link href="/WebMarket/css/cart.css" rel="stylesheet">
    </head>
    <body>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <%@include file="../menu.jsp" %>
        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">WEB MARKET CARRINHO</h1>
            </div>
        </section>
        
        <style>
            label {
                margin: 5px;
                padding-bottom: 10px;
            }
        </style>

        <%            HttpSession ses = ((HttpServletRequest) request).getSession();
            ArrayList<ItemCarrinho> prods = (ArrayList<ItemCarrinho>) ses.getAttribute("cart");

            double subTotal = 0.0;
        %>

        <div class="container mb-4">
            <form method="post" action="/WebMarket/cart?param=compra" class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <%  if (prods.size() == 0) {
                                out.print("<div style='text-align: center; margin: 10px;'>"
                                        + "<span style='font-size: 35px; font-weight: bold;'>"
                                        + "Nenhum Produto Adicionado "
                                        + "</span>"
                                        + "<div>");
                            } else {
                                for (int i = 0; i < prods.size(); i++) {
                                    Produto c = new ProdutoDao().consultarId(prods.get(i).id_produto);
                        %>
                        <table class="table table-dark">
                            <thead>
                                <tr>
                                    <th scope="col"> </th>
                                    <th scope="col">Produto</th>
                                    <th scope="col">Disponivel</th>
                                    <th scope="col" class="text-center">Quantidade</th>
                                    <th scope="col" class="text-right">Preço</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="table-light">
                            <input type="text" hidden name="idProd" value="<%=c.id%>">
                            <td><img src="http://localhost:7777/images/<%= c.file%>" /> </td>
                            <td><%=c.nome%></td>
                            <td>Em estoque: <%=c.estoque%></td>
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
                            <%

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
                <h3>Método de Pagamento:</h3>
                <div><input type='radio' name='opt' value='1' checked /> Boleto Bancário</div>
                <div><input type='radio' name='opt' value='2' /> Cartão de Crédito</div>

                <div style="display: none;" class='info' id='info2'>
                    <label>Numero do Cartão: 
                        <input type="tel" class="form-control" pattern="^[0-9\s]{16}$" inputmode="numeric" autocomplete="cc-number" maxlength="16" placeholder="xxxxxxxxxxxxxxxx"/>
                    </label>
                    <label>Numero do Cvv: 
                        <input type="tel" class="form-control" maxlength="3" pattern="^([0-9]{3})$" title="Exigido 3 digitos - XXX" placeholder="XXX"/>
                    </label>
                    <label>Data de Vencimento do Cartão: 
                        <input type="text" class="form-control" pattern="(?:0[1-9]|1[0-2])/[0-9]{2}" title="Uma data valida para MM/YY" placeholder="MM/YY"/>
                    </label>
                    <label style="width: 80%;">Nome Completo: 
                        <input style="width: 80%;" class="form-control" type="text" pattern="^[a-zA-Z ]{0,100}$"/>
                    </label>

                </div>
                 <% }%>

                <div class="col mb-2">
                    <div class="row">
                        <div class="col-sm-12  col-md-6">
                            <a href="/WebMarket/index.jsp"><button class="btn w-100 btn-outline-secondary" id="test">Continuar Comprando</button> </a>
                        </div>
                        <div class="col-sm-12 col-md-6 text-right">
                            <button class="btn w-100 btn-success" type="submit" id="testt">Finalizar Compra</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script>

            var update = function () {
                $(".info").hide();
                $("#info" + $(this).val()).show();
            };

            $("input[type='radio']").change(update);

            const button = document.querySelector('#test');

            button.addEventListener('click', () => {
                location.href = "/Webmarket/index.jsp";
                return;
            })

            const butt = document.querySelector('#testt');
            butt.addEventListener('click', () => {
                if (butt.readyState !== "complete")
                    return;

                const params = new URL(location.href).searchParams
                if (params.get('erro') === 'ERRO') {
                    Swal.fire({
                        title: "Houve um Problema!",
                        text: "erro ao comprar o(s) produto(s)",
                        icon: "error",
                        button: "OK",
                    })
                } else if (params.get('erro') === 'NENHUM_PRODUTO') {
                    Swal.fire({
                        title: "Houve um Problema!",
                        text: "Nenhum Produto foi Adicionado ao Carrinho",
                        icon: "error",
                        button: "OK",
                    }).then(() => {
                        location.href = "/WebMarket/index.jsp"
                    })
                }
            })
        </script>
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

                </div>
            </div>
        </div>
    </footer>
    <script src="/WebMarket/js/bootstrap.bundle.min.js" defer></script>
</html>
