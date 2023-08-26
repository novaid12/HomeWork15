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

    @IBAction func visibleActionSW(_ sender: UISwitch) {
        if sender.isOn {
            passTF.isSecureTextEntry = true
        } else { passTF.isSecureTextEntry = false }
    }
    @IBAction func signInActionBtn(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        let signInModel = userDefaults.array(forKey: emailTF.text ?? "") as? [String] ?? []
        if signInModel != [], passTF.text == signInModel[1] {
            let userModel = UserModel(name: signInModel[0], email: emailTF.text ?? "", pass: signInModel[1])
            let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
            guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
            mainVC.userModel = userModel
            show(mainVC, sender: nil)
        } else { errorLbl.isHidden = false }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
//        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
//        guard let userModel = sender as? UserModel else { return }
//        mainVC.userModel = userModel
//    }
}
