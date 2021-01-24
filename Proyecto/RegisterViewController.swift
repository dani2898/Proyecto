//
//  RegisterViewController.swift
//  Proyecto
//
//  Created by Mac13 on 23/01/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        print(userTF.text)
        print(passwordTF.text)
    }
    
}
