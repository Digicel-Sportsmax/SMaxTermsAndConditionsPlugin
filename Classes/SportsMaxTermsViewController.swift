//
//  SportsMaxTermsViewController.swift
//  SportsmaxTermsAndConditions
//
//  Created by Mohieddine Zarif on 24/04/2020.
//

import Foundation

class SportsMaxTermsViewController: UIViewController {
    
    public var delegate: SportsMaxTermsBaseProtocol?
    public var terms_condition_text: String?
    @IBOutlet weak var privacyTextLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = terms_condition_text {
            self.privacyTextLabel.text = text
        }
    }

    @IBAction func agreeBtnDidPress(_ sender: Any) {
        if let delegate = delegate {
            delegate.userDidSelectToClose()
        }
    }
    
    @IBAction func closeBtnDidPress(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.userDidSelectToClose()
        }
    }
}
