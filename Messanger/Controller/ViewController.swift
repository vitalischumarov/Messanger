//
//  ViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: ConstanceType.goToRegisterSegue, sender: self)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: ConstanceType.goToLoginSegue, sender: self)
    }
}

