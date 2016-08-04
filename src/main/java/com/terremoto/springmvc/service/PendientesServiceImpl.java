/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.terremoto.springmvc.service;

import com.terremoto.springmvc.model.Pendiente;
import com.terremoto.springmvc.dao.PendientesDao;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author JavierDeLaRosa
 */
@Service("pendientesService")
@Transactional
public class PendientesServiceImpl implements PendientesService{
    
    @Autowired
    PendientesDao pendientesDao;

    @Override
    public Pendiente FindById(Long id) {
        return this.pendientesDao.findById(id);
    }

    @Override
    public void savePendiente(Pendiente pendiente) {
        this.pendientesDao.save(pendiente);
    }


    @Override
    public void deletePendiente(Pendiente pendiente) {
        this.pendientesDao.deletePendiente(pendiente);
    }

    @Override
    public List<Pendiente> FindAll() {
       return this.pendientesDao.FindAllPendientes();
    }
    
}
