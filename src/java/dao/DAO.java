package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Medicamento;
import model.Usuario;

public class DAO {

    /*------------remoto-----------------*/
//    private static final String url = "jdbc:mysql://mysql.sol.pro.br/";
//    private static final String dbName = "sol01";
//    private static final String driver = "com.mysql.jdbc.Driver";
//    private static final String userName = "sol01";
//    private static final String password = "lageado";
    private static final String url = "jdbc:mysql://localhost:3306/";
    private static final String dbName = "comp_fisica";
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String userName = "root";
    private static final String password = "";

    public static boolean validaUsuario(String name, String pass) {
        boolean status = false;
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);

            pst = conexao.prepareStatement("select email_usuario, senha_usuario from  usuario where email_usuario=? and senha_usuario=?");
            pst.setString(1, name);
            pst.setString(2, pass);
            System.out.println(" usuario " + name);
            System.out.println(" senha " + pass);

            rs = pst.executeQuery();
            status = rs.next();

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pst == null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return status;
    }

    public static boolean insereUsuario(Usuario u) {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "INSERT INTO usuario (nome_usuario, email_usuario, senha_usuario) VALUES ('" + u.getNomeUsuario() + "','" + u.getEmailUsuario() + "','" + u.getSenhaUsuario() + "')";

            statement.execute(sql);
            statement.close();

            return true;
        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return false;
        }

    }

    public static boolean verificaUsuario(String email) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        Class.forName(driver).newInstance();
        conexao = DriverManager.getConnection(url + dbName, userName, password);
        pst = conexao.prepareStatement("select email_usuario from usuario where email_usuario = " + "'" + email + "'");

        rs = pst.executeQuery();

        if (rs != null) {
            return true;
        } else {
            return false;
        }
    }

    public static Usuario buscaNomeUsuario(String email) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        Class.forName(driver).newInstance();
        conexao = DriverManager.getConnection(url + dbName, userName, password);
        pst = conexao.prepareStatement("select id_usuario, nome_usuario, senha_usuario, email_usuario from usuario where email_usuario = " + "'" + email + "'");

        rs = pst.executeQuery();
        String aux = "";
        Usuario u = new Usuario();
        while (rs.next()) {
            u.setIdUsuario(rs.getInt("id_usuario"));
            u.setNomeUsuario(rs.getString("nome_usuario"));
            u.setSenhaUsuario(rs.getString("senha_usuario"));
            u.setEmailUsuario(rs.getString("email_usuario"));
        }
        return u;
    }

//    public static boolean insereUsuario(Usuario u) {
//        Connection conexao = null;
//        PreparedStatement pst = null;
//        ResultSet rs = null;
//
//        try {
//            Class.forName(driver).newInstance();
//            conexao = DriverManager.getConnection(url + dbName, userName, password);
//            Statement statement = conexao.createStatement();
//            String sql = "INSERT INTO usuario (nome_usuario, email_usuario, senha_usuario) VALUES ('" + u.getNome() + "','" + u.getEmail() + "','" + u.getSenha() + "')";
//
//            statement.execute(sql);
//            statement.close();
//
//            return true;
//        } catch (Exception ex) {
//            System.out.println("Erro : " + ex.getMessage());
//            return false;
//        }
//
//    }
    public static List<Medicamento> buscaRemediosUsuarios(int idUsuario) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        List<Medicamento> listaResultado = new ArrayList<>();

        Class.forName(driver).newInstance();
        conexao = DriverManager.getConnection(url + dbName, userName, password);

        pst = conexao.prepareStatement("select * from medicamento WHERE fk_idUsuario =" + idUsuario);

        rs = pst.executeQuery();

        Medicamento m = null;

        while (rs.next()) {
            m = new Medicamento();
            m.setIdMedicamento(rs.getInt("id_medicamento"));
            m.setNomeMedicamento(rs.getString("nome_medicamento"));
            m.setDtInicio(rs.getString("dt_inicio"));
            m.setDtFim(rs.getString("dt_fim"));
            m.setIntervaloHoras(rs.getString("intervalo_horas"));
            listaResultado.add(m);
        }
        return listaResultado;
    }

    public static List<String> listaDatas() throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        List<String> listaResultado = new ArrayList<>();

        Class.forName(driver).newInstance();
        conexao = DriverManager.getConnection(url + dbName, userName, password);

        pst = conexao.prepareStatement("select datahora_coleta_dados from coleta_dados");
        rs = pst.executeQuery();

        while (rs.next()) {
            listaResultado.add(String.valueOf(rs.getTimestamp("datahora_coleta_dados")));
        }
        return listaResultado;

    }

    public static boolean gravaLogUsuario(String data, String dados, String email) {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ArrayList<Usuario> listaUsuarios = new ArrayList<>();

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            Statement statement = conexao.createStatement();
            String sql = "INSERT INTO logs_usuario (datahora_log_usuario, ocorrencia_log_usuario, email_usuario) VALUES ('" + data + "','" + dados + "','" + email + "')";

            statement.execute(sql);
            statement.close();
            return true;

        } catch (Exception ex) {
            System.out.println("Erro : " + ex.getMessage());
            return false;
        }
    }

    public static boolean atualizarUsuario(String nome, String senha, String email) {
        Connection conexao = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(driver).newInstance();
            conexao = DriverManager.getConnection(url + dbName, userName, password);
            try (Statement statement = conexao.createStatement()) {
                String sql = "UPDATE usuario SET nome_usuario='" + nome + "', senha_usuario='" + senha + "' where email_usuario = '" + email + "'";

                statement.execute(sql);
            }
            return true;

        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            System.out.println("Erro : " + ex.getMessage());
            return false;
        }
    }

}
