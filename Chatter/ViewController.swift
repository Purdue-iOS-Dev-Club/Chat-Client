//
//  ViewController.swift
//  Chatter
//
//  Created by Harjas Monga on 4/2/19.
//  Copyright © 2019 Harjas Monga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.joinButton.layer.cornerRadius = 15
        self.joinButton.clipsToBounds = true
        self.nameTextField.becomeFirstResponder()
    }
    
    @IBAction func nameUpdated(_ sender: UITextField) {
        self.joinButton.isEnabled = !(sender.text?.isEmpty ?? false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let chatVC = segue.destination as? ChatViewController else {return}
        if let name = nameTextField.text {
            chatVC.name = name
        }
    }

}

