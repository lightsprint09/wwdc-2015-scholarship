//
//  IbanViewController.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 16.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class IbanViewController: UIViewController {
    
    let ibanCalculator = MSIbanCalculator(widthCountryCodeManager: LSCountryCodeManager())

    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var bankCodeTextField: UITextField!
    
    @IBOutlet weak var ibanLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateIBAN()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
