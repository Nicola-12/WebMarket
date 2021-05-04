/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ProdutoDao;
import entidade.Categoria;
import entidade.Produto;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.tomcat.dbcp.dbcp2.Utils;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "Produto", urlPatterns = {"/Produto"})
public class srvProduto extends HttpServlet {

    Produto p = new Produto();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet srvProduto</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet srvProduto at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String param = request.getParameter("param");

        if (param.equals("edProduto")) {

            String id = request.getParameter("id");

            Produto produto = (Produto) new ProdutoDao().consultarId(Integer.parseInt(id));
            System.out.println(produto);

            if (produto != null) {

                request.setAttribute("objetoProduto", produto);

                encaminharPagina("/WebMarket/produto/cadastroProduto.jsp", request, response);
            } else {
                encaminharPagina("error.jsp", request, response);
            }

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param = request.getParameter("param");

        System.out.println(param);

        if (param.equals(
                "cadastroProduto")) {
            System.out.println(request.getParameter("id"));
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            double valor = Double.parseDouble(request.getParameter("valor"));
            String estoque = request.getParameter("estoque");
            int idCategoria = Integer.parseInt(request.getParameter("comboCategoria"));
            String check = request.getParameter("checkbox") != null ? "ativo" : "inativo";

            if (!nome.isEmpty() || !descricao.isEmpty() || valor != 0
                    || estoque.matches("^\\d$|^[1-9]\\d{1,5}$") || idCategoria != 0) {

                p.id = id;
                p.nome = nome;
                p.descricao = descricao;
                p.valor = valor;
                p.estoque = Integer.parseInt(estoque);
                p.ativo = check;
                p.id_categoria = idCategoria;
            } else {
                return;
            }
            String retorno = null;

            if (id == 0) {
                retorno = new ProdutoDao().salvar(p);
                System.out.println("SALVOU");
                encaminharPagina("/WebMarket/produto/cadastroProduto.jsp", request, response);
            } else {
                System.out.println("ERROOO");
                return;
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void encaminharPagina(String pagina, HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect(pagina);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }
}
