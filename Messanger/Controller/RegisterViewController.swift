//
//  RegisterViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text {
            if let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                  print("User created!!")
                    print(authResult)
                    self.emailTextfield.text = ""
                    self.passwordTextField.text = ""
                }
            }
        }
    }
}
