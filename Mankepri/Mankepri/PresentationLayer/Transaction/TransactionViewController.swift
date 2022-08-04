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
    private var categoryDataSpending: [String] = ["Konsumsi", "Belanja Umum", "Belanja Online", "Transportasi"]
    var transactionData:[TransactionDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if TransactionDataUserDefaults.check() == true {
            transactionData = TransactionDataUserDefaults.get()
        }
        
        if CategoryDataIncomeDefaults.check() == true {
            categoryDataIncome = CategoryDataIncomeDefaults.get()
        }
        categoryDropDownIncome()
        
        if CategoryDataSpendingDefaults.check() == true {
            categoryDataSpending = CategoryDataSpendingDefaults.get()
        }
        categoryDropDownSpending()
        
        if TransactionDataUserDefaults.check() == true {
            transactionData = TransactionDataUserDefaults.get()
        }
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
        
        categoryTextFieldOutlet.text = nil
    }
    
    @IBAction func spendingButtonTapIn(_ sender: Any) {
        incomeViewOutlet.backgroundColor = UIColor(named: "BaseColor")
        incomeImageOutlet.image = UIImage(named: "PemasukanWhite")
        incomeLabelOutlet.textColor = .white
        
        spendingViewOutlet.backgroundColor = .white
        spendingImageOutlet.image = UIImage(named: "PengeluaranColor")
        spendingLabelOutlet.textColor = .black
        
        categoryTextFieldOutlet.text = nil
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
            addCategoryDataSpending()
        } else {
            addCategoryDataIncome()
        }
    }
    
    @IBAction func addTransactionButtonTapIn(_ sender: Any) {
        if moneyAmountTextFieldOutlet.text?.isEmpty == true ||
            moneyAmountTextFieldOutlet.text == "0" ||
            categoryTextFieldOutlet.text?.isEmpty == true ||
            descriptionTextFieldOutlet.text?.isEmpty == true
        {
            CustomToast.show(message: "Lengkapi Data.",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: UIFont.systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            addTransactionData()
        }
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
    
    @IBAction func tabBarButtonInfoTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "InfoViewController", bundle:nil).instantiateViewController(withIdentifier: "InfoViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    private func categoryDropDownIncome() {
        dropDownIncome.anchorView = categoryTextFieldOutlet
        dropDownIncome.dataSource = categoryDataIncome
        dropDownIncome.bottomOffset = CGPoint(x: 0, y:(dropDownIncome.anchorView?.plainView.bounds.height)!)
        dropDownIncome.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextFieldOutlet.text = categoryDataIncome[index]
        }
    }
    
    private func categoryDropDownSpending() {
        dropDownSpending.anchorView = categoryTextFieldOutlet
        dropDownSpending.dataSource = categoryDataSpending
        dropDownSpending.bottomOffset = CGPoint(x: 0, y:(dropDownIncome.anchorView?.plainView.bounds.height)!)
        dropDownSpending.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextFieldOutlet.text = categoryDataSpending[index]
        }
    }
    
    private func addCategoryDataIncome() {
        let alertAddCategoryIncome = UIAlertController(
            title: "Tambah Kategori Pemasukan",
            message: nil,
            preferredStyle: .alert)
        alertAddCategoryIncome.addTextField {
            textField in
            textField.textAlignment = .center
            textField.placeholder = "Maks. 10 huruf"
        }
        alertAddCategoryIncome.addAction(UIAlertAction(title: "Batal", style: .destructive))
        alertAddCategoryIncome.addAction(UIAlertAction(
            title: "Tambah", style: .default,
            handler: { ACTION in
                let textFieldValue = alertAddCategoryIncome.textFields?.first?.text
                self.categoryDataIncome.append(textFieldValue!)
                self.dropDownIncome.dataSource = self.categoryDataIncome
                CategoryDataIncomeDefaults.save(self.categoryDataIncome)
        }))
        self.present(alertAddCategoryIncome, animated: true)
    }
    
    private func addCategoryDataSpending() {
        let alertAddCategorySpending = UIAlertController(
            title: "Tambah Kategori Pengeluaran",
            message: nil,
            preferredStyle: .alert)
        alertAddCategorySpending.addTextField {
            textField in
            textField.textAlignment = .center
            textField.placeholder = "Maks. 10 huruf"
        }
        alertAddCategorySpending.addAction(UIAlertAction(title: "Batal", style: .destructive))
        alertAddCategorySpending.addAction(UIAlertAction(
            title: "Tambah", style: .default,
            handler: { ACTION in
                let textFieldValue = alertAddCategorySpending.textFields?.first?.text
                self.categoryDataSpending.append(textFieldValue!)
                self.dropDownSpending.dataSource = self.categoryDataSpending
                CategoryDataSpendingDefaults.save(self.categoryDataSpending)
        }))
        self.present(alertAddCategorySpending, animated: true)
    }
    
    private func addTransactionData() {
        let alertAddTransaction = UIAlertController(
            title: "Pengingat.",
            message: "Pastikan data yang telah dimasukkan benar karena data tidak akan bisa diubah  inf.",
            preferredStyle: .alert)
        if spendingLabelOutlet.textColor == .black {
            alertAddTransaction.addAction(UIAlertAction(title: "Batal", style: .destructive))
            alertAddTransaction.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    let money = self.moneyAmountTextFieldOutlet.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    self.transactionData.append(TransactionDataModel(
                        money: Int(money)!,
                        category: self.categoryTextFieldOutlet.text!,
                        description: self.descriptionTextFieldOutlet.text!,
                        date: Date(),
                        type: "DB")
                    )
                    TransactionDataUserDefaults.save(self.transactionData)
                    CustomToast.show(message: "Transaksi Pengeluaran Berhasil Terdata.",
                                     bgColor: .systemGreen,
                                     textColor: .white,
                                     labelFont: UIFont.systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                    self.moneyAmountTextFieldOutlet.text = nil
                    self.categoryTextFieldOutlet.text = nil
                    self.descriptionTextFieldOutlet.text = nil
                }))
        } else {
            alertAddTransaction.addAction(UIAlertAction(title: "Batal", style: .destructive))
            alertAddTransaction.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    let money = self.moneyAmountTextFieldOutlet.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    self.transactionData.append(TransactionDataModel(
                        money: Int(money)!,
                        category: self.categoryTextFieldOutlet.text!,
                        description: self.descriptionTextFieldOutlet.text!,
                        date: Date(),
                        type: "CR")
                    )
                    TransactionDataUserDefaults.save(self.transactionData)
                    CustomToast.show(message: "Transaksi Pemasukan Berhasil Terdata.",
                                     bgColor: .systemGreen,
                                     textColor: .white,
                                     labelFont: UIFont.systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                    self.moneyAmountTextFieldOutlet.text = nil
                    self.categoryTextFieldOutlet.text = nil
                    self.descriptionTextFieldOutlet.text = nil
                }))
        }
        self.present(alertAddTransaction, animated: true)
    }
}
