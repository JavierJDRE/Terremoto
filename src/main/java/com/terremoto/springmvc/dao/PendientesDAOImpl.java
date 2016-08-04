/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.terremoto.springmvc.dao;

import java.io.Serializable;
import com.terremoto.springmvc.model.Pendiente;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author JavierDeLaRosa
 */
@Repository("pendientesDao")
public class PendientesDAOImpl extends AbstractDao<Integer, Pendiente> implements PendientesDao {



    @Override
    public void save(Pendiente pendiente) {
        persist(pendiente);
    }

    @Override
    public void deletePendiente(Pendiente pendiente) {
        delete(pendiente);
    }

    @Override
    public List<Pendiente> FindAllPendientes() {
        Criteria criteria = createEntityCriteria();
        Integer estatus = 1;
        criteria.add(Restrictions.eq("estatus", estatus));
        return (List<Pendiente>) criteria.list();
    }

    @Override
    public void update(Pendiente pendiente) {
        update(pendiente);
    }
    
    public int countFindAll(){
        Criteria criteria = createEntityCriteria();
        Integer estatus = 1;
        criteria.add(Restrictions.eq("estatus", estatus));
        return criteria.list().size();
    }

    @Override
    public Pendiente findById(Long id) {
        return getByKey(id);
    }

}
