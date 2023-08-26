//
//  MainVC.swift
//  HomeWork15
//
//  Created by  NovA on 26.08.23.
//

import UIKit

class MainVC: BaseViewController {
    var userModel: UserModel?

    @IBOutlet var profileBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        profileBtn.setTitle("Hello, \(userModel?.name ?? "Unknown")", for: .normal)
//        let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
//        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
//        guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else { return }
//        mainVC.userModel = userModel
//        profileVC.userModel = userModel
//        show(mainVC, sender: nil)
    }

    @IBAction func goToProfileVC(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "MainAppView", bundle: nil)
//        guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else { return }
//        profileVC.userModel = userModel
//        show(profileVC, sender: nil)
        performSegue(withIdentifier: "goToProfileSegue", sender: userModel)
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let destVC = segue.destination as? ProfileVC,
               let userModel = sender as? UserModel else { return }
         destVC.userModel = userModel
     }

}
