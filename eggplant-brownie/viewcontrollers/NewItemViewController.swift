//
//  NewItemViewController.swift
//  eggplant-brownie
//
//  Created by Rodrigo Filomeno on 25/04/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var caloriesField: UITextField?
    
    var delegate: AddAnItemDelegate?
    init(delegate : AddAnItemDelegate){
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func addNewItem(_ sender: UIButton) {
        
        let name = nameField!.text
        let calories = Double(caloriesField!.text!)
        
        if (name == nil || calories == nil || delegate == nil) {
            return
        }
        
        let item = Item(name: name!, calories: calories!)
        
        delegate!.add(item)
        
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }
 

}
