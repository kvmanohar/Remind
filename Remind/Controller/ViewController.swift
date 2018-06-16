//
//  ViewController.swift
//  Remind
//
//  Created by Manohar Kurapati on 14/06/2018.
//  Copyright © 2018 Manosoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.shared.autohrise()
    }

    @IBAction func timerTapped(_ sender: UIButton) {
        print("Timer Tappped")
    }
    
    @IBAction func locationTapped(_ sender: UIButton) {
        print("Location Tapped")
        
    }
    
    @IBAction func dateTapped(_ sender: UIButton) {
        print("Date Tapped")
    }
    
}

