//
//  LoginViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "testHans@gmx.de"
        passwordTextField.text = "testhans"
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    if (error != nil) {
                        print(error!)
                        return
                    } else {
                        self?.emailTextField.text = ""
                        self?.passwordTextField.text = ""
                        self?.performSegue(withIdentifier: ConstanceType.goToLoginChat, sender: self)
                    }
                }
        }
    }
}
