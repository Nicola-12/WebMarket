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
        Categoria categ = (Categoria) request.getAttribute("objetoCategoria");
        
        if(categ == null){
            categ = new Categoria();
            
            categ.setId(0);
            categ.setDescricao("");
        }
        
        %>
        
        <h1>Cadastro de Categorias</h1>
        
        <form name='formCateg' method='post' action='/WebMarket/acao?param=salvarCategoria'>
            <input type="hidden" name="id" value=<%= categ.getId() %>>
            
            
            <input type="text" name="descricao" placeholder="Descrição" value=<%= categ.getDescricao() %>>
            
            <input type="submit" value="Salvar">
        </form>
    </body>
</html>
