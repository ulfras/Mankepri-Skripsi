//
//  TabBarViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UsernameUserDefaults.check() == true {
            let usernameDefaults = UsernameUserDefaults.get()
            welcomeMessageOutlet.text = "Selamat Datang, \(usernameDefaults)"
        } else {
            welcomeMessageOutlet.text = "Selamat Datang, Pengguna"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func buttonSettingTapIn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SettingViewController", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func transactionButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "TransactionViewController", bundle:nil).instantiateViewController(withIdentifier: "TransactionViewController")
        let navBarController = UINavigationController(rootViewController: viewController)
        navBarController.modalPresentationStyle = .fullScreen
        navBarController.navigationBar.isHidden = true
        self.present(navBarController, animated: false, completion:nil)
    }
    
    @IBAction func tabBarButtonInfoTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "InfoViewController", bundle:nil).instantiateViewController(withIdentifier: "InfoViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
}