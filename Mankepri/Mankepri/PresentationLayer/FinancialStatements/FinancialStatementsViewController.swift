//
//  FinancialStatementsViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 05/08/22.
//

import UIKit
import Charts

final class FinancialStatementsViewController: UIViewController {
    
    @IBOutlet weak var betweenDateTransactionLabelOutlet: UILabel!
    @IBOutlet weak var pieChartViewOutlet: PieChartView!
    
    @IBOutlet weak var totalIncomeLabelOutlet: UILabel!
    @IBOutlet weak var totalSpendingLabelOutlet: UILabel!
    @IBOutlet weak var totalMarginLabelOutlet: UILabel!
    
    @IBOutlet weak var maxIncomeAmountLabelOutlet: UILabel!
    @IBOutlet weak var maxIncomeCategoryLabelOutlet: UILabel!
    @IBOutlet weak var maxIncomeDescriptionLabelOutlet: UILabel!
    
    @IBOutlet weak var maxSpendingAmountLabelOutlet: UILabel!
    @IBOutlet weak var maxSpendingCategoryLabelOutlet: UILabel!
    @IBOutlet weak var maxSpendingDescriptionLabelOutlet: UILabel!
    
    private var totalIncomePieChartDataEntry = PieChartDataEntry(
        value: 0,
        label: "Pemasukan")
    private var totalSpendingPieChartDataEntry = PieChartDataEntry(
        value: 0,
        label: "Pengeluaran")
    private var pieChartDataEntry = [PieChartDataEntry]()
    private var transactionData: [TransactionDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transactionDataDefaultsConditionConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func tabBarInfoButtonTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "InfoViewController", bundle:nil).instantiateViewController(withIdentifier: "InfoViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
    
    private func transactionDataDefaultsConditionConfig() {
        if TransactionDataUserDefaults.check() == true {
            transactionData = TransactionDataUserDefaults.get()
            if transactionData.isEmpty == false {
                let minDateTransaction = transactionDate(extremaType: .min)
                let maxDateTransaction = transactionDate(extremaType: .max)
                let minDate = DateFormatter().convertDateToString(from: minDateTransaction, withFormat: "dd MMM yyyy")
                let maxDate = DateFormatter().convertDateToString(from: maxDateTransaction, withFormat: "dd MMM yyyy")
                betweenDateTransactionLabelOutlet.text = "\(minDate) sampai \(maxDate)"
                pieChartConfig()
                labelOutletConfig()
            } else {
                pieChartViewOutlet.noDataText = "Tidak ada data transaksi."
            }
        } else {
            pieChartViewOutlet.noDataText = "Tidak ada data transaksi."
        }
    }
    
    private enum transactionType {
        case CR
        case DB
    }
    
    private enum extremaType {
        case min
        case max
    }
    
    private func totalAmountTransaction(transactionType: transactionType) -> Int {
        switch transactionType {
        case .CR:
            var totalAmount = 0
            for transactionDatum in transactionData {
                if transactionDatum.type == "CR" {
                    totalAmount = totalAmount + transactionDatum.money
                }
            }
            return totalAmount
        case .DB:
            var totalAmount = 0
            for transactionDatum in transactionData {
                if transactionDatum.type == "DB" {
                    totalAmount = totalAmount + transactionDatum.money
                }
            }
            return totalAmount
        }
    }
    
    private func transactionDate(extremaType: extremaType) -> Date {
        switch extremaType {
        case .min:
            let datum = transactionData.min { a, b in
                a.date < b.date
            }!
            return datum.date
        case .max:
            let datum = transactionData.max { a, b in
                a.date < b.date
            }!
            return datum.date
        }
    }
    
    private func extremaTransaction(type: transactionType) -> TransactionDataModel {
        switch type {
        case .CR:
            var datum: [TransactionDataModel] = []
            for transactionDatum in transactionData {
                if transactionDatum.type == "CR" {
                    datum.append(transactionDatum)
                }
            }
            let maxCRData = datum.max { a, b in
                a.date < b.date
            }
            return maxCRData!
        case .DB:
            var datum: [TransactionDataModel] = []
            for transactionDatum in transactionData {
                if transactionDatum.type == "DB" {
                    datum.append(transactionDatum)
                }
            }
            let maxDBData = datum.max { a, b in
                a.date < b.date
            }
            return maxDBData!
        }
    }
    
    private func labelOutletConfig() {
        totalIncomeLabelOutlet.text = totalAmountTransaction(transactionType: .CR).formattedWithSeparator
        totalSpendingLabelOutlet.text = totalAmountTransaction(transactionType: .DB).formattedWithSeparator
        totalMarginLabelOutlet.text = (abs(totalAmountTransaction(transactionType: .CR) - totalAmountTransaction(transactionType: .DB))).formattedWithSeparator
        
        maxIncomeAmountLabelOutlet.text = "Jumlah: \(extremaTransaction(type: .CR).money.formattedWithSeparator)"
        maxIncomeCategoryLabelOutlet.text = "Kategori: \(extremaTransaction(type: .CR).category)"
        maxIncomeDescriptionLabelOutlet.text = extremaTransaction(type: .CR).description
        
        maxSpendingAmountLabelOutlet.text = "Jumlah: \(extremaTransaction(type: .DB).money.formattedWithSeparator)"
        maxSpendingCategoryLabelOutlet.text = "Kategori: \(extremaTransaction(type: .DB).category)"
        maxSpendingDescriptionLabelOutlet.text = extremaTransaction(type: .DB).description
    }
    
    private func pieChartConfig() {
        let multiplier = 100.0
        let divider = Double(totalAmountTransaction(transactionType: .CR)) + Double(totalAmountTransaction(transactionType: .DB))
        let totalIncomeInPercent = Double(totalAmountTransaction(transactionType: .CR)) / Double(divider) * Double(multiplier)
        totalIncomePieChartDataEntry.value = totalIncomeInPercent
        let totalSpendingInPercent = Double(totalAmountTransaction(transactionType: .DB)) / Double(divider) * Double(multiplier)
        totalSpendingPieChartDataEntry.value = totalSpendingInPercent
        pieChartViewOutlet.chartDescription.text = "Data dalam persen (%)"
        pieChartViewOutlet.chartDescription.font = .systemFont(ofSize: 10)
        pieChartDataEntry = [totalIncomePieChartDataEntry, totalSpendingPieChartDataEntry]
        let chartDataSet = PieChartDataSet(entries: pieChartDataEntry, label: "")
        let colors = [UIColor(named: "ColorPemasukan"), UIColor(named: "ColorPengeluaran")]
        chartDataSet.colors = colors as! [NSUIColor]
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChartViewOutlet.data = chartData
    }
}
