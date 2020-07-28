//
//  SportsMaxDataConsentViewController.swift
//  SportsmaxTermsAndConditions
//
//  Created by Mohieddine Zarif on 28/07/2020.
//

import Foundation
import UIKit

class SportsMaxDataConsentViewController: UIViewController {
    
    public var delegate: SportsMaxDataConsentBaseProtocol?
    public var data_consent_text: String?
    public var navHeaderImage: String?
    public var navHeaderText: String?
    public var navBarBackgroundColor: String?
    public var agreeButtonText: String?
    public var agreeButtonBackgroundColor: String?
    public var agreeButtonTextColor: String?
    public var dataConsentCheckboxText: String?
    @IBOutlet weak var agreeLabel: UILabel!
    
    @IBOutlet weak var iAgreeCheckbox: VKCheckbox!
    
    @IBOutlet weak var dataConsentTextLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCheckbox()

        if let text = data_consent_text {
            self.dataConsentTextLabel.attributedText = text.htmlAttributedString()
        }
        
        if let dataCheckboxText = self.dataConsentCheckboxText {
            self.agreeLabel.text = dataCheckboxText
        }
        
        self.setupHeader()
        
        if let agreeButtonTxt = self.agreeButtonText {
            self.agreeButton.setTitle(agreeButtonTxt, for: .normal)
        }
        
        self.agreeButton.isEnabled = false
        self.agreeButton.adjustsImageWhenDisabled = false
        self.handleNextButton(false)
        
        if let agreeButtonTxtColor = self.agreeButtonTextColor {
            self.agreeButton.tintColor = UIColor.init(hex: agreeButtonTxtColor)
        }
        
    }

    @IBAction func agreeBtnDidPress(_ sender: Any) {
        if let delegate = delegate {
            delegate.useDidSelectToClose()
        }
    }
    
    fileprivate func handleNextButton(_ isChecked: Bool) {
        if isChecked {
            self.agreeButton.isEnabled = true
            if let agreeButtonBgColor = self.agreeButtonBackgroundColor {
                self.agreeButton.backgroundColor = UIColor.init(hex: agreeButtonBgColor)
            } else {
                self.agreeButton.backgroundColor = UIColor.green
            }
        } else {
            self.agreeButton.isEnabled = false
            self.agreeButton.backgroundColor = UIColor.lightGray
        }
    }

    fileprivate func setupHeader() {

        self.navigationItem.setHidesBackButton(true, animated: false)

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
    }
    
    fileprivate func setupCheckbox() {
        // Customized checkbox
        iAgreeCheckbox.line             = .normal
        iAgreeCheckbox.bgColorSelected  = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        iAgreeCheckbox.bgColor          = UIColor.white
        iAgreeCheckbox.color            = UIColor.white
        iAgreeCheckbox.borderColor      = UIColor.black
        iAgreeCheckbox.borderWidth      = 2
        iAgreeCheckbox.cornerRadius     = 2.0
        
        // Handle custom checkbox callback
        iAgreeCheckbox.checkboxValueChangedBlock = {
            isOn in
            self.handleNextButton(isOn)
        }
    }

}
