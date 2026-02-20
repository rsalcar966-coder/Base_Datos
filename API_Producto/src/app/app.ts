import { Component, Signal, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { ProductosService } from '../servicios/productos-service';
import { toSignal } from '@angular/core/rxjs-interop';
import { Producto } from '../models/producto';

@Component({
  selector: 'app-root',
  imports: [],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
//atributos
public productos: Signal<Producto[]>

//Constructor
constructor(private productosService: ProductosService){
  this.productos = toSignal(this.productosService.getAllProductos(),{initialValue: []});
}
//Getters y setters

}
