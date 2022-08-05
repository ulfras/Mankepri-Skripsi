//
//  TabBarViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeMessageOutlet: UILabel!
    @IBOutlet weak var totalSavingLabelOutlet: UILabel!
    @IBOutlet weak var totalIncomeLabelOutlet: UILabel!
    @IBOutlet weak var totalSpendingLabelOutlet: UILabel!
    @IBOutlet weak var remainingBudgetLabelOutlet: UILabel!
    @IBOutlet weak var totalBudgetLabelOutlet: UILabel!
    
    private var transactionData: [TransactionDataModel] = []
    private var totalSaving: Int = 0
    private var totalIncome: Int = 0
    private var totalSpending: Int = 0
    
    var test: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUsernameDefaults()
        checkTransactionDataDefaults()
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
    
    @IBAction func tabBarTransactionButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "TransactionViewController", bundle:nil).instantiateViewController(withIdentifier: "TransactionViewController")
        let navBarController = UINavigationController(rootViewController: viewController)
        navBarController.modalPresentationStyle = .fullScreen
        navBarController.navigationBar.isHidden = true
        self.present(navBarController, animated: false, completion:nil)
    }
    
    @IBAction func tabBarFinanceStatementsButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "FinancialStatementsViewController", bundle:nil).instantiateViewController(withIdentifier: "FinancialStatementsViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    @IBAction func tabBarInfoButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "InfoViewController", bundle:nil).instantiateViewController(withIdentifier: "InfoViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    private func checkUsernameDefaults() {
        if UsernameUserDefaults.check() == true {
            let usernameDefaults = UsernameUserDefaults.get()
            welcomeMessageOutlet.text = "Selamat Datang, \(usernameDefaults)"
        } else {
            welcomeMessageOutlet.text = "Selamat Datang, Pengguna"
        }
    }
    
    private func checkTransactionDataDefaults() {
        if TransactionDataUserDefaults.check() == true {
            transactionData = TransactionDataUserDefaults.get()
            if transactionData.isEmpty {
                totalSavingLabelOutlet.text = "IDR 0"
                totalIncomeLabelOutlet.text = "0"
                totalSpendingLabelOutlet.text = "0"
            } else {
                for transactionDatum in transactionData {
                    if transactionDatum.type == "CR" {
                        totalIncome = totalIncome + transactionDatum.money
                    } else {
                        totalSpending = totalSpending + transactionDatum.money
                    }
                }
                totalSaving = totalIncome - totalSpending
                totalSavingLabelOutlet.text = "IDR \(totalSaving.formattedWithSeparator)"
                totalIncomeLabelOutlet.text = "\(totalIncome.formattedWithSeparator)"
                totalSpendingLabelOutlet.text = "\(totalSpending.formattedWithSeparator)"
            }
        } else {
            totalSavingLabelOutlet.text = "IDR 0"
            totalIncomeLabelOutlet.text = "0"
            totalSpendingLabelOutlet.text = "0"
        }
    }
}
