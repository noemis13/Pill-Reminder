package servlet;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Medicamento;
import model.Usuario;

/**
 *
 * @author maa
 */
public class CadastroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        HttpSession session = request.getSession();

        System.out.println("OP " + op);
        System.out.println(request.getAttribute("id_usuario"));

        session.setAttribute("isLogado", false);

        String nome = request.getParameter("username"); //nome do campo no formulario
        String email = request.getParameter("useremail");
        String senha = request.getParameter("userpass");

        Usuario u = new Usuario();
        u.setNomeUsuario(nome);
        u.setEmailUsuario(email);
        u.setSenhaUsuario(senha);

        System.out.println("NOME " + u.getNomeUsuario());
        System.out.println("NOME " + u.getEmailUsuario());
        System.out.println("NOME " + u.getSenhaUsuario());

        DAO.insereUsuario(u);

        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
