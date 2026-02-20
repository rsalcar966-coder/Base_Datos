export class Producto {
    //atributos
    constructor(
        private _cantidad: number,
        private _codBarras: string,
        private _fechaLanzamiento: Date,
        private _marca: string,
        private _modelo: string,
        private _precio: number
    ){}

    get cantidad(): number {
        return this.cantidad;
    }

    set cantidad(value: number) {
        this.cantidad = value;
    }

    get marca(): string {
        return this._marca;
    }

    set marca(value: string) {
        this._marca = value;
    }       
}
