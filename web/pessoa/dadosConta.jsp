<%-- 
    Document   : dadosConta
    Created on : 8 de abr de 2021, 19:45:33
    Author     : STI
--%>

<%@page import="dao.PessoaDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="apoio.Cript"%>
<%@page import="apoio.Database"%>
<%@page import="entidade.Pessoa"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Dados Pessoais</title>

        <!-- Favicons -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <meta name="theme-color" content="#7952b3">

        <style>

            a, a:hover {
                color: white;
                text-decoration: none;
            }

            body {
                display: grid;
                align-items: center;
            }

            main {
                display: grid;
                grid-template-columns: 1fr 1fr;
                place-items: center;
                align-items: baseline;
            }

            form {
                width: 70%;
                max-width: 350px;
            }

            label {
                margin: .45em 0;
            }

            h2 {
                margin-bottom: .5em;
            }

            @media screen and (max-width: 750px) {
                main {
                    grid-template-columns: 1fr;
                    grid-template-rows: 1fr 1fr;
                }
                form {
                    margin: 2.5em 0;
                }
            }

            .separator {
                display: block;

                margin-left: 3%;
                width: 94%;
                height: 2px;

                border-top: 1px dashed #12121266;
            }

        </style>

    </head>
    <body>
        <%  f = (Pessoa) sessao.getAttribute( "usuarioLogado" );

            f = new PessoaDao().consultarEmail( f.email );
        %>   

        <main >
            <form method="post" action="/WebMarket/acao?param=editarPessoa">
                <h2>Dados Pessoais</h2>

                <input type="hidden" name="id" value="<%=f.id%>">

                <label class="labe" for="Nome">Nome *
                    <input type="text" name="nome" pattern="^[A-Za-z ]{3,45}$" class="form-control campo" value="<%= f.nome%>" required autofocus>
                </label>

                <label for="Email">Email *
                    <input type="email" name="email" pattern="^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$" class="form-control" value="<%= f.email%>" required >
                </label>

                <label for="Endereço">Endereço *
                    <input type="text" name="endereco" class="form-control" value="<%= f.endereco%>" required >
                </label>

                <label for="Telefone">Telefone *
                    <input type="text" name="telefone" pattern="^((\+\d{1,2})?\d{2})?\d{9}$" class="form-control" value="<%= f.telefone%>" required >
                </label>

                <button type="submit" class="btn btn-dark">Mudar Dados da Conta</button>

            </form>
            <form method="post" action="/WebMarket/acao?param=mudarSenha">
                <h2>Senha e Conta</h2>

                <label for="Senha">Senha Velha *
                    <input type="password" name="senha" class="form-control" required >
                </label>

                <label for="Senha">Nova Senha *
                    <input type="password" name="senhaNova" class="form-control" required >
                </label>

                <label for="Senha">Confirmar Nova Senha *
                    <input type="password" name="confirmarSenha" class="form-control" required >
                </label>

                <button type="submit" class="btn btn-dark">Mudar Senha</button>

                <i class="separator"></i>

                <button class="btn btn-danger"><a href="/WebMarket/acao?param=excluirPessoa&id=<%= f.id%>">Desativar Conta</a> </button>
            </form>
        </main>


        <script>

            document.addEventListener('readystatechange', () => {
                if (document.readyState !== "complete")
                    return

                const params = new URL(location.href).searchParams

                if (params.get('erro') === 'ERRO') {

                    swal({
                        title: "Erro!",
                        text: "Erro ao Cadastrar Conta!",
                        icon: "warning",
                        button: "Oops!"
                    })

                } else if (params.get('certo') === 'TRUE') {

                    swal({
                        title: "Sucesso!",
                        text: "Sucesso ao Editar sua Conta!",
                        icon: "success",
                        button: "OK!"
                    })
                            .then(() => {
                                history.back();
                            })
                }
            })

        </script>
    </body>
</html>
