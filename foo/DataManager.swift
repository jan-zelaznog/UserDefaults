//
//  DataManager.swift
//  foo
//
//  Created by Ángel González on 05/10/24.
//

import Foundation

class DataManager:NSObject {
    /*  PATRON SINGLETON  */
    // variable única compartida 
    static let shared = DataManager()
    // para que no se pueda instanciar, hay que volver privado el constructor
    private override init() {
        // cualquier código que se necesite ejecutar al crear la variable única
    }
    /*  FIN PATRON SINGLETON  */
    
    // variables de instancia
    var arregloJSON : [Persona] = []
    
    // métodos de instancia
    func leeInfo() {
        // leer el archivo JSON en la carpeta Documents y convertirlo a un arreglo de Persona
    }
    
    func guardaInfo() {
        // escribir el arreglo JSON como un archivo en la carpeta Documents
    }
    
    func guardaPersona(_ unaPersona:Persona) {
        arregloJSON.append(unaPersona)
        guardaInfo()
    }
}
