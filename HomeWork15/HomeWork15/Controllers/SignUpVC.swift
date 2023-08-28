//
//  SignUpVC.swift
//  HomeWork15
//
//  Created by  NovA on 22.08.23.
//

import UIKit

class SignUpVC: BaseViewController {
    /// email
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var errorEmailLbl: UILabel!
    /// name
    @IBOutlet var nameTF: UITextField!
    /// password
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var switchVisiblePass: UISwitch!
    @IBOutlet var errorPassLbl: UILabel!
    /// strongPassIndicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    /// confPass
    @IBOutlet var confPassTF: UITextField!
    @IBOutlet var cofirmVisiblePass: UISwitch!
    @IBOutlet var errorConfPassLbl: UILabel!
    /// continueBtn
    @IBOutlet var continueBtn: UIButton!
    /// scrollView
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet weak var signInBtn: UIButton!
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        setupUI()
    }

    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    func setupUI() {
        emailTF.layer.cornerRadius = 17.0
        emailTF.layer.masksToBounds = true
        nameTF.layer.cornerRadius = 17.0
        nameTF.layer.masksToBounds = true
        passwordTF.layer.cornerRadius = 17.0
        passwordTF.layer.masksToBounds = true
        confPassTF.layer.cornerRadius = 17.0
        confPassTF.layer.masksToBounds = true
        continueBtn.layer.cornerRadius = 17.0
        continueBtn.layer.masksToBounds = true
        continueBtn.isEnabled = true
        signInBtn.layer.cornerRadius = 17.0
        signInBtn.layer.masksToBounds = true
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

    @IBAction func backSignInBtn() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func emailActionTF(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email)
        {
            isValidEmail = true
            errorEmailLbl.isHidden = false
            errorEmailLbl.text = "Email is Valid!"
            errorEmailLbl.textColor = .green
        } else {
            isValidEmail = false
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

    @IBAction func visiblePassAction(_ sender: UISwitch) {
        if sender.isOn {
            passwordTF.isSecureTextEntry = true
        } else { passwordTF.isSecureTextEntry = false }
    }

    @IBAction func cofirmPassActionTF(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty, VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        {
            isConfPass = true
            errorConfPassLbl.isHidden = false
            errorConfPassLbl.text = "Password is confirmed"
            errorConfPassLbl.textColor = .green

        } else {
            isConfPass = false
            errorConfPassLbl.isHidden = false
            errorConfPassLbl.text = "Password is not confirmed"
            errorConfPassLbl.textColor = .red
        }
    }

    @IBAction func cofirmPassVisibleAction(_ sender: UISwitch) {
        if sender.isOn {
            confPassTF.isSecureTextEntry = true
        } else { confPassTF.isSecureTextEntry = false }
    }

    @IBAction func continueActionTF(_ sender: UIButton) {
        if let email = emailTF.text,
           let pass = passwordTF.text
        {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToVerifScreen", sender: userModel)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
}
