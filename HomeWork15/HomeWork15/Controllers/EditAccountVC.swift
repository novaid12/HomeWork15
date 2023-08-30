//
//  EditAccountVC.swift
//  HomeWork15
//
//  Created by  NovA on 30.08.23.
//

import UIKit

class EditAccountVC: BaseViewController {
    var userModel: UserModel?
    /// email
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var errorEmailLbl: UILabel!
    /// name
    @IBOutlet var nameTF: UITextField!
    /// old pass
    @IBOutlet var oldPassTF: UITextField!
    @IBOutlet var errorOldPassLbl: UILabel!
    @IBOutlet var visibleOldPassSwitch: UISwitch!
    /// new password
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var switchVisiblePass: UISwitch!
    @IBOutlet var errorPassLbl: UILabel!
    /// strongPassIndicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    /// confPass
    @IBOutlet var confPassTF: UITextField!
    @IBOutlet var cofirmVisiblePass: UISwitch!
    @IBOutlet var errorConfPassLbl: UILabel!
    /// saveBtn
    @IBOutlet var saveBtn: UIButton!
    /// scrollView
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var errorDataLbl: UILabel!
    private var passwordStrength: PasswordStrength = .veryWeak

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        setupUI()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = userModel?.email
        nameTF.text = userModel?.name
    }

    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        emailTF.layer.cornerRadius = 17.0
        emailTF.layer.masksToBounds = true
        nameTF.layer.cornerRadius = 17.0
        nameTF.layer.masksToBounds = true
        oldPassTF.layer.cornerRadius = 17.0
        oldPassTF.layer.masksToBounds = true
        passwordTF.layer.cornerRadius = 17.0
        passwordTF.layer.masksToBounds = true
        confPassTF.layer.cornerRadius = 17.0
        confPassTF.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 17.0
        saveBtn.layer.masksToBounds = true
        saveBtn.isEnabled = true
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
    }

    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @IBAction func emailActionTF(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email)
        {
            errorEmailLbl.isHidden = false
            errorEmailLbl.text = "Email is Valid!"
            errorEmailLbl.textColor = .green
        } else {
            errorEmailLbl.isHidden = false
            errorEmailLbl.text = "Error: bad email"
            errorEmailLbl.textColor = .red
        }
    }

    private func setupStrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }

    @IBAction func oldPassAction(_ sender: UITextField) {
        if userModel?.pass == oldPassTF.text {
            errorOldPassLbl.isHidden = false
            errorOldPassLbl.text = "Old pass is valid"
            errorOldPassLbl.textColor = .green
        } else {
            errorOldPassLbl.isHidden = false
            errorOldPassLbl.text = "Old pass is not valid"
            errorOldPassLbl.textColor = .red
        }
    }

    @IBAction func passActionTF(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty
        {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
            print(passwordStrength)
        } else {
            passwordStrength = .veryWeak
        }
        errorPassLbl.isHidden = passwordStrength != .veryWeak

        setupStrongIndicatorsViews()
    }

    @IBAction func visibleOldPassAction(_ sender: UISwitch) {
        if sender.isOn {
            oldPassTF.isSecureTextEntry = true
        } else { oldPassTF.isSecureTextEntry = false }
    }

    @IBAction func visibleNewPassAction(_ sender: UISwitch) {
        if sender.isOn {
            passwordTF.isSecureTextEntry = true
        } else { passwordTF.isSecureTextEntry = false }
    }

    @IBAction func visibleCobfirmPassAction(_ sender: UISwitch) {
        if sender.isOn {
            confPassTF.isSecureTextEntry = true
        } else { confPassTF.isSecureTextEntry = false }
    }

    @IBAction func cofirmPassActionTF(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty, VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        {
            errorConfPassLbl.isHidden = false
            errorConfPassLbl.text = "Password is confirmed"
            errorConfPassLbl.textColor = .green

        } else {
            errorConfPassLbl.isHidden = false
            errorConfPassLbl.text = "Password is not confirmed"
            errorConfPassLbl.textColor = .red
        }
    }

    @IBAction func saveActionBtn(_ sender: UIButton) {
        if let email = emailTF.text,
           let pass = confPassTF.text,
           let name = nameTF.text,
           let userModelOld = userModel
        {
            let userModelNew = UserModel(name: name, email: email, pass: pass)
            let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else { return }
            profileVC.userModel = UserDefaultsService.editUserModel(userModelOld: userModelOld, userModelNew: userModelNew)
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}
