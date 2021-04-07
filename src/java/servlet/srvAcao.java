package servlet;

import apoio.ConexaoBD;
import apoio.Cripto;
import dao.CategoriaDao;
import dao.PessoaDao;
import entidade.Categoria;
import entidade.Pessoa;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.err;
import static java.lang.System.out;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Usuario
 */
public class srvAcao extends HttpServlet {

    ConexaoBD bd = new ConexaoBD();
    ResultSet r = null;
    Categoria categoria = new Categoria();

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

        // -----------------LOGIN-----------------
        if (param.equals("logout")) {
            System.out.println("LOGOUTTTTTT");
            HttpSession sessao = request.getSession();
            sessao.invalidate();
            response.sendRedirect("login.jsp");

            // CATEGORIA
        } else if (param.equals("edCategoria")) {

            String id = request.getParameter("id");

            categoria = (Categoria) new CategoriaDao().consultarId(Integer.parseInt(id));

            if (categoria != null) {

                request.setAttribute("objetoCategoria", categoria);

                encaminharPagina("categoria.jsp", request, response);
            } else {
                encaminharPagina("error.jsp", request, response);
            }

        } else if (param.equals("exCategoria")) {
            String id = request.getParameter("id");
            categoria = (Categoria) new CategoriaDao().consultarId(Integer.parseInt(id));

            if (categoria != null) {
                CategoriaDao excluir = new CategoriaDao();
                excluir.excluir(Integer.parseInt(id));
                encaminharPagina("sucesso.jsp", request, response);
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
        System.out.println("ESTOU NO POST");

        String param = request.getParameter("param");

        // SALVAR CATEGORIA        
        if (param.equals("salvarCategoria")) {
            categoria = new Categoria();
            int id = Integer.parseInt(request.getParameter("id"));
            String descricao = request.getParameter("descricao");

            if (!descricao.matches("^[A-Za-z ]{5,45}$")) {
                encaminharPagina("error.jsp", request, response);
            } else {

                categoria.id = id;
                categoria.descricao = descricao;

            }
            String retorno = null;

            if (id == 0) {
                retorno = new CategoriaDao().salvar(categoria);
                System.out.println("SALVOU");
                encaminharPagina("sucesso.jsp", request, response);
            } else {
                retorno = new CategoriaDao().atualizar(categoria);
                System.out.println("ATUALIZOU");
                encaminharPagina("sucesso.jsp", request, response);
            } 
        }

        // SALVAR PESSOA
        //----------------- FALTA IMPLEMENTAR AS VALIDAÇÕES DOS CAMPOS -------------- 
        if (param.equals("cadastroPessoa")) {
            Pessoa p = new Pessoa();
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String endereco = request.getParameter("endereco");
            String telefone = request.getParameter("telefone");

            if (!nome.matches("^[A-Za-z ]{5,45}$") || nome.isEmpty()) {
                System.out.println(nome);
                encaminharPagina("error.jsp", request, response);
                //} else if (!senha.matches("^[A-Za-z ]{8,22}$")) {
                //   System.out.println(senha);
                //   encaminharPagina("error.jsp", request, response);
            } else if (!nome.isEmpty() && !senha.isEmpty() && !email.isEmpty() && !telefone.isEmpty()) {
                p.id = id;
                p.nome = nome;
                p.email = email;
                p.senha = Cripto.criptografar(senha);
                p.endereco = endereco;
                p.telefone = telefone;
                encaminharPagina("sucesso.jsp", request, response);
            }
            String retorno = null;
            if (id == 0) {
                retorno = new PessoaDao().salvar(p);
            }
        }

        // -------------------LOGIN------------------
        if (param.equals("login")) {
            // ignorando autenticacao = demo
            Pessoa pes = new Pessoa();
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            if (email.isEmpty() || senha.isEmpty()) {
                err.print("Usuário ou Senha Inválidos");
            }

            try {
                ResultSet set = bd.getConnection().createStatement()
                        .executeQuery("SELECT * FROM pessoa WHERE email = '" + email + "'");

                if (!set.next()) {
                    System.out.println("Usuário ou Senha Inválidos");
                    encaminharPagina("login.jsp", request, response);
                    return;
                }

                if (Cripto.eIgual(set.getString("senha"), new String(senha))) {
                    pes.email = email;
                    pes.senha = senha;
                    HttpSession sessao = ((HttpServletRequest) request).getSession();

                    sessao.setAttribute("usuarioLogado", pes);

                    encaminharPagina("categoria.jsp", request, response);
                    System.out.println("DEU CERTO");
                } else {
                    request.setAttribute("msgLogin", "erro");
                    encaminharPagina("login.jsp", request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(srvAcao.class.getName()).log(Level.SEVERE, null, ex);
            }
            // consulta no BD: verificar se credenciais estão ok
            // ...
            // após validar credenciais, adiciona user na Sessão

            // redirecionando para menu.jsp
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
