import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Producto } from '../models/producto';

@Injectable({
  providedIn: 'root',
})
export class ProductosService {
  //atributos
  private endpoint: string = 'http://localhost:8080/api/productos';

  //Constructor
  constructor(private http: HttpClient){}

//Getters y setters
public getAllProductos(): Observable<Producto[]> {
  return this.http.get<Producto[]>(this.endpoint);
}
}
