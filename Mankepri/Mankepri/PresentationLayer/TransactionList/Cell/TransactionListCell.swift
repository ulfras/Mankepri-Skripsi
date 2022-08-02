//
//  TransactionListCell.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import UIKit

class TransactionListCell: UITableViewCell {

    @IBOutlet weak var transactionTypeImageOutlet: UIImageView!
    @IBOutlet weak var transactionAmountLabelOutlet: UILabel!
    @IBOutlet weak var transactionDateLabelOutlet: UILabel!
    @IBOutlet weak var transactionCategoryLabelOutlet: UILabel!
    @IBOutlet weak var transactionDescriptionLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        transactionTypeImageOutlet.layer.cornerRadius = 8
    }
}
