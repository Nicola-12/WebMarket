<%-- 
    Document   : categoria
    Created on : 27 de mar. de 2021, 19:01:05
    Author     : Usuario
--%>

<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
         <%@include file="menu.jsp" %>
         
        <%
        Categoria tg = (Categoria) request.getAttribute("objetoCategoria");
        
        if(tg == null){
            tg = new Categoria();
            
            tg.id = 0;
            tg.descricao = "";
            tg.ativo = "";
        }
        
        %>
        
        <h1>Cadastro de Categorias</h1>
        
        <form style="padding: 20px" name='formCateg' method='post' action='/WebMarket/acao?param=salvarCategoria'>
            <input type="hidden" name="id" value=<%= tg.id %>>
            
            
            <input type="text" name="descricao" placeholder="Descrição" value=<%= tg.descricao %>>
            <br>
            <input type="checkbox" name="ativo" placeholder="ativo" checked value=<%= tg.ativo %>>
            <label for="ativo">Ativo</label>
            <br>
            <input type="submit" value="Salvar">
            
            <br>
            <br>
            <br>
            <%@include file = "listagemCategoria.jsp" %>
        </form>
    </body>
</html>
