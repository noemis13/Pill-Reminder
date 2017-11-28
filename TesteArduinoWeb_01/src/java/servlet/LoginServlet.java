/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.DAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.scene.media.Media;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Medicamento;
import model.Usuario;
import arduino.AcessaArduino;

/**
 *
 * @author maisa
 */
public class LoginServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    AcessaArduino acessaArduino;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op.equals("perfil")) {
            HttpSession session = request.getSession(true);
            session.setAttribute("isLogado", true);
            session.setAttribute("editarPerfil", false);
            response.sendRedirect("perfil.jsp");

        } else if ("sair".equals(op)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");

        } else if ("cadmedicamento".equals(op)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("isLogado", true);
            response.sendRedirect("cadMedicamento.jsp");

        } else if ("home".equals(op)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("isLogado", true);
            response.sendRedirect("home.jsp");

        } else if ("wiki".equals(op)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("isLogado", true);
            response.sendRedirect("wiki.jsp");
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

        try {
            acessaArduino = new AcessaArduino();
            System.out.println("porta detectada: " + acessaArduino.getPortaSelecionada());

        } catch (Exception e) {
            System.out.println("Erro ao acionar o arduino");
        }

//        DAOUsuario daoUsuario = new DAOUsuario();
        List<Medicamento> medicamentos = new ArrayList<>();

        String op = request.getParameter("op");
        HttpSession session = request.getSession();

        String e = request.getParameter("useremail");
        String p = request.getParameter("userpass");

        System.out.println("EMAIL " + e);
        System.out.println("Senha " + p);

        if (DAO.validaUsuario(e, p)) {
            try {
                Usuario u = new Usuario();
                u = DAO.buscaNomeUsuario(e);
                session.setAttribute("id_usuario", u.getIdUsuario());
                session.setAttribute("nome_usuario", u.getNomeUsuario());
                session.setAttribute("email_usuario", u.getEmailUsuario());
                session.setAttribute("senha_usuario", u.getSenhaUsuario());
                session.setAttribute("acessaArduino", acessaArduino);
                session.setAttribute("flag", true);
                session.setAttribute("isLogado", true);

                medicamentos = DAO.buscaRemediosUsuarios(u.getIdUsuario());
                session.setAttribute("listaMedicamentos", medicamentos);
//                System.out.println("LISTA " + medicamentos.toString());

                response.sendRedirect("home.jsp");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InstantiationException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            request.setAttribute("erroLogin", "Usuário e/ou Senha Incorretos!");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
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

}
