//
//  SportsMaxDataConsentViewController.swift
//  SportsmaxTermsAndConditions
//
//  Created by Mohieddine Zarif on 28/07/2020.
//

import Foundation
import UIKit
import DLRadioButton

class SportsMaxDataConsentViewController: UIViewController {
    
    public var delegate: SportsMaxDataConsentBaseProtocol?
    public var data_consent_text: String?
    public var navHeaderImage: String?
    public var navHeaderText: String?
    public var navBarBackgroundColor: String?
    public var agreeButtonText: String?
    public var agreeButtonBackgroundColor: String?
    public var agreeButtonTextColor: String?

    @IBOutlet weak var iAgreeCheckbox: DLRadioButton!
    @IBOutlet weak var dataConsentTextLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = data_consent_text {
            self.dataConsentTextLabel.attributedText = text.htmlAttributedString()
        }
        
        if let bgColor = navBarBackgroundColor {
            self.navigationController?.navigationBar.barTintColor = UIColor.init(hex: bgColor)
        }
         if let imageUrlString = navHeaderImage,
            let imageUrl:URL = URL(string: imageUrlString) {
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 17))
            let image = UIImage(data: imageData as Data)
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imageView
        } else if let navText = navHeaderText {
            self.navigationItem.title = navText
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
        
        if let agreeButtonTxt = self.agreeButtonText {
            self.agreeButton.setTitle(agreeButtonTxt, for: .normal)
        }
        
        if let agreeButtonBgColor = self.agreeButtonBackgroundColor {
            self.agreeButton.backgroundColor = UIColor.init(hex: agreeButtonBgColor)
        }
        
        if let agreeButtonTxtColor = self.agreeButtonTextColor {
            self.agreeButton.tintColor = UIColor.init(hex: agreeButtonTxtColor)
        }
        
    }

    @IBAction func agreeBtnDidPress(_ sender: Any) {
        if let delegate = delegate {
            delegate.useDidSelectToClose()
        }
    }

}
