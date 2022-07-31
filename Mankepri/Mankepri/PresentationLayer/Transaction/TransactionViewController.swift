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
    
    private let dropDown = DropDown()
    private var categoryData: [String] = ["Gaji", "Bonus", "Hadiah", "Pinjaman"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CategoryDataDefaults.check() == true {
            categoryData = CategoryDataDefaults.get()
        }
        CategoryDropDown()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextFieldOutlet.isUserInteractionEnabled = false
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
        dropDown.show()
    }
    
    @IBAction func addCategoryDataButtonTapIn(_ sender: Any) {
        AddCategoryData()
    }
    
    @IBAction func addTransactionButtonTapIn(_ sender: Any) {
    }
    
    @IBAction func transactionListButtonTapIn(_ sender: Any) {
    }
    
    
    @IBAction func tabBarButtonHomeTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "HomeViewController", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    private func CategoryDropDown() {
        dropDown.anchorView = categoryTextFieldOutlet
        dropDown.dataSource = categoryData
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextFieldOutlet.text = categoryData[index]
        }
    }
    
    func AddCategoryData() {
        let alert = UIAlertController(
            title: "Tambah Kategori",
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
                self.categoryData.append(textFieldValue!)
                self.dropDown.dataSource = self.categoryData
                CategoryDataDefaults.save(self.categoryData)
        }))
        self.present(alert, animated: true)
    }
}
