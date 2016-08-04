/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.terremoto.springmvc.controller;

import com.terremoto.springmvc.service.PendientesService;
import com.terremoto.springmvc.model.Pendiente;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

/**
 *
 * @author JavierDeLaRosa
 */
@RestController
public class PendientesController {

    @Autowired
    PendientesService pendientesService;

    @RequestMapping(value = "/pendientes/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Pendiente>> listAllUsers() {

        List<Pendiente> pendientes = pendientesService.FindAll();
        if (pendientes.isEmpty()) {
            return new ResponseEntity<List<Pendiente>>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
        }
        HttpHeaders headers = new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        return new ResponseEntity<List<Pendiente>>(pendientes, HttpStatus.OK);
    }

    @RequestMapping(value = "/pendientes/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Pendiente> getUser(@PathVariable("id") Long id) {
        System.out.println("Fetching User with id " + id);
        Pendiente pendientes = pendientesService.FindById(id);
        if (pendientes == null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<Pendiente>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Pendiente>(pendientes, HttpStatus.OK);
    }

    @RequestMapping(value = "/pendientes", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Pendiente> createPendiente(@RequestBody Pendiente pend) {
        pendientesService.savePendiente(pend);
        return new ResponseEntity<Pendiente>(pend, HttpStatus.OK);
    }

    @RequestMapping(value = "/pendientes/{id}", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Pendiente> updatePendiente(@RequestBody Pendiente pendiente) {
        pendientesService.savePendiente(pendiente);
        return new ResponseEntity<Pendiente>(pendiente, HttpStatus.OK);
    }

    @RequestMapping(value = "/pendientes/{id}", method = RequestMethod.DELETE)
    public void deletePendiente(@PathVariable("id") Long id, @RequestBody Pendiente pendiente, UriComponentsBuilder ucBuilder) {
        pendientesService.deletePendiente(pendiente);
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/pendientes/{id}").buildAndExpand(pendiente.getId()).toUri());
    }
}
