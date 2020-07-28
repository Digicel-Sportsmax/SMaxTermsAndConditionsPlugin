//
//  SportsMaxTermsViewController.swift
//  SportsmaxTermsAndConditions
//
//  Created by Mohieddine Zarif on 24/04/2020.
//

import Foundation
import UIKit
import SimpleCheckbox

class SportsMaxTermsViewController: UIViewController, SportsMaxDataConsentBaseProtocol {
    
    fileprivate let sportsMaxTermsStoryboard = "SMaxTermsAndConditionsStoryboard"
    fileprivate let sportsMaxDataConsentViewController = "SportsMaxDataConsentViewController"


    public var delegate: SportsMaxTermsBaseProtocol?
    public var data_consent_text: String?
    public var terms_condition_text: String?
    public var navHeaderImage: String?
    public var navHeaderText: String?
    public var navBarBackgroundColor: String?
    public var agreeButtonText: String?
    public var nextButtonText: String?
    public var agreeButtonBackgroundColor: String?
    public var agreeButtonTextColor: String?
    public var termsAndConditionCheckboxText: String?
    public var dataConsentCheckboxText: String?

    @IBOutlet weak var privacyTextLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var iAgreeCheckbox: Checkbox!
    @IBOutlet weak var agreeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = terms_condition_text {
            self.privacyTextLabel.attributedText = text.htmlAttributedString()
        }
        
        iAgreeCheckbox.checkedBorderColor = .black
        iAgreeCheckbox.uncheckedBorderColor = .black
        iAgreeCheckbox.checkmarkStyle = .tick
        iAgreeCheckbox.borderStyle = .square
        iAgreeCheckbox.borderLineWidth = CGFloat(2.0)

        self.agreeButton.isEnabled = false
        
        iAgreeCheckbox.valueChanged = { (isChecked) in
            self.handleNextButton(isChecked)
        }
        
        if let termsCheckboxTxt = self.termsAndConditionCheckboxText {
            self.agreeLabel.text = termsCheckboxTxt
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
        
        if let nextButtonTxt = self.nextButtonText {
            self.agreeButton.setTitle(nextButtonTxt, for: .normal)
        }
        
        if let agreeButtonBgColor = self.agreeButtonBackgroundColor {
            self.agreeButton.backgroundColor = UIColor.init(hex: agreeButtonBgColor)
        }
        
        if let agreeButtonTxtColor = self.agreeButtonTextColor {
            self.agreeButton.tintColor = UIColor.init(hex: agreeButtonTxtColor)
        }
        
    }
    
    func useDidSelectToClose() {
        self.delegate?.userDidSelectToClose()
    }

    @IBAction func agreeBtnDidPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: self.sportsMaxTermsStoryboard, bundle: nil)
        
        if let dataConsentViewController = storyboard.instantiateViewController(withIdentifier: self.sportsMaxDataConsentViewController) as? SportsMaxDataConsentViewController {
            
            dataConsentViewController.data_consent_text = self.data_consent_text
            dataConsentViewController.navHeaderImage = navHeaderImage
            dataConsentViewController.navHeaderText = navHeaderText
            dataConsentViewController.navBarBackgroundColor = navBarBackgroundColor
            dataConsentViewController.agreeButtonText = agreeButtonText
            dataConsentViewController.agreeButtonBackgroundColor = agreeButtonBackgroundColor
            dataConsentViewController.agreeButtonTextColor = agreeButtonTextColor
            dataConsentViewController.dataConsentCheckboxText = dataConsentCheckboxText
            dataConsentViewController.delegate = self
            self.navigationController?.pushViewController(dataConsentViewController, animated: true)
            
        }
        
        
    }
    
    fileprivate func handleNextButton(_ isChecked: Bool) {
        if isChecked {
            self.agreeButton.isEnabled = true
        } else {
            self.agreeButton.isEnabled = false
        }
        
    }

}


// TODO: implement a helper plugin
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}
