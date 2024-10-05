//
//  RegisterViewController.swift
//  foo
//
//  Created by Ángel González on 05/10/24.
//

import UIKit

class RegisterViewController: UIViewController {

    var tecladoArriba = false
    var scrollView:UIScrollView?
    var txtNom:UITextField?
    var txtApp:UITextField?
    var txtMail:UITextField?
    var txtMail2:UITextField? // Optional/UITextField  por defecto su valor es nil
    var txtPass: UITextField!
    var textFieldWidth:CGFloat!  // Herencia de ObjC - Float
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // 1) instanciar los objetos
        let btnSalir = UIButton(type:.custom)
        // configurar el objeto según se necesite
        btnSalir.backgroundColor = .red
        btnSalir.setTitle("cancelar", for:.normal)
        btnSalir.addTarget(self, action:#selector(btnSalirTouch), for:.touchUpInside)
        // agregar el objeto nuevo a la vista, antes de setear constraints
        view.addSubview(btnSalir)
        // posicionar el objeto, dinámicamente, usando constraints
        btnSalir.translatesAutoresizingMaskIntoConstraints = false
        btnSalir.widthAnchor.constraint(equalToConstant:100).isActive = true
        btnSalir.heightAnchor.constraint(equalToConstant:45).isActive = true
        // considerar que la dirección de los constrainst afecta al valor de la constante
        btnSalir.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-50).isActive = true
        btnSalir.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:-25).isActive = true
        
        // 1) instanciar los objetos
        let btnRegistra = UIButton(type:.custom)
        // configurar el objeto según se necesite
        btnRegistra.backgroundColor = .green
        btnRegistra.setTitle("registrar", for:.normal)
        btnRegistra.setTitleColor(.darkGray, for: .normal)
        btnRegistra.addTarget(self, action:#selector(btnRegistraTouch), for:.touchUpInside)
        // agregar el objeto nuevo a la vista, antes de setear constraints
        view.addSubview(btnRegistra)
        // posicionar el objeto, dinámicamente, usando constraints
        btnRegistra.translatesAutoresizingMaskIntoConstraints = false
        btnRegistra.widthAnchor.constraint(equalToConstant:100).isActive = true
        btnRegistra.heightAnchor.constraint(equalToConstant:45).isActive = true
        // considerar que la dirección de los constrainst afecta al valor de la constante
        btnRegistra.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-50).isActive = true
        btnRegistra.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:25).isActive = true
        self.buildUX()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // El NotificationCenter registra los eventos que ocurren en el dispositivo
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoAparece(_ :)), name:UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoDesaparece(_ :)), name:UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func btnRegistraTouch() {
        // TODO: agregar todas las validaciones para confirmar que los datos son correctos
        /*
         ...
         */
        guard let nombre = txtNom?.text,
              let apellidos = txtApp?.text,
              let correo = txtMail?.text,
              let password = txtPass.text
        else { return }
        // crear una copia de "Persona"
        let persona=Persona(nombre:nombre, apellidos:apellidos, correo:correo, password:password)
        DataManager.shared.guardaPersona(persona)
        dismiss(animated: true)
    }
    
    @objc func tecladoAparece(_ notificacion:Notification) {
        if tecladoArriba { return }
        ajustarVista(notificacion, true)
    }
    
    @objc func tecladoDesaparece(_ notificacion:Notification) {
        ajustarVista(notificacion, false)
    }
    
    func ajustarVista(_ notification:Notification, _ up:Bool) {
        let info:Dictionary = notification.userInfo!
        let value = info [UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let frameTeclado = value.cgRectValue
        var contentSize = self.scrollView!.contentSize
        if up {
            contentSize.height += frameTeclado.size.height;
        }
        else {
            contentSize.height -= frameTeclado.size.height;
        }
        self.scrollView!.contentSize = contentSize;
        self.tecladoArriba = up
    }
    
    func buildUX() {
        textFieldWidth = (Utils.SCREEN_WIDTH - (Utils.kSeparator * 2))
        self.scrollView = UIScrollView(frame:CGRect(x:0.0, y:40.0, width:Utils.SCREEN_WIDTH, height:Utils.SCREEN_HEIGHT - 140))
        self.view.addSubview(self.scrollView!)
        var laY = Utils.kSeparator
        let lbl0 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl0.font = Utils.TITLE_FONT
        lbl0.text = "INFORMACION PERSONAL"
        self.scrollView!.addSubview(lbl0)
        laY += Utils.kLabelHeight + Utils.kSeparator
        let lbl1 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl1.font = Utils.REG_FONT
        lbl1.text = "Nombre (s)"
        self.scrollView!.addSubview(lbl1)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtNom = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtNom!.backgroundColor = Utils.txtBackColor
        self.txtNom!.textColor = Utils.txtForeColor
        self.scrollView!.addSubview(self.txtNom!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl2 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl2.font = Utils.REG_FONT
        lbl2.text = "Apellido (s)"
        self.scrollView!.addSubview(lbl2)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtApp = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtApp!.backgroundColor = Utils.txtBackColor
        self.txtApp!.textColor = Utils.txtForeColor
        self.scrollView!.addSubview(self.txtApp!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl3 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl3.font = Utils.REG_FONT
        lbl3.text = "Correo electrónico"
        self.scrollView!.addSubview(lbl3)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtMail = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtMail!.backgroundColor = Utils.txtBackColor
        self.txtMail!.keyboardType = .emailAddress
        self.txtMail!.autocapitalizationType = UITextAutocapitalizationType.none
        self.txtMail!.autocorrectionType = .no
        self.scrollView!.addSubview(self.txtMail!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl4 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl4.font = Utils.REG_FONT
        lbl4.text = "Confirme su correo"
        self.scrollView!.addSubview(lbl4)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtMail2 = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtMail2!.backgroundColor = Utils.txtBackColor
        self.txtMail2!.keyboardType = .emailAddress
        self.txtMail2!.autocapitalizationType = UITextAutocapitalizationType.none
        self.txtMail2!.autocorrectionType = .no
        self.scrollView!.addSubview(self.txtMail2!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl5 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl5.font = Utils.REG_FONT
        lbl5.text = "Contraseña"
        self.scrollView!.addSubview(lbl5)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtPass = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtPass!.backgroundColor = Utils.txtBackColor
        self.scrollView!.addSubview(self.txtPass!)
        self.scrollView!.contentSize = (scrollView?.frame.size)!
        let tap = UITapGestureRecognizer(target: self, action:#selector(tapped))
        self.scrollView!.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        // first responder se refiere al objeto que requiere entrada de texto, y por eso aparece el teclado
        // para que desaparezca el teclado, hay que volver nulo el first responder
        txtNom?.resignFirstResponder()
        txtApp?.resignFirstResponder()
        txtMail?.resignFirstResponder()
        txtMail2?.resignFirstResponder()
        txtPass.resignFirstResponder()
    }
    
    @objc func btnSalirTouch () {
        dismiss(animated: true)
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
