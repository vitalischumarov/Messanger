//
//  ChatViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [
        Message(sender: "Peter", body: "Ich bin Peter"),
        Message(sender: "Das Wort", body: "Gott liebt dich"),
        Message(sender: "Goal", body: "Ich will Programmierer werden")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = "Vitalis Messenger"
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("loged out")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
//    Diese Funktion legt fest, was in der Zelle angezeigt werden soll. Das Property indexPath
//    steht für jede einzelne Zelle. Gibt es also 5 Zellen, wird der Wert von indexPath von 1 - 5
//    hochgehen.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell
        cell?.messageLabel.text = messages[indexPath.row].body
        cell?.userLabel.text = messages[indexPath.row].sender
        return cell!
    }
}
