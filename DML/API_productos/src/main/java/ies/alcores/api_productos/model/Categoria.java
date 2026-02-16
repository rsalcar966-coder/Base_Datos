package ies.alcores.api_productos.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Categoria {

    @Id
    private long id;
    private String nombre;
}
