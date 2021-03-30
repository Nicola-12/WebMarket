
package servlet;

import dao.CategoriaDao;
import entidade.Categoria;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Usuario
 */
public class srvAcao extends HttpServlet {

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
            out.println("<title>Servlet srvAcao</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet srvAcao at " + request.getContextPath() + "</h1>");
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
        System.out.println("ESTOU NO GET");

        String param = request.getParameter("param");

        // CATEGORIA
        Categoria categoria = new Categoria();

        if (categoria != null) {

            request.setAttribute("objetoCategoria", categoria);

            encaminharPagina("categoria.jsp", request, response);
        } else {
            encaminharPagina("error.jsp", request, response);
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
        System.out.println("ESTOU NO POST");

        String param = request.getParameter("param");

        // SALVAR CATEGORIA
        
        if (param.equals("salvarCategoria")) {
            Categoria c = new Categoria();
            int id = Integer.parseInt(request.getParameter("id"));
            String descricao = request.getParameter("descricao");

            if (!descricao.matches("^[A-Za-z ]{5,45}$")) {
                encaminharPagina("error.jsp", request, response);
            } else {

                
                c.id = id;
                c.descricao = descricao;
                encaminharPagina("sucesso.jsp", request, response);
            }
            String retorno = null;

            if (id == 0) {
                retorno = new CategoriaDao().salvar(c);
            } else {
                // ATUALIZA A CATEGORIA
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
            RequestDispatcher rd = request.getRequestDispatcher(pagina);
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }
}