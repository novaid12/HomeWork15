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
    @IBOutlet weak var deleteAccBtn: UIButton!
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        nameLbl.text = userModel?.name ?? "Unknown"
        emailLbl.text = userModel?.email ?? ""
        deleteAccBtn.layer.cornerRadius = 17.0
        deleteAccBtn.layer.masksToBounds = true
    }

    @IBAction func logOutActionBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func deleteAccountActionBtn(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: userModel?.email ?? "")
        navigationController?.popToRootViewController(animated: true)
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
