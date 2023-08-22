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
    @IBOutlet var errorPassLbl: UILabel!
    /// strongPassIndicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    /// confPass
    @IBOutlet var confPassTF: UITextField!
    @IBOutlet var errorConfPassLbl: UILabel!
    /// continueBtn
    @IBOutlet var continueBtn: UIButton!
    /// scrollView
    @IBOutlet var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
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

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
