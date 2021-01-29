//
//  LoginViewController.swift
//  Proyecto
//
//  Created by Jessica Villa on 24/01/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var username = ""
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func ingresarBtn(_ sender: UIButton) {
        username = userTF.text!
         self.ref.child("users").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
           let value = snapshot.value as? NSDictionary
           let password = value?["password"] as? String ?? ""
           let usernameFirebase = value?["username"] as? String ?? ""
            
           
            if(usernameFirebase == self.username){
                if(password == self.passwordTF.text!){
                    self.performSegue(withIdentifier: "iniciarSesion", sender: self)
                }
                else{
                    let alert = UIAlertController(title: "Contraseña incorrecta", message: "La contraseña no coincide con el usuario, favor de corregir.", preferredStyle: UIAlertController.Style.alert)
                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else{
                let alert = UIAlertController(title: "Usuario incorrecto", message: "El usuario no se encuentra registrado, favor de registrarse.", preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
          
           }) { (error) in
             //print(error.localizedDescription)
         }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "iniciarSesion"{
            let destino = segue.destination as! ViewController
            destino.recibirUsuario = username
        }
    }
    
}

