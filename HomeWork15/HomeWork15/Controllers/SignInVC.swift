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

    @IBOutlet var centerYConstraint: NSLayoutConstraint!
    private var isValidEmail = false { didSet { updateSignInBtnState() } }
    private var isValidPass = false { didSet { updateSignInBtnState() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        if let userModel = UserDefaultsService.authorizationUser() {
            let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
            guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
            mainVC.userModel = userModel
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passTF.text = ""
    }

    private func setupUI() {
        signInBtn.isEnabled = false
        errorLbl.isHidden = true
        navigationController?.navigationBar.isHidden = true
        passTF.layer.cornerRadius = 17.0
        passTF.layer.masksToBounds = true
        emailTF.layer.cornerRadius = 17.0
        emailTF.layer.masksToBounds = true
        signInBtn.layer.cornerRadius = 17.0
        signInBtn.layer.masksToBounds = true
    }

    private func updateSignInBtnState() {
        if emailTF.text != "", passTF.text != "" {
            signInBtn.isEnabled = true
        } else { signInBtn.isEnabled = false }
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
        if let email = emailTF.text,
           let pass = passTF.text,
           let userModel = UserDefaultsService.getUserModel(email: email, pass: pass)
        {
            let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
            guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
            mainVC.userModel = userModel
            navigationController?.pushViewController(mainVC, animated: true)
            errorLbl.isHidden = true
        } else { errorLbl.isHidden = false }
    }

    private func goToMainController() {
        
    }
}
