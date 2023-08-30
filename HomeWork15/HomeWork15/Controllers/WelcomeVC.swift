//
//  WelcomeVC.swift
//  HomeWork15
//
//  Created by  NovA on 26.08.23.
//

import UIKit

class WelcomeVC: BaseViewController {
    @IBOutlet var infoLbl: UILabel!

    @IBOutlet var continueBtn: UIButton!
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func continueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }

    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Cool App"
        continueBtn.layer.cornerRadius = 17.0
        continueBtn.layer.masksToBounds = true
    }
}
