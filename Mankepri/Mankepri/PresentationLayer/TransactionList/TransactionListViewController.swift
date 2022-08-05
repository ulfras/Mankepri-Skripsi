//
//  TransactionListViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import UIKit

final class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var sortTransactionButtonOutlet: UIButton!
    @IBOutlet weak var transactionListTableViewOutlet: UITableView!
    @IBOutlet weak var noTransactionLabelOutlet: UILabel!
    @IBOutlet weak var okButtonOutlet: UIButton!
    private var transactionDataSorted: [TransactionDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTransactionDataLogic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButtonOutlet.layer.cornerRadius = 8
        transactionListTableViewOutlet.register(UINib.init(nibName:"TransactionListCell" , bundle: nil), forCellReuseIdentifier: "TransactionListCell")
        transactionListTableViewOutlet.delegate = self
        transactionListTableViewOutlet.dataSource = self
    }
    
    @IBAction func transactionListSortButtonTapIn(_ sender: Any) {
        sortTransactionData()
    }
    
    @IBAction func okButtonTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func checkTransactionDataLogic() {
        if TransactionDataUserDefaults.check() == true {
            transactionDataSorted = TransactionDataUserDefaults.get()
            transactionDataSorted = transactionDataSorted.sorted(by: { $1.date.compare($0.date) == .orderedDescending
            })
            transactionListTableViewOutlet.reloadData()
            if transactionDataSorted.isEmpty {
                sortTransactionButtonOutlet.isHidden = true
                transactionListTableViewOutlet.isHidden = true
                noTransactionLabelOutlet.isHidden = false
            } else {
                sortTransactionButtonOutlet.isHidden = false
                transactionListTableViewOutlet.isHidden = false
                noTransactionLabelOutlet.isHidden = true
            }
        } else {
            sortTransactionButtonOutlet.isHidden = true
            transactionListTableViewOutlet.isHidden = true
            noTransactionLabelOutlet.isHidden = false
        }
    }
    
    private func sortTransactionData() {
        let sortAlert = UIAlertController(
            title: "Urutkan Transaksi",
            message: nil,
            preferredStyle: .actionSheet)
        
        sortAlert.addAction(UIAlertAction(
            title: "Tanggal Terbaru",
            style: .default,
            handler: { action in
                self.transactionDataSorted = self.transactionDataSorted.sorted(by: { $0.date.compare($1.date) == .orderedDescending
                })
                self.transactionListTableViewOutlet.reloadData()
            }))
        
        sortAlert.addAction(UIAlertAction(
            title: "Tanggal Terlama",
            style: .default,
            handler: { action in
                self.transactionDataSorted = self.transactionDataSorted.sorted(by: { $1.date.compare($0.date) == .orderedDescending
                })
                self.transactionListTableViewOutlet.reloadData()
            }))
        
        sortAlert.addAction(UIAlertAction(
            title: "Batal",
            style: .cancel))
        
        self.present(sortAlert, animated: true)
    }
}

extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transactionDataSorted.isEmpty {
            return 0
        } else {
            return transactionDataSorted.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "TransactionListCell", for: indexPath)
        guard let cell = reusableCell as? TransactionListCell else { return reusableCell }
        let transactionDataCell = transactionDataSorted[indexPath.row]
        cell.selectionStyle = .none
        if transactionDataCell.type == "CR" {
            cell.transactionAmountLabelOutlet.textColor = .systemGreen
            cell.transactionTypeImageOutlet.image = (UIImage(named: "PemasukanColor"))
        } else {
            cell.transactionAmountLabelOutlet.textColor = .systemRed
            cell.transactionTypeImageOutlet.image = (UIImage(named: "PengeluaranColor"))
        }
        cell.transactionAmountLabelOutlet.text = "IDR \(transactionDataCell.money.formattedWithSeparator)  \(transactionDataCell.type)"
        
        let dateFormatter = DateFormatter()
        let date = dateFormatter.convertDateToString(
            from: transactionDataCell.date,
            withFormat: "yyyy-MM-dd HH:mm:ss")
        cell.transactionDateLabelOutlet.text = "Tanggal: \(date)"
        
        cell.transactionCategoryLabelOutlet.text = "Kategori: \(transactionDataCell.category)"
        cell.transactionDescriptionLabelOutlet.text = "Keterangan: \(transactionDataCell.description)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTransactionData = UIContextualAction(
            style: .normal,
            title: "Hapus Data") { action, view, completionHandler in
                self.transactionDataSorted.remove(at: indexPath.row)
                self.transactionListTableViewOutlet.deleteRows(at: [indexPath], with: .left)
                self.transactionDataSorted = self.transactionDataSorted.sorted(by: { $0.date.compare($1.date) == .orderedDescending
                })
                TransactionDataUserDefaults.save(self.transactionDataSorted)
                tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    if self.transactionDataSorted.isEmpty == true {
                        self.sortTransactionButtonOutlet.isHidden = true
                        self.transactionListTableViewOutlet.isHidden = true
                        self.noTransactionLabelOutlet.isHidden = false
                    }
                }
                completionHandler(true)
            }
        deleteTransactionData.image = UIImage(systemName: "trash.fill")
        deleteTransactionData.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteTransactionData])
        return configuration
    }
}
