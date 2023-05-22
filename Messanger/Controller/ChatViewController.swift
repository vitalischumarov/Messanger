//
//  ChatViewController.swift
//  Messanger
//
//  Created by Vitali Schumarov on 17.05.23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [ ]

    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = "Vitalis Messenger"
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        print("The current user: \(Auth.auth().currentUser!.email!)")

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
    
    func loadData() {
        db.collection("messages").order(by: "date").addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
// Der querySnapshot enthält alle Informationen die gespeichert sind.
                for document in querySnapshot!.documents {
//                    print(document.data())
//                    print(document.data().keys)
// .data() liefert mir ein Dictionary mit den Werten
                    for all in document.data() {
                        if (all.key != "date") {
                            let newMessage = Message(sender: all.key, body: all.value as! String)
                            self.messages.append(newMessage)
                        }
//Mit der reloadDate() funktion kann ich mein TableView neu laden
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
//                print(self.messages)
            }
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
        if (Auth.auth().currentUser!.email! == messages[indexPath.row].sender) {
            cell?.backgroundColor = UIColor.blue
        } else {
            cell?.backgroundColor = UIColor.red
        }
        return cell!
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let messageBody = textField.text, let messageSender = Auth.auth().currentUser?.email {
//in data[..] werden die Angaben eingegeben, die gespeichert werden sollen
//"messages" ist die Collection unter der die Daten gespeichert werden. Diese kann man sich aussuchen.
            db.collection("messages").addDocument(data: [messageSender : messageBody, "date": Date().timeIntervalSince1970]) { error in
                if let e = error {
                  print("error")
                } else {
                    print("saved data")
                }
            }
        }
        self.view.endEditing(true)
        textField.text = ""
        return true
    }
}
