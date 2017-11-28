/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author maisa
 */
@Entity
@Table(name = "medicamento")
@XmlRootElement
public class Medicamento implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_medicamento")
    private Integer idMedicamento;
    @Basic(optional = false)
    @Column(name = "nome_medicamento")
    private String nomeMedicamento;
    @Basic(optional = false)
    @Column(name = "dt_inicio")
    private String dtInicio;
    @Column(name = "dt_fim")
    @Temporal(TemporalType.DATE)
    private String dtFim;
    @Basic(optional = false)
    @Column(name = "intervalo_horas")
    private String intervaloHoras;
    @JoinColumn(name = "fk_idusuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuario fkIdusuario;

    public Medicamento() {
    }

    public Medicamento(Integer idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    public Medicamento(Integer idMedicamento, String nomeMedicamento, String dtInicio, String dtFim, String intervaloHoras) {
        this.idMedicamento = idMedicamento;
        this.nomeMedicamento = nomeMedicamento;
        this.dtInicio = dtInicio;
        this.dtFim = dtFim;
        this.intervaloHoras = intervaloHoras;
    }

    public Integer getIdMedicamento() {
        return idMedicamento;
    }

    public void setIdMedicamento(Integer idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    public String getNomeMedicamento() {
        return nomeMedicamento;
    }

    public void setNomeMedicamento(String nomeMedicamento) {
        this.nomeMedicamento = nomeMedicamento;
    }

    public String getDtInicio() {
        return dtInicio;
    }

    public void setDtInicio(String dtInicio) {
        this.dtInicio = dtInicio;
    }

    public String getDtFim() {
        return dtFim;
    }

    public void setDtFim(String dtFim) {
        this.dtFim = dtFim;
    }


    public String getIntervaloHoras() {
        return intervaloHoras;
    }

    public void setIntervaloHoras(String intervaloHoras) {
        this.intervaloHoras = intervaloHoras;
    }

    public Usuario getFkIdusuario() {
        return fkIdusuario;
    }

    public void setFkIdusuario(Usuario fkIdusuario) {
        this.fkIdusuario = fkIdusuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMedicamento != null ? idMedicamento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Medicamento)) {
            return false;
        }
        Medicamento other = (Medicamento) object;
        if ((this.idMedicamento == null && other.idMedicamento != null) || (this.idMedicamento != null && !this.idMedicamento.equals(other.idMedicamento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Medicamento[ idMedicamento=" + idMedicamento + " ]";
    }
    
}
