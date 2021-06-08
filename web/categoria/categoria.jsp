

<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Categorias</title>
    </head>
    <body >
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <%@include file="../menu.jsp" %>

        <%            Categoria tg = (Categoria) request.getAttribute("objetoCategoria");
            if (tg == null) {
                tg = new Categoria();

                tg.id = 0;
                tg.descricao = "";
            }
        %>

        <script>
            document.addEventListener('readystatechange', () => {
                if (document.readyState !== "complete")
                    return

                const params = new URL(location.href).searchParams
                if (params.get('erro') === 'DESCRICAO_INVALIDA') {
                    swal({
                        title: "Erro!",
                        text: "Erro ao Cadastrar Categoria!",
                        icon: "error",
                        button: false,
                        timer: 1500
                    })
                }
            })

        </script>

        <style>
            .search {
                justify-content: center;
                width: 30%;
                height: 48px;
            }

            button { 
                width: 30%;
            }

            body::-webkit-scrollbar {
                display: none;
            }

            form {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;

            }

            h1 {
                text-align: center;
                margin-bottom: 15px;
            }

            button {
                margin-top: 0.5em;
                margin-bottom: 1.5em;
            }

            .table-responsive {
                width: 80%;
            }

            input:invalid:not(:placeholder-shown){
                box-shadow: 0px 0px 0px 0.25rem rgba(255,0,0,.25);
                border-color: red;
                z-index:2;
            }

            a:hover {
                opacity: 0.8;
                color: #212529;
            }
        </style>
        <h1>Cadastro de Categorias</h1>

        <form name='formCateg' method='post' action='/WebMarket/Categoria?param=salvarCategoria'>
            <input type="hidden" name="id" value="<%= tg.id%>">


            <input type="text" class="search" pattern="^.{3,45}$" name="descricao" placeholder="Descrição" value="<%= tg.descricao%>">

            <button type="submit" value="salvar" class="btn btn-lg btn-dark">Cadastrar</button>

            <%@include file = "listagemCategoria.jsp" %>
        </form>

    </body>

</html>
