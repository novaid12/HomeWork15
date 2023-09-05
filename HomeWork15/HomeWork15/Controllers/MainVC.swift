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
    }

    @IBAction func goToProfileVC(_ sender: UIButton) {

        performSegue(withIdentifier: "goToProfileSegue", sender: userModel)
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let destVC = segue.destination as? ProfileVC,
               let userModel = sender as? UserModel else { return }
         destVC.userModel = userModel
     }

}
