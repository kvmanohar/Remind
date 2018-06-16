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
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
        
    }
    
    @IBAction func locationTapped(_ sender: UIButton) {
        print("Location Tapped")
        AlertService.actionSheet(in: self, title: "When I return") {
            
        }
    }
    
    @IBAction func dateTapped(_ sender: UIButton) {
        print("Date Tapped")
        
        AlertService.actionSheet(in: self, title: "Some Future time") {
            var components = DateComponents()
            components.second = 0   //Everytime clock hits 0 second
            
            UNService.shared.dateRequest(with: components)
        }

    }
    
}

