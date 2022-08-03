//
//  TransactionListViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import UIKit

final class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var transactionListTableViewOutlet: UITableView!
    @IBOutlet weak var noTransactionLabelOutlet: UILabel!
    @IBOutlet weak var okButtonOutlet: UIButton!
    private var transactionDataSorted: [TransactionDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if TransactionDataUserDefaults.check() == false {
            transactionListTableViewOutlet.isHidden = true
            noTransactionLabelOutlet.isHidden = false
        } else {
            transactionListTableViewOutlet.isHidden = false
            noTransactionLabelOutlet.isHidden = true
            transactionDataSorted = TransactionDataUserDefaults.get()
            transactionDataSorted = transactionDataSorted.sorted(by: { $1.date.compare($0.date) == .orderedDescending
            })
            transactionListTableViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButtonOutlet.layer.cornerRadius = 8
        transactionListTableViewOutlet.register(UINib.init(nibName:"TransactionListCell" , bundle: nil), forCellReuseIdentifier: "TransactionListCell")
        transactionListTableViewOutlet.delegate = self
        transactionListTableViewOutlet.dataSource = self
    }
    
    @IBAction func transactionListSortButtonTapIn(_ sender: Any) {
        sortData()
    }
    
    @IBAction func okButtonTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sortData() {
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: transactionDataCell.date)
        cell.transactionDateLabelOutlet.text = "Tanggal: \(date)"
        
        cell.transactionCategoryLabelOutlet.text = "Kategori: \(transactionDataCell.category)"
        cell.transactionDescriptionLabelOutlet.text = "Keterangan: \(transactionDataCell.description)"
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTransactionData = UIContextualAction(
            style: .destructive,
            title: "Hapus Data") { action, view, completionHandler in
                self.transactionDataSorted.remove(at: indexPath.row)
                self.transactionListTableViewOutlet.deleteRows(at: [indexPath], with: .left)
                self.transactionDataSorted = self.transactionDataSorted.sorted(by: { $0.date.compare($1.date) == .orderedDescending
                })
                TransactionDataUserDefaults.save(self.transactionDataSorted)
                completionHandler(true)
            }
        deleteTransactionData.image = UIImage(systemName: "trash.fill")
        deleteTransactionData.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteTransactionData])
        return configuration
    }
}
