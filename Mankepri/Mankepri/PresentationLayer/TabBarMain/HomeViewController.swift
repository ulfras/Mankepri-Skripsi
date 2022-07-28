//
//  TabBarViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    @IBAction func buttonSettingTapIn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SettingViewController", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
