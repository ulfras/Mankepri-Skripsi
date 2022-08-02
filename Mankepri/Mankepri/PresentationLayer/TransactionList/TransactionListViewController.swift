//
//  TransactionListViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import UIKit

final class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var transactionListTableViewOutlet: UITableView!
    @IBOutlet weak var okButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButtonOutlet.layer.cornerRadius = 8
        transactionListTableViewOutlet.register(UINib.init(nibName:"TransactionListCell" , bundle: nil), forCellReuseIdentifier: "TransactionListCell")
        transactionListTableViewOutlet.delegate = self
        transactionListTableViewOutlet.dataSource = self
    }

    
    @IBAction func okButtonTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "TransactionListCell", for: indexPath)
        guard let cell = reusableCell as? TransactionListCell else { return reusableCell }
        
        return cell
    }
    
    
}
