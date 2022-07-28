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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBackOutlet.layer.cornerRadius = 8
        biometricSwitchOutlet.isOn = BiometricSwitchCache.get()
    }
    
    @IBAction func buttonEditUsernameTapIn(_ sender: Any) {
        
    }
    
    @IBAction func switchStateTapIn(_ sender: UISwitch) {
        BiometricSwitchCache.save(sender.isOn)
    }
    
    
    @IBAction func buttonResetTapIn(_ sender: Any) {
        closeApp()
    }
    
    @IBAction func buttonBackTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func closeApp(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              exit(0)
             }
        }
    }
}
