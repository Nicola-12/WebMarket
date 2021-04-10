<%-- 
    Document   : dadosConta
    Created on : 8 de abr de 2021, 19:45:33
    Author     : STI
--%>

<%@page import="dao.PessoaDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="apoio.Cripto"%>
<%@page import="apoio.ConexaoBD"%>
<%@page import="entidade.Pessoa"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <% 
            
            HttpSession sessao = ((HttpServletRequest) request).getSession();
            
            Pessoa f = (Pessoa) sessao.getAttribute("usuarioLogado");
                         
            f = new PessoaDao().consultarEmail(f.email);
            
            System.out.println(f);
        %>      
        <label for="Email" class="visually-hidden">Email:</label>
        <input type="email" name="email" id="inputEmail" class="form-control" placeholder="E-mail" value=<%= f.email%> required autofocus>
        
        <label for="Email" class="visually-hidden">Email:</label>
        <input type="email" name="email" id="inputEmail" class="form-control" placeholder="E-mail" value=<%= f.email%> required autofocus>
    </body>
</html>
