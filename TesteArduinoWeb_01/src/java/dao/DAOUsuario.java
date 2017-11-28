package dao;

import java.util.ArrayList;
import java.util.List;
import model.Usuario;

public class DAOUsuario extends DAOGenerico<Usuario> {

    public DAOUsuario() {
        super(Usuario.class);
    }

    public int autoIdSensor() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.idSensor) FROM Sensor e ").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public Usuario getByEmail(String email, String senha) {
        try {
//            return (Usuario) em.createQuery("SELECT e FROM usuario e WHERE e.email_usuario = :email").setParameter("email",email).getSingleResult();
//            return (Usuario) em.createQuery("SELECT e FROM Usuario e WHERE e.emailUsuario LIKE :email").setParameter("email", email).getSingleResult();]

            Usuario u = (Usuario) em.createQuery("SELECT e FROM Usuario e WHERE e.senhaUsuario LIKE :senha AND e.emailUsuario LIKE :email ").setParameter(":email", email).setParameter(":senha", senha).getSingleResult();
//            Usuario u = (Usuario) em.createQuery("SELECT * FROM Usuario e WHERE e.senhaUsuario ='"+senha+"' AND e.emailUsuario ='"+email+"'").getSingleResult();
            if ((u.getNomeUsuario().equals(email)) && (u.getSenhaUsuario().equals(senha))) {
                return u;
            }
            return null;

        } catch (Exception e) {
            return null;
        }
    }
//
//    public List<Sensor> listById(int id) {
//        return em.createQuery("SELECT e FROM Sensor e WHERE e.idSensor = :id").setParameter("id", id).getResultList();
//    }
//
//    public List<Sensor> listInOrderNome() {
//        return em.createQuery("SELECT e FROM Sensor e ORDER BY e.nomeSensor").getResultList();
//    }
//
//    public List<Sensor> listInOrderId() {
//        return em.createQuery("SELECT e FROM Sensor e ORDER BY e.idSensor").getResultList();
//    }
//
//    public List<String> listInOrderNomeStrings(String qualOrdem) {
//        List<Sensor> lf;
//        if (qualOrdem.equals("id")) {
//            lf = listInOrderId();
//        } else {
//            lf = listInOrderNome();
//        }
//
//        List<String> ls = new ArrayList<>();
//        for (int i = 0; i < lf.size(); i++) {
//            ls.add(lf.get(i).getIdSensor() + "-" + lf.get(i).getNomeSensor());
//        }
//        return ls;
//    }
}
