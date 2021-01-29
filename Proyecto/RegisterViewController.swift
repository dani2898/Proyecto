//
//  RegisterViewController.swift
//  Proyecto
//
//  Created by Mac13 on 23/01/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
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
    
    
    @IBAction func registrarBtn(_ sender: UIButton) {
        let user = userTF.text
        let password = passwordTF.text
        
        self.ref.child("users").child(user!).setValue(["username": user, "password":password])
        
        
        let alert = UIAlertController(title: "Registrado", message: "Registro exitoso, favor de iniciar sesión", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
       
    }
    
    
        
}
