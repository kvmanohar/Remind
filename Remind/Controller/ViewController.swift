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
        CLService.shared.authorise()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotificaiton.enteredRegion"),
                                               object: nil)
        
        //internalNotification.handleAction
        NotificationCenter.default.addObserver(self, selector: #selector(handleAction),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
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
            CLService.shared.updateLocation();
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
    
    @objc
    func didEnterRegion(){
        UNService.shared.locationRequest()
    }
    
    @objc
    func handleAction(_ sender: Notification){
        
        guard let action = sender.object as? NotificationActionID else { return }
        switch action {
        case .timer:
            print("Timer Logic")
        case .date:
            print("Date Logic")
        case .location:
            print("Location logic")
            view.backgroundColor = .red
        }
    }
    
}

