//
//  TransactionViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/08/22.
//

import UIKit
import DropDown

final class TransactionViewController: UIViewController {
    
    @IBOutlet weak var incomeViewOutlet: UIView!
    @IBOutlet weak var incomeLabelOutlet: UILabel!
    @IBOutlet weak var incomeImageOutlet: UIImageView!
    
    @IBOutlet weak var spendingViewOutlet: UIView!
    @IBOutlet weak var spendingLabelOutlet: UILabel!
    @IBOutlet weak var spendingImageOutlet: UIImageView!
    
    @IBOutlet weak var moneyAmountTextFieldOutlet: UITextField!
    @IBOutlet weak var categoryTextFieldOutlet: UITextField!
    @IBOutlet weak var descriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var addTransactionButtonOutlet: UIButton!
    @IBOutlet weak var transactionListButtonOutlet: UIButton!
    
    private let dropDownIncome = DropDown()
    private let dropDownSpending = DropDown()
    private var categoryDataIncome: [String] = ["Gaji", "Bonus", "Hadiah", "Pinjaman"]
    
    private var categoryDataSpending:[String] = ["Konsumsi", "Belanja Umum", "Belanja Online", "Transportasi"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CategoryDataIncomeDefaults.check() == true {
            categoryDataIncome = CategoryDataIncomeDefaults.get()
            print(categoryDataIncome)
        }
        CategoryDropDownIncome()
        
        if CategoryDataSpendingDefaults.check() == true {
            categoryDataSpending = CategoryDataSpendingDefaults.get()
            print(categoryDataSpending)
        }
        CategoryDropDownSpending()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextFieldOutlet.isUserInteractionEnabled = false
        addTransactionButtonOutlet.layer.cornerRadius = 8
        transactionListButtonOutlet.layer.cornerRadius = 8
    }
    
    @IBAction func incomeButtonTapIn(_ sender: Any) {
        incomeViewOutlet.backgroundColor = .white
        incomeImageOutlet.image = UIImage(named: "PemasukanColor")
        incomeLabelOutlet.textColor = .black
        
        spendingViewOutlet.backgroundColor = UIColor(named: "BaseColor")
        spendingImageOutlet.image = UIImage(named: "PengeluaranWhite")
        spendingLabelOutlet.textColor = .white
    }
    
    @IBAction func spendingButtonTapIn(_ sender: Any) {
        incomeViewOutlet.backgroundColor = UIColor(named: "BaseColor")
        incomeImageOutlet.image = UIImage(named: "PemasukanWhite")
        incomeLabelOutlet.textColor = .white
        
        spendingViewOutlet.backgroundColor = .white
        spendingImageOutlet.image = UIImage(named: "PengeluaranColor")
        spendingLabelOutlet.textColor = .black
    }
    
    @IBAction func categoryButtonTapIn(_ sender: Any) {
        if spendingLabelOutlet.textColor == .black {
            dropDownSpending.show()
        } else {
            dropDownIncome.show()
        }
        
    }
    
    @IBAction func addCategoryDataButtonTapIn(_ sender: Any) {
        if spendingLabelOutlet.textColor == .black {
            AddCategoryDataSpending()
        } else {
            AddCategoryDataIncome()
        }
    }
    
    @IBAction func addTransactionButtonTapIn(_ sender: Any) {
    }
    
    @IBAction func transactionListButtonTapIn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "TransactionListViewController", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionListViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func tabBarButtonHomeTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "HomeViewController", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    private func CategoryDropDownIncome() {
        dropDownIncome.anchorView = categoryTextFieldOutlet
        dropDownIncome.dataSource = categoryDataIncome
        dropDownIncome.bottomOffset = CGPoint(x: 0, y:(dropDownIncome.anchorView?.plainView.bounds.height)!)
        dropDownIncome.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextFieldOutlet.text = categoryDataIncome[index]
        }
    }
    
    private func CategoryDropDownSpending() {
        dropDownSpending.anchorView = categoryTextFieldOutlet
        dropDownSpending.dataSource = categoryDataSpending
        dropDownSpending.bottomOffset = CGPoint(x: 0, y:(dropDownIncome.anchorView?.plainView.bounds.height)!)
        dropDownSpending.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextFieldOutlet.text = categoryDataSpending[index]
        }
    }
    
    func AddCategoryDataIncome() {
        let alert = UIAlertController(
            title: "Tambah Kategori Pemasukan",
            message: nil,
            preferredStyle: .alert)
        alert.addTextField {
            textField in
            textField.textAlignment = .center
            textField.placeholder = "Maks. 10 huruf"
        }
        alert.addAction(UIAlertAction(title: "Batal", style: .destructive))
        alert.addAction(UIAlertAction(
            title: "Tambah", style: .default,
            handler: { ACTION in
                let textFieldValue = alert.textFields?.first?.text
                self.categoryDataIncome.append(textFieldValue!)
                self.dropDownIncome.dataSource = self.categoryDataIncome
                CategoryDataIncomeDefaults.save(self.categoryDataIncome)
        }))
        self.present(alert, animated: true)
    }
    
    func AddCategoryDataSpending() {
        let alert = UIAlertController(
            title: "Tambah Kategori Pengeluaran",
            message: nil,
            preferredStyle: .alert)
        alert.addTextField {
            textField in
            textField.textAlignment = .center
            textField.placeholder = "Maks. 10 huruf"
        }
        alert.addAction(UIAlertAction(title: "Batal", style: .destructive))
        alert.addAction(UIAlertAction(
            title: "Tambah", style: .default,
            handler: { ACTION in
                let textFieldValue = alert.textFields?.first?.text
                self.categoryDataSpending.append(textFieldValue!)
                self.dropDownSpending.dataSource = self.categoryDataSpending
                CategoryDataSpendingDefaults.save(self.categoryDataSpending)
        }))
        self.present(alert, animated: true)
    }
}
