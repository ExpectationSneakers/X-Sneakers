//
//  ThankYouViewController.swift
//  ExpectationSneakers
//
//  Created by Brian Morales on 2/1/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    
    @IBOutlet weak var confView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let confView = SAConfettiView(frame: self.confView.bounds)
//        self.view.addSubview(confView)
//        confView.type = .diamond
//        confView.startConfetti()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func volverButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
