// ===================================================================================================
// Copyright © 2022 GenesysCloud(Genesys).
// GenesysCloud SDK.
// All rights reserved.
// ===================================================================================================

import Foundation
import UIKit
import GenesysCloud

class AccountDetailsViewController: UIViewController {
    @IBOutlet weak var deploymentIdTextField: UITextField!
    @IBOutlet weak var domainIdTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var startChatButton: UIButton!
    @IBOutlet weak var loggingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupFields() {
        deploymentIdTextField.text = UserDefaults.deploymentId
        domainIdTextField.text = UserDefaults.domainId
        tokenTextField.text = UserDefaults.token
        
        loggingSwitch.setOn(UserDefaults.logging, animated: true)
    }

    @IBAction func startChatButtonTapped(_ sender: UIButton) {
        if deploymentIdTextField.text?.isEmpty == true || domainIdTextField.text?.isEmpty == true {
            markInvalidTextFields(requiredTextFields: [deploymentIdTextField, domainIdTextField])
            
            let alert = UIAlertController(title: nil, message: "One or more required fields needed, please check & try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)

        } else {
            let account = MessengerAccount(deploymentId: deploymentIdTextField.text ?? "",
                                           domain: domainIdTextField.text ?? "",
                                           tokenStoreKey: tokenTextField.text ?? "",
                                           logging: loggingSwitch.isOn)
            
            updateUserDefaults()
            openMainController(with: account)

        }
    }
    
    private func markInvalidTextFields(requiredTextFields: [UITextField]) {
        for field in requiredTextFields {
            if field.text?.isEmpty == true {
                field.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
        }
    }
        
    private func updateUserDefaults() {
        UserDefaults.deploymentId = deploymentIdTextField.text ?? ""
        UserDefaults.domainId = domainIdTextField.text ?? ""
        UserDefaults.token = tokenTextField.text ?? ""
        UserDefaults.logging = loggingSwitch.isOn
    }
    
    private func openMainController(with account: MessengerAccount) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatWrapperViewController") as! ChatWrapperViewController
        controller.messengerAccount = account
        
        present(controller, animated: true)
    }
}