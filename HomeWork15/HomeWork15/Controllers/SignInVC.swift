//
//  SignInVC.swift
//  HomeWork15
//
//  Created by  NovA on 22.08.23.
//

import UIKit

class SignInVC: BaseViewController {
    var userModel: UserModel?
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passTF: UITextField!
    @IBOutlet var errorLbl: UILabel!
    @IBOutlet var signInBtn: UIButton!

    private var isValidEmail = false { didSet { updateSignInBtnState() } }
    private var isValidPass = false { didSet { updateSignInBtnState() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
    }

    private func setupUI() {
        signInBtn.isEnabled = false
        errorLbl.isHidden = true
    }

    private func updateSignInBtnState() {
        if emailTF.text != "", passTF.text != "" {
            signInBtn.isEnabled = true
        }
    }

    @IBAction func emailActionTF(_ sender: UITextField) {
        if emailTF.text != "" {
            isValidEmail = true
        }
    }

    @IBAction func passActionTF(_ sender: UITextField) {
        if passTF.text != "" {
            isValidPass = true
        }
    }

    @IBAction func signInActionBtn(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        let signInModel = userDefaults.array(forKey: emailTF.text ?? "") as? [String] ?? []
        if passTF.text == signInModel[1]
        {
            
        }
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
