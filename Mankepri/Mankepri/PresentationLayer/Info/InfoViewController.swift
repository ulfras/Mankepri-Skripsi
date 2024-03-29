//
//  InfoViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 30/07/22.
//

import UIKit

final class InfoViewController: UIViewController {
    
    @IBOutlet weak var creatorImageViewOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorImageViewOutlet.layer.cornerRadius = creatorImageViewOutlet.frame.size.width/2
    }
    
    @IBAction func tabBarBudgetButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "BudgetViewController", bundle:nil).instantiateViewController(withIdentifier: "BudgetViewController")
        let navBarController = UINavigationController(rootViewController: viewController)
        navBarController.modalPresentationStyle = .fullScreen
        navBarController.navigationBar.isHidden = true
        self.present(navBarController, animated: false, completion:nil)
    }
    
    @IBAction func transactionButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "TransactionViewController", bundle:nil).instantiateViewController(withIdentifier: "TransactionViewController")
        let navBarController = UINavigationController(rootViewController: viewController)
        navBarController.modalPresentationStyle = .fullScreen
        navBarController.navigationBar.isHidden = true
        self.present(navBarController, animated: false, completion:nil)
    }
    
    @IBAction func tabBarButtonHomeTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "HomeViewController", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    @IBAction func tabBarFinanceStatementsButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "FinancialStatementsViewController", bundle:nil).instantiateViewController(withIdentifier: "FinancialStatementsViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
}
