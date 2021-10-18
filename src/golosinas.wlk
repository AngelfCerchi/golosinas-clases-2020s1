/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
class Golosina{
	method estaBaniada() = false
}
class Bombon inherits Golosina{
	var peso = 15
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }

}

class BombonDuro inherits Bombon{
	override method mordisco() { peso = peso -1}
	method gradoDureza(){
		if(peso >12){
			return 3
		}else{
			if(peso.between(8,12)){
				return 2
			}else{
				return 1
			}
		}
	}
}
class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	override method estaBaniada() = true
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Alfajor inherits Golosina{
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo inherits Golosina{
	var peso = 5
	var sabor
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso - 1 }
	method sabor() { return sabor }
	method libreGluten() { return true }
}

class CarameloRelleno inherits Caramelo{
	override method mordisco() { super()  sabor = chocolate}
	override method precio() = super() +1
}

class Chupetin inherits Golosina{
	var peso = 7
	
	method precio() { return 2 }
	method peso() { return peso }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea inherits Golosina{
	var peso = 250
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}
class ObleaCrujiente inherits Oblea{
	var cantidadDeMordisco = 0
	override method mordisco(){ 
		super () 
		if(cantidadDeMordisco < 3){
			peso= peso -3
			cantidadDeMordisco+=1
		}
		cantidadDeMordisco+=1		
	}
}
class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class ChocolatinVIP inherits Chocolatin{
	method humedad() = 0.randomUpTo(1)
	override method peso() = super() * (1 + self.humedad())
	
}
class ChocolatinPremiun inherits ChocolatinVIP{
	override method humedad() = super()/2
}
class Tuttifrutti inherits Golosina{
	var libreDeGluten
	var sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
