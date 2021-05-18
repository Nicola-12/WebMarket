<%-- 
    Document   : menu
    Created on : Mar 22, 2021, 8:36:37 PM
    Author     : pretto
--%>

<%@page import="dao.PessoaDao"%>
<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <title>Página Principal</title>

        <style>

            .center {
                display: flex;
                justify-content: center;
                align-items: center;
                color: #D3D3D3;
                margin-left: 7px;
                margin-right: 40px;
            }
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>

        <!-- Bootstrap core CSS -->
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">
        <link href="/WebMarket/css/bootstrap.min.css.map">
        <link href="/WebMarket/css/navbar.css" rel="stylesheet">
    </head>
    <body>
        <%
            HttpSession sessao = ((HttpServletRequest) request).getSession();
            Pessoa f = (Pessoa) sessao.getAttribute("usuarioLogado");
            f = new PessoaDao().consultarEmail(f.email);
        %>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark" aria-label="Fourth navbar example">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">WebMarket</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarsExample04">
                    <ul class="navbar-nav me-auto mb-2 mb-md-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/WebMarket/index.jsp" >Início</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Menu 1</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Desabilitado</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">Cadastros</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="/WebMarket/categoria/categoria.jsp">Categoria</a></li>
                                <li><a class="dropdown-item" href="/WebMarket/produto/cadastroProduto.jsp">Produto</a></li>
                                <li><a class="dropdown-item" href="/WebMarket/categoria/pesquisaCategoria.jsp">Pesquisar</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form>
                        <input class="form-control" type="text" placeholder="Search" aria-label="Search">
                    </form>
                    <div>
                        <li class="nav-item dropdown center">
                            <a class="nav-link dropdown-toggle center" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-alt "></i></a>
                            <label><%=f.nome%></label>
                            <ul class="dropdown-menu data" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="/WebMarket/pessoa/dadosConta.jsp">Dados</a></li>
                                <li><a class="dropdown-item" href="/WebMarket/acao?param=logout">Deslogar</a></li>
                            </ul>
                        </li>
                    </div>
                </div>
            </div>
        </nav>

        <script src="/WebMarket/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
