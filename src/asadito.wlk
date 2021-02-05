class Persona {
	var property posicion 
	const property elementosCerca = #{}
	var tipoDeCriterioPasarElementos
	var tipoDeEleccionDeComida
	const property registroComidas = []
	
	
	method pedirElementoA(otroComensal,elemento){
		if (otroComensal.tieneElemento(elemento)){
			otroComensal.pasarElemento(self,elemento)
		}
	}

	method pasarElemento(otroComensal,elemento){
		tipoDeCriterioPasarElementos.pasarElementoAl(otroComensal,elemento)
	}
	
	method pasarCualquierElementoAMano(otroComensal){
		const elementoQueDa = elementosCerca.anyOne()
		self.quitarElemento(elementoQueDa)	
		otroComensal.agregarElemento(elementoQueDa)
	}
	
	method pasarTodosLosElementos(otroComensal){
		otroComensal.elementosCerca().addAll(elementosCerca)
		elementosCerca.clear()
	}
	
	method quitarElemento(elemento){
		elementosCerca.remove(elemento)
	}
	
	method agregarElemento(elemento){
		elementosCerca.add(elemento)
	}
	
	method tieneElemento(elemento){
		return elementosCerca.contains(elemento)
	}
	
	method cambiarPosicionMesaCon(otroComensal){
		const miNuevaPosicion = otroComensal.posicion() 
		const miViejaPosicion = self.posicion()
		otroComensal.posicion(miViejaPosicion)
		self.posicion(miNuevaPosicion)
	}
	
	method pasarElementoPedido(otroComensal,elemento){
		self.quitarElemento(elemento)	
		otroComensal.agregarElemento(elemento)
		
	}

	method comer(bandejaDeComida){
		if (self.eligeLaComida(bandejaDeComida)){
			registroComidas.add(bandejaDeComida)
		}
			
	}

	method eligeLaComida(bandejaDeComida){
		tipoDeEleccionDeComida.decideComer(bandejaDeComida)
		
	}
	
	method esPipon(){
		return registroComidas.any{comida => comida.esPesada()}
	}

	method laEstaPasandoBien(){
		return self.comioAlgo()
	}

	method comioAlgo(){
		return !registroComidas.isEmpty()
	}
	
	method sentadoEnPosicion(){
		return posicion == 1
	}
	
	method comioCarne(){
		return registroComidas.any{comida => comida.esCarne()}
	}
	
	method menosDeTresElementosCerca(){
		return elementosCerca.size() < 3
	}
}
//Personas particulares

object moni inherits Persona{
	
	override method laEstaPasandoBien(){
		super()
		return self.sentadoEnPosicion()
		
	}
}

object facu inherits Persona{
	
	override method laEstaPasandoBien(){
		super()
		return self.comioCarne()
		
	}
}

object vero inherits Persona{
	
	override method laEstaPasandoBien(){
		super()
		return self.menosDeTresElementosCerca()
		
	}
}


//criterios

object sordera {
	var persona 
	
	method pasarElementoAl(otroComensal,elemento){
		persona.pasarCualquierElementoAMano(otroComensal)
	}
}

object tranquilidad {
	var persona 
	
	method pasarElementoAl(otroComensal,elemento){
		persona.pasarTodosLosElementos(otroComensal)
	}
}

object muyHablador {
	var persona 
	
	method pasarElementoAl(otroComensal,elemento) {
		persona.cambiarPosicionMesaCon(otroComensal)
	}
}

object normalidad {
	var persona 
	
	method pasarElementoAl(otroComensal,elemento){
		persona.pasarElementoPedido(otroComensal,elemento)
	}	

}
	
// Bandejas de comida

class Bandeja {
	
	var property esCarne 
	var property calorias
	
	method esPesada(){
		return calorias > 500
	}
	
}


// Tipos para eleccion de comida 

object vegeteriano {

		method decideComer(bandejaDeComida){
		return !bandejaDeComida.esCarne()
	}
}

object dietetico {
	var OMS
	
	method decideComer(bandejaDeComida){
		return OMS.recomendacionCalorias() >= bandejaDeComida.calorias()
	}
}

object alternado {
	// no se como se alternan 
}

object combinacion {
	// tampoco se como hacer para que todas se cumplan 
}


object OMS {
	
	var property recomendacionCalorias
}