<%-- 
    Document   : cadastroLogin
    Created on : 31 de mar. de 2021, 08:13:36
    Author     : Usuario
--%>

<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">
        <title>Signin Template · Bootstrap v5.0</title>

        <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">



        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
        <link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
        <link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
        <meta name="theme-color" content="#7952b3">


        <style>
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


        <!-- Custom styles for this template -->
        <link href="css/signin.css" rel="stylesheet">
    </head>
    <body class="text-center">

        <%
            Pessoa p = new Pessoa();

            p.id = 0;
            p.nome = "";
            p.senha = "";
            p.email = "";
            p.endereco = "";
            p.telefone = "";


        %>

        <main class="form-signin">
            <form method="post" action="/WebMarket/acao?param=cadastroPessoa">            

                <h1 class="h3 mb-3 fw-normal">Cadastro de Pessoa</h1>

                <h2>WebMarket</h2>

                <h6>Campos com o "*" são obrigatórios</h6>

                <input type="hidden" name="id" value=<%= p.id%>>

                <label for="inputNome" class="visually-hidden">Nome</label>
                <input type="name" name="nome" id="inputName" class="form-control" autofocus placeholder="Nome*" required value=<%= p.nome%>  > 

                <label for="inputEmail" class="visually-hidden">Email address</label>
                <input type="email" name="email" id="inputEmail" class="form-control" placeholder="E-mail*" required value=<%= p.email%>   >

                <label for="inputPassword" class="visually-hidden">Password</label>
                <input type="password" name="senha" id="inputPassword" class="form-control" placeholder="Senha*" required value=<%= p.senha%>  >

                <label for="inputEndereco" class="visually-hidden">Endereco</label>
                <input type="endereco" name="endereco" id="inputEndereco" class="form-control" placeholder="Endereço" value=<%= p.endereco%> >

                <label for="inputTelefone" class="visually-hidden">Telefone</label>
                <input type="telefone" name="telefone" id="inputTelefone" class="form-control" placeholder="Telefone*" required value=<%= p.telefone%> >

                <button class="w-100 btn btn-lg btn-dark" type="submit" value="Salvar" >Cadastrar</button>

                <p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
            </form>
        </main>

    </body>

</html>
