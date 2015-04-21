//
//  IbanViewController.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 16.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import StoreKit

class IbanViewController: UIViewController,SKStoreProductViewControllerDelegate {
    
    let ibanCalculator = MSIbanCalculator(widthCountryCodeManager: LSCountryCodeManager())

    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var bankCodeTextField: UITextField!
    
    @IBOutlet weak var ibanLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateIBAN()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onAccountNumberCahnge(sender: UITextField) {
        ibanCalculator.accountNumber = sender.text
        updateIBAN()
    }

    @IBAction func onBankCodeChange(sender: UITextField) {
        ibanCalculator.blz = sender.text;
        updateIBAN()
    }
    
    func updateIBAN() {
        ibanLabel.text = ibanCalculator.iban
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        accountNumberTextField.resignFirstResponder()
        bankCodeTextField.resignFirstResponder()
    }
    @IBAction func showInAppStore(sender: AnyObject) {
       let productViewController = SKStoreProductViewController()
        productViewController.delegate = self;
        productViewController.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier: NSNumber(integer: 882254188)], completionBlock: didLoadStoreKitProcut)
        presentViewController(productViewController, animated: true, completion: nil)
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        viewController.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didLoadStoreKitProcut(success:Bool, error:NSError!) {
        
    }

}
