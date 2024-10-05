//
//  ViewController.swift
//  foo
//
//  Created by Angel Gonzalez Torres on 04/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Validar si ya tiene iniciada la sesión
        let ud = UserDefaults.standard
        if ud.string(forKey:Utils.LOGIN_KEY) == "OK" {
            performSegue(withIdentifier:"loginOK", sender: self)
        }
    }

    @IBAction func btnRegistroTouch(_ sender: Any) {
        // navegar a otro viewcontroller sin usar segues en el storyboard
        let rvc = RegisterViewController()
        // a partir de iOS 13 la presentación modal por defecto es en modo "card"
        // si quieres presentación fullscreen:
        rvc.modalPresentationStyle = .fullScreen
        present(rvc, animated: true)
    }
    
    @IBAction func btnEntrarTouch(_ sender: Any) {
        // validar si los cuadros de texto no están vacios
        var mensaje = ""
        // desempaquetamos los strings en los opcionales
        let correo = txtCorreo.text ?? ""
        let contraseña = txtContraseña.text ?? ""
        if  correo.isEmpty {
            mensaje = "Por favor indique su correo"
        }
        else if contraseña.isEmpty {
            mensaje = "Debe indicar su contraseña"
        }
        // Otras validaciones....
        else { // validamos que parezca un correo válido
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let correoValido = NSPredicate(format:"SELF MATCHES %@", regex)
            if !correoValido.evaluate(with: correo) {
                mensaje = "No es un correo válido"
            }
        }
        if mensaje.isEmpty {
            print( "Todo OK. hacer el login" )
            // TODO: buscar el correo, y comparar el password
            // ...
            // guardar la bandera de login Y navegar a HOME
            let ud = UserDefaults.standard
            ud.set("OK", forKey:Utils.LOGIN_KEY)
            performSegue(withIdentifier:"loginOK", sender: self)
        }
        else {
            let ac = UIAlertController(title: "hola", message:mensaje, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
    
}

