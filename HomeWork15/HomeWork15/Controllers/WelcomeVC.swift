//
//  WelcomeVC.swift
//  HomeWork15
//
//  Created by  NovA on 26.08.23.
//

import UIKit

class WelcomeVC: BaseViewController {
    @IBOutlet var infoLbl: UILabel!

    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func continueAction() {
        // TODO: sava data
        navigationController?.popToRootViewController(animated: true)
        let data = [userModel?.name ?? "", userModel?.pass ?? ""]
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: userModel?.email ?? "")
    }

    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Cool App"
    }
}
