package servlet;

import apoio.ConexaoBD;
import dao.ProdutoDao;
import entidade.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.function.Predicate;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "cart", urlPatterns = {"/cart"})
public class srvCarrinho extends HttpServlet {

    ConexaoBD bd = new ConexaoBD();
    ProdutoDao pd = new ProdutoDao();

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
            out.println("<title>Servlet cart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet carrinho at " + request.getContextPath() + "</h1>");
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

        HttpSession session = ((HttpServletRequest) request).getSession();
        String param = request.getParameter("param");

        ArrayList<Produto> produtos = (ArrayList<Produto>) session.getAttribute("cart");

        if (param.equals("exCart")) {
            String id = request.getParameter("id");
            int d = Integer.parseInt(id);

            removeItem(produtos, p -> p.id == d);

            response.sendRedirect("/WebMarket/carrinho/carrinho.jsp");
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
        HttpSession session = ((HttpServletRequest) request).getSession();
        String param = request.getParameter("param");

        ArrayList<Produto> produtos = (ArrayList<Produto>) session.getAttribute("cart");
        if (param.equals("addProd")) {

            String id = request.getParameter("idCart");

            Produto p = pd.consultarId(Integer.parseInt(id));

            produtos.add(p);

            response.sendRedirect("/WebMarket/index.jsp");
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

    public static <T> void removeItem(ArrayList<T> items, Predicate<T> find) {
        for (int i = 0; i < items.size(); i++) {
            if (find.test(items.get(i))) {
                items.remove(i);
                return;
            }
        }
    }
}
