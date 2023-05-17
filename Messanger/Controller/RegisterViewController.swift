//
//  RegisterViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func registerPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToChat", sender: self)
    }
}
