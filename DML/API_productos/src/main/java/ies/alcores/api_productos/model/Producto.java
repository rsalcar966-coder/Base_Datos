package ies.alcores.api_productos.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.util.Date;

@Entity
public class Producto {

    @Id
    private String codBarras;
    private String marca;
    private String modelo;
    private int cantidad;
    private double precio;
    private Date fechaLanzamiento;

}