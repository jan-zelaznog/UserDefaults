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
        super.init()
        leeInfo()
    }
    /*  FIN PATRON SINGLETON  */
    
    // variables de instancia
    var arregloJSON : [Persona] = []
    
    // métodos de instancia
    func buscaPersona(correo:String) -> Persona? {
        // HOF - High Order Function
        let tmp = arregloJSON.filter { personita in
            personita.correo == correo
        }
        if tmp.count > 0 {
            return tmp.first
        }
        /*
        for personita in arregloJSON {
            if personita.correo == correo {
                return personita
            }
        } 
        */
        return nil
    }
    
    func leeInfo() {
        // leer el archivo JSON en la carpeta Documents y convertirlo a un arreglo de Persona
        if var ruta = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first {
            ruta.append(component:Utils.LOGIN_FILE)
            // 1) el archivo no existe
            if !FileManager.default.fileExists(atPath:ruta.path) {
                print ("el archivo no existe, no hay que hacer nada más")
            }
            else {
                // 2) el archivo ya existe, leer el archivo y convertirlo a arreglo JSON
                do {
                    // obtenemos el contenido del archivo como un objeto Data
                    let losBytes = try Data(contentsOf:ruta)
                    // transformar (serializar) el arreglo de Bytes, al objeto especifico que necesitamos
                    let tmp = try JSONDecoder().decode([Persona].self, from:losBytes)
                    if !tmp.isEmpty {
                        arregloJSON = tmp
                    }
                } catch {
                    print ("no se puede recuperar el contenido del archivo \(error.localizedDescription)")
                }
            }
        }
    }
    
    func guardaInfo() {
        // escribir el arreglo JSON como un archivo en la carpeta Documents
        // leer el archivo JSON en la carpeta Documents y convertirlo a un arreglo de Persona
        if var ruta = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first {
            ruta.append(component:Utils.LOGIN_FILE)
            do {
                let losBytes = try JSONEncoder().encode(arregloJSON)
                try losBytes.write(to:ruta, options:.atomic)
            } catch {
                print ("no se puede convertir el arreglo en un archivo \(error.localizedDescription)")
            }
        }
    }
    
    func guardaPersona(_ unaPersona:Persona) {
        arregloJSON.append(unaPersona)
        guardaInfo()
    }
}
