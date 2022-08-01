//
//  SettingViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 28/07/22.
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var biometricSwitchOutlet: UISwitch!
    @IBOutlet weak var buttonBackOutlet: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UsernameUserDefaults.check() == true {
            let usernameDefaults = UsernameUserDefaults.get()
            usernameLabelOutlet.text = "\(usernameDefaults)"
        } else {
            usernameLabelOutlet.text = "Pengguna"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBackOutlet.layer.cornerRadius = 8
        biometricSwitchOutlet.isOn = BiometricSwitchCache.get()
    }
    
    @IBAction func buttonEditUsernameTapIn(_ sender: Any) {
        changeNameAlert()
    }
    
    @IBAction func switchStateTapIn(_ sender: UISwitch) {
        BiometricSwitchCache.save(sender.isOn)
    }
    
    @IBAction func buttonResetTapIn(_ sender: Any) {
        resetButtonAlert()
    }
    
    @IBAction func buttonBackTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func changeNameAlert() {
        let alert = UIAlertController(
            title: "Ubah Nama.",
            message: "Masukan nama pengguna",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .destructive, handler: { ACTION in }))
        alert.addTextField { textfield in
            textfield.textAlignment = .center
            textfield.placeholder = "Maks. 15 huruf"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { ACTION in
            let textfieldValue = alert.textFields?.first?.text
            UsernameUserDefaults.save(textfieldValue!)
            self.usernameLabelOutlet.text = UsernameUserDefaults.get()
            CustomToast.show(
                message: "Nama berhasil dirubah.",
                bgColor: .systemGreen,
                textColor: .white,
                labelFont: .systemFont(ofSize: 17),
                showIn: .bottom,
                controller: self)
        })
        self.present(alert, animated: true)
    }
    
    func resetButtonAlert() {
        let alert = UIAlertController(title: "Peringatan!", message: "Anda akan menghapus data yang anda pilih.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { ACTION in }))
        alert.addAction(UIAlertAction(title: "Hapus Seluruh Data", style: .destructive) { ACTION in
            if let domain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: domain)
            }
            CustomToast.show(
                message: "Berhasil hapus seluruh data, \nSilahkan buka aplikasi kembali.",
                bgColor: .systemGreen,
                textColor: .white,
                labelFont: .systemFont(ofSize: 17),
                showIn: .bottom,
                controller: self)
            self.closeApp()
        })
        alert.addAction(UIAlertAction(
            title: "Hapus Kategori Pemasukan",
            style: .destructive, handler: { ACTION in
                CategoryDataIncomeDefaults.delete()
                CustomToast.show(
                    message: "Berhasil hapus kategori pemasukan.",
                    bgColor: .systemGreen,
                    textColor: .white,
                    labelFont: .systemFont(ofSize: 17),
                    showIn: .bottom,
                    controller: self)

            }))
        
        alert.addAction(UIAlertAction(
            title: "Hapus Kategori Pengeluaran",
            style: .destructive, handler: { ACTION in
                CategoryDataSpendingDefaults.delete()
                CustomToast.show(
                    message: "Berhasil hapus kategori pengeluaran.",
                    bgColor: .systemGreen,
                    textColor: .white,
                    labelFont: .systemFont(ofSize: 17),
                    showIn: .bottom,
                    controller: self)

            }))
        self.present(alert, animated: true)
    }
    
    func closeApp(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              exit(0)
             }
        }
    }
}
