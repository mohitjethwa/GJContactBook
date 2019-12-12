//
//  GJBaseViewController.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJBaseViewController: UIViewController {

    lazy var activityIndicator: UIActivityIndicatorView  = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubviewToFront(self.activityIndicator)
    }
    
    func showAlert(text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK!", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    
    func addGradient(firstColor: UIColor, secondColor: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 50.0, width: self.frame.size.width, height: (self.frame.size.height-50.0))
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
