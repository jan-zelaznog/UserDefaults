//
//  HomeViewController.swift
//  foo
//
//  Created by Ángel González on 05/10/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Crear las vistas con código:
        // 1) instanciar los objetos y especificarles el frame (posicionamiento estático)
        let btnSalir = UIButton(type:.custom)
        btnSalir.frame = CGRect(x:20, y:50, width:120, height:44)
        // configurar el objeto según se necesite
        btnSalir.backgroundColor = .red
        btnSalir.setTitle("cerrar sesión", for:.normal)
        btnSalir.addTarget(self, action:#selector(btnSalirTouch), for:.touchUpInside)
        // centrar el objeto:
        //btnSalir.center = view.center
        // agregar el objeto a la vista
        view.addSubview(btnSalir)
    }
    
    @objc func btnSalirTouch () {
        print ("touched")
        // eliminar la bandera de login
        let ud = UserDefaults.standard
        ud.removeObject(forKey:Utils.LOGIN_KEY)
        // retira este view controller de la jerarquía de vistas del app
        dismiss(animated:true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
