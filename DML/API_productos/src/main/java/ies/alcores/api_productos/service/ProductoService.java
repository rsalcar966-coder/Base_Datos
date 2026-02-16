package ies.alcores.api_productos.service;

import ies.alcores.api_productos.model.Producto;
import ies.alcores.api_productos.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {
    private ProductoService productoRepositorio;
    @Autowired

    public List<Producto> findAll(){
        return this.productoRepositorio.findAll();
    }

}
