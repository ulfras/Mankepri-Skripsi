//
//  BudgetViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 05/08/22.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet weak var remainingBudgetLabelOutlet: UILabel!
    @IBOutlet weak var totalBudgetLabelOutlet: UILabel!
    @IBOutlet weak var totalBudgetSpendingLabelOutlet: UILabel!
    @IBOutlet weak var createBudgetButtonOutlet: UIButton!
    
    private var remainingBudget: Int = 0
    private var totalBudget: Int = 0
    private var totalBudgetSpending: Int = 0
    private var spendingBudgetData: [TransactionDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBudgetSpendingDefaults()
        checkBudgetDefaults()
        labelOutletConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBudgetButtonOutlet.layer.cornerRadius = 8
    }
    
    @IBAction func createBudgetButtonTapIn(_ sender: Any) {
        let budgetAlert = UIAlertController(
            title: "Buat Anggaran",
            message: nil,
            preferredStyle: .alert)
        budgetAlert.addTextField { textField in
            textField.textAlignment = .center
            textField.placeholder = "Jumlah Anggaran"
            textField.keyboardType = .numberPad
        }
        budgetAlert.addAction(UIAlertAction(
            title: "Batal",
            style: .destructive))
        budgetAlert.addAction(UIAlertAction(
            title: "Buat",
            style: .default, handler: { action in
                SpendingBudgetUserDefaults.delete()
                let textFieldValue = budgetAlert.textFields?.first?.text
                BudgetUserDefaults.save(Int(textFieldValue!)!)
                CustomToast.show(
                    message: "Anggaran berhasil dibuat.",
                    bgColor: .systemGreen,
                    textColor: .white,
                    labelFont: .systemFont(ofSize: 17),
                    showIn: .bottom,
                    controller: self)
            }))
        self.present(budgetAlert, animated: true)
    }
    
    private func checkBudgetSpendingDefaults() {
        if SpendingBudgetUserDefaults.check() == false {
            totalBudgetSpendingLabelOutlet.text = "0"
        } else {
            spendingBudgetData = SpendingBudgetUserDefaults.get()
            for spendingBudgetDatum in spendingBudgetData {
                totalBudgetSpending = totalBudgetSpending + spendingBudgetDatum.money
            }
            totalBudgetSpendingLabelOutlet.text = totalBudgetSpending.formattedWithSeparator
        }
    }
    
    private func checkBudgetDefaults() {
        if BudgetUserDefaults.check() == false {
            totalBudgetLabelOutlet.text = "IDR 0"
            remainingBudgetLabelOutlet.text = "0"
        } else {
            totalBudget = BudgetUserDefaults.get()
            remainingBudget = totalBudget - totalBudgetSpending
        }
    }
    
    private func labelOutletConfig() {
        if remainingBudget <= 0 {
            totalBudgetLabelOutlet.text = "IDR 0"
            remainingBudgetLabelOutlet.text = "0"
        } else {
            totalBudgetLabelOutlet.text = totalBudget.formattedWithSeparator
            remainingBudgetLabelOutlet.text = "IDR \(remainingBudget.formattedWithSeparator)"
        }
    }
    
    @IBAction func tabBarTransactionButtonTapIn(_ sender: Any) {
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
    
    @IBAction func tabBarInfoButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "InfoViewController", bundle:nil).instantiateViewController(withIdentifier: "InfoViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }

}
