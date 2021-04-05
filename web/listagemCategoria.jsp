<%-- 
    Document   : listagemCategoria
    Created on : 4 de abr de 2021, 20:41:13
    Author     : STI
--%>

<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Listagem de Categorias</h1>

        <%
            ArrayList<Categoria> listCateg = new CategoriaDao().consultarTodos(); 
        %>

        <div class="table-responsive">
            <table class="table table-striped table-sm">
                <th>Id</th>
                <th>Descrição</th>
                <th>Criado Em</th>
                <th>Atualizado Em</th>
                <th>Ativo</th>
                    <%
                        for (int i = 0; i < listCateg.size(); i++) {
                            Categoria c = listCateg.get(i);
                    %>

                <tr>
                    <td><a href='/WebMarket/acao?param=edCategoria&id=<%= c.id%>'><%= c.id%></a></td>                
                    <td><%= c.descricao%></td>
                    <td><%= c.criado_em%></td>
                    <td><%= c.atualizado_em%></td>
                    <td><%= c.ativo%></td>
                </tr>
                <%
                    }
                %>

            </table>
        </div>
        <br>
        <br>
        <a href='index.jsp'>Voltar</a>
    </body>
</html>
