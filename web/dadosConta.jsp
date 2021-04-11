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
        <form method="post" action="/WebMarket/acao?param=editarPessoa">
        <label for="Email" class="visually-hidden">Nome:</label>
        <input type="text" name="nome" id="inputEmail" class="form-control" readonly placeholder="Nome" value=<%= f.nome%> required autofocus>
        
        <label for="Email" class="visually-hidden">Email:</label>
        <input type="email" name="email" id="inputEmail" class="form-control" placeholder="E-mail" value=<%= f.email%> required >
         
         <label for="Endereço" class="visually-hidden">Endereço:</label>
         <input type="text" name="endereco" id="inputEmail" class="form-control" placeholder="Endereço" value=<%= f.endereco%> required >
         
         <label for="Telefone" class="visually-hidden">Telefone:</label>
         <input type="text" name="telefone" id="inputEmail" class="form-control" placeholder="Telefone" value=<%= f.telefone%> required >
         
         <button type="submit">Mudar Dados da Conta</button>
        </form>
        
        <form method="post" action="/WebMarket/acao?param=mudarSenha">
            
            <label for="Senha" class="visually-hidden">Senha Velha:</label>
         <input type="password" name="senha" id="inputEmail" class="form-control" placeholder="Senha" required >
         
         <label for="Senha" class="visually-hidden">Senha Nova:</label>
         <input type="password" name="senhaNova" id="inputEmail" class="form-control" placeholder="Senha" required >
         
         <label for="Senha" class="visually-hidden">Confirmar Senha Velha:</label>
         <input type="password" name="confirmarSenha" id="inputEmail" class="form-control" placeholder="Senha" required >
         
         <button type="submit">Mudar Senha</button>
             
        </form>
    </body>
</html>
