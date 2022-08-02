//
//  InfoViewController.swift
//  Mankepri
//
//  Created by Maulana Frasha on 30/07/22.
//

import UIKit

final class InfoViewController: UIViewController {
    
    @IBOutlet weak var creatorImageViewOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorImageViewOutlet.layer.cornerRadius = creatorImageViewOutlet.frame.size.width/2
    }
    
    @IBAction func tabBarButtonHomeTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "HomeViewController", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion:nil)
    }
}
