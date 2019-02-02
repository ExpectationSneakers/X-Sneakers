//
//  PayViewController.swift
//  ExpectationSneakers
//
//  Created by Brian Morales on 1/31/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import PassKit

class PayViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var otraTarjetaLabel: UIButton!
    
    @IBOutlet weak var applePayView: UIView!
    
    var email : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        applePayView.layer.cornerRadius = 5
        applePayView.layer.borderWidth = 1
        applePayView.layer.borderColor = UIColor.lightGray.cgColor
        
        totalLabel.layer.cornerRadius = 5
        totalLabel.layer.borderWidth = 1
        totalLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        otraTarjetaLabel.layer.cornerRadius = 5
        otraTarjetaLabel.layer.borderWidth = 1
        otraTarjetaLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        self.view.layoutIfNeeded()
        
        let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .white)
        
        applePayButton.addTarget(self, action: #selector(applePayPressed), for: .touchUpInside)
        
        applePayButton.frame = CGRect(x: 0, y: 0, width: self.applePayView.frame.size.width, height: self.applePayView.frame.size.height)
        
        self.applePayView.addSubview(applePayButton)
    }
    
    @objc func applePayPressed() {
        let request = PKPaymentRequest()
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.countryCode = "MX"
        request.currencyCode = "MXN"
        request.merchantIdentifier = "Expectation.Sneakers"
        request.merchantCapabilities = .capability3DS
        
        
        request.requiredShippingContactFields = [.name,.emailAddress,.postalAddress,.phoneNumber]
        
        let costoAirMax = NSDecimalNumber(decimal: 2300)
        let costoTimberland = NSDecimalNumber(decimal: 3000)
        let totalPago = NSDecimalNumber(decimal: 5300.00)
        
        let items = PKPaymentSummaryItem(label: "Air Max 90", amount: costoAirMax)
        let items2 = PKPaymentSummaryItem(label: "Timberlan", amount: costoTimberland)
        let cash = PKPaymentSummaryItem(label: "", amount: totalPago)
        
        request.paymentSummaryItems = [items,items2,cash]
        
        let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayVC?.delegate = self
        self.present(applePayVC ?? self, animated: true, completion: nil)
        
    }
    
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,didAuthorizePayment payment: PKPayment,handler completion: @escaping (PKPaymentAuthorizationResult) -> Void)
    {
        self.email = payment.shippingContact?.emailAddress
        completion(.init(status: .success, errors: nil))
    }

    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController)
    {
        controller.dismiss(animated: true){
            if let email = self.email{
                self.performSegue(withIdentifier: "showThankYou", sender: email)
                self.email = nil
            }
        }
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
