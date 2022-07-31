//
//  TransactionViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/08/22.
//

import UIKit

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
    
    private var categoryData: [String] = ["Gaji", "Bonus", "Hadiah", "Pinjaman"]
    
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
}
