//
//  RemoveMealController.swift
//  eggplant-brownie
//
//  Created by Rodrigo Filomeno on 30/04/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation
import UIKit

class RemoveMealController {
    
    let controller:UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func show(_ meal:Meal, handler:@escaping (UIAlertAction) -> Void){
        
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        details.addAction(cancel)
        let remove = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: handler)
        
        details.addAction(remove)
        controller.present(details, animated: true, completion: nil)
    }
}
