//
//  EnterViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 05/07/22.
//

import UIKit
import LocalAuthentication

final class EnterViewController: UIViewController {
    
    @IBOutlet weak var buttonMasukOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonMasukOutlet.layer.cornerRadius = 8
    }
   
    @IBAction func buttonKeluarTapIn(_ sender: Any) {
        moveToHome()
    }
    
    func moveToHome() {
        if BiometricSwitchCache.get() == true {
            biometricSetUp()
        } else {
            goToHomeViewController()
        }
    }
    
    func biometricSetUp() {
        let contect = LAContext()
        var error: NSError? = nil
        if contect.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            let reason = "Face ID dibutuhkan untuk membuka Mankepri."
            contect.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [weak self] success, error in DispatchQueue.main.async {
                    guard success, error == nil else { return }
                    //show home screen
                    self?.goToHomeViewController()
                }
            }
        } else {
            // dont have biometric
            let alert = UIAlertController(title: "Gagal otentikasi", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    func goToHomeViewController() {
        let viewController = UIStoryboard(name: "HomeViewController", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion:nil)
    }
}
