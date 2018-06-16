//
//  AlertService.swift
//  Remind
//
//  Created by Manohar Kurapati on 16/06/2018.
//  Copyright © 2018 Manosoft. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    private init() {}
    
    static func actionSheet(in vc: UIViewController, title: String, Completion: @escaping() -> Void){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            Completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    
}
