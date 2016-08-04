/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.terremoto.springmvc.service;

import com.terremoto.springmvc.model.Pendiente;
import java.util.List;
/**
 *
 * @author JavierDeLaRosa
 */
public interface PendientesService {
    Pendiente FindById(Long id);
    void savePendiente(Pendiente pendiente);
    void deletePendiente(Pendiente pendiente);
    List<Pendiente> FindAll();
}
