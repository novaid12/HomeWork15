//
//  ProfileVC.swift
//  HomeWork15
//
//  Created by  NovA on 26.08.23.
//

import UIKit

class ProfileVC: BaseViewController {
    var userModel: UserModel?

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var deleteAccBtn: UIButton!
    override func viewDidLoad() {
        
        nameLbl.text = userModel?.name ?? "Unknown"
        emailLbl.text = userModel?.email ?? ""
        deleteAccBtn.layer.cornerRadius = 17.0
        deleteAccBtn.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func editBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
        guard let editVC = storyboard.instantiateViewController(withIdentifier: "EditAccountVC") as? EditAccountVC else { return }
        editVC.userModel = userModel
        navigationController?.pushViewController(editVC, animated: true)
    }
    @IBAction func logOutActionBtn(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "authorization")
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func deleteAccountActionBtn(_ sender: UIButton) {
        guard let userModel = userModel else { return }
        UserDefaultsService.cleanUserDefauts(email: userModel.email)
        UserDefaults.standard.removeObject(forKey: "authorization")
        navigationController?.popToRootViewController(animated: true)
    }

}
