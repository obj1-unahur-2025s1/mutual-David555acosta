class Viaje {
  const property idiomas = #{}
  method sirveParaBroncearse()
  method diasDeActividad()
  method implicaEsfuerzo()

  method esViajeInteresante() = idiomas.size() > 1

  method esRecomendadaParaSocio(socioX) = self.esViajeInteresante() and
                                         socioX.estaActividadAtraeAlSocio(self) and
                                         not socioX.actividadesRealizadas().contains(self)

}

class ViajesPlaya inherits Viaje {
  var largoDePlaya

  override method diasDeActividad() = largoDePlaya / 500
  override method implicaEsfuerzo() = largoDePlaya > 1200
  override method sirveParaBroncearse() = true 
}


class ExcursionCiudad inherits Viaje {
  var cantidadAtracciones

  override method diasDeActividad() =  cantidadAtracciones / 2
  override method implicaEsfuerzo() =  5 >= cantidadAtracciones <= 8
  override method sirveParaBroncearse() = false
  override method esViajeInteresante() = super() || cantidadAtracciones == 5
}


class ExcursionesCiudadTropical inherits ExcursionCiudad {
  override method diasDeActividad() = super() + 1
  override method sirveParaBroncearse() = true
}

class SalidaTrekking inherits Viaje {
  var kmRecorribles
  var diasDeSol
  override method diasDeActividad() = kmRecorribles / 50
  override method implicaEsfuerzo() = kmRecorribles > 80
  override method sirveParaBroncearse() = (diasDeSol > 200 || (100 >= diasDeSol <= 200)) 
                                          and kmRecorribles >= 120 
  override method esViajeInteresante() = super() and diasDeSol > 140
}

class ClasesGimnacia {
  method idiomas() = "español"
  method diasDeActividad() =  1
  method implicaEsfuerzo() = true
  method sirveParaBroncesarse() = false
  method esRecomendadaParaSocio(socioX) = 20 >= socioX.edad() <= 30
}


class Socio {
  var edad
  method edad() = edad 
  const idiomasQueHabla = #{}
  method idiomasQueHabla() = idiomasQueHabla 
  var maximoActividades
  const actividadesRealizadas = #{}
  const actividadesForzadas = #{}

  method realizarActividad(actividad) {
    if (maximoActividades == actividadesRealizadas.size()) {
      self.error("se alcanzo el tope de actividades")
    } else {
      actividadesRealizadas.add(actividad)
    }
  }

  method actividadesRealizadas() = actividadesRealizadas 

  method esAdoradorDelSol() {
    return actividadesRealizadas.all({a => a.sirveParaBroncearse()})
  }

  method todasLasActividadesForzadas() {
    actividadesForzadas.addAll(actividadesRealizadas.filter({a => a.implicaEsfuerzo()}))
  }

  method estaActividadAtraeAlSocio(actividad)
}


class SocioTranquilo inherits Socio {
  override method estaActividadAtraeAlSocio(actividad) {
    return actividad.diasDeActividad() >= 4
  }
}

class SocioCoherente inherits Socio {
  override method estaActividadAtraeAlSocio(actividad) {
    if (self.esAdoradorDelSol()) {
      return actividad.sirveParaBroncearse()
    } else {
      return actividad.implicaEsfuerzo()
    }
  }
}

class SocioRelajado inherits Socio {
  override method estaActividadAtraeAlSocio(actividad) {
    return not idiomasQueHabla.intersection(actividad.idiomas()).isEmpty()
  }
}


class TallerLiterario {
  var libros = #{}
  
  method idiomasUsados() = libros.map({l => l.idioma()})
  method diasQueLleva() = libros.size() + 1
  
  method todosLosLibrosSonDelMismoAutor() = libros.map({l=>l.nombreAutor()}).asSet().size() == 1
  method hayLibroDeMasDe500pag() = libros.any({l => l.cantidadPaginas() > 500}) 
  method implicaEsfuerz() = self.hayLibroDeMasDe500pag() || (self.todosLosLibrosSonDelMismoAutor() and
                           libros.size() > 1)

  method sirveParaABroncearse() = false
  method esRecomendadaParaSocio(socioX) = socioX.idiomasQueHabla() > 1     
}


class Libro {
  var idioma
  var cantidadPaginas
  var nombreAutor

  method idioma() = idioma
  method cantidadPaginas() = cantidadPaginas
  method nombreAutor() = nombreAutor

    method initialize(){
    if(cantidadPaginas < 1) {
      self.error("No se puede poner un numero negativo en las pag , debe ser mayor o igual a 1")
    }
  }
}
