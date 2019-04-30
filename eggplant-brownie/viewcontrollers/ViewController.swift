//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Alura on 19/09/16.
//  Copyright © 2016 Alura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {

    @IBOutlet var nameField : UITextField?
    @IBOutlet var happinessField : UITextField?
    var delegate : AddAMealDelegate?
    
    var itens = [
    Item(name: "Eggplant", calories: 10),
    Item(name: "Brownie", calories: 10),
    Item(name: "Zucchini", calories: 10),
    Item(name: "Muffin", calories: 10),
    Item(name: "Cocconut oil", calories: 500),
    Item(name: "Chocolate frosting", calories: 1000),
    Item(name: "Chocolate chip", calories: 1000)]
    var selected = Array<Item>()
    @IBOutlet var tableView : UITableView?
    
    func add(_ item: Item) {
        itens.append(item)
        Dao().save(itens)
        
        if let table = tableView{
            table.reloadData()
        }else{
            Alert(controller: self).show(message: "Unable to update table")
        }
    }
    
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
        
        self.itens = Dao().load()
        
    }
    func showNewItem(){
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController{
            navigation.pushViewController(newItem, animated: true)
        }else{
            Alert(controller: self).show()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == UITableViewCellAccessoryType.none{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                selected.append(itens[indexPath.row])
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.none
                if let position = selected.index(of: itens[indexPath.row]){
                    selected.remove(at: position)
                }else{
                    Alert(controller: self).show()
                }
            }
        } else{
            Alert(controller: self).show()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        let row = indexPath.row
        let item = itens[row]
        cell.textLabel!.text = item.name
        return cell
    
    }
    
    func convertToInt(_ text: String?)-> Int?{
        if let number = text{
            return Int(number)
        }
        return nil
    }
    
    func getMealFromForm()-> Meal?{
        if let name = nameField?.text{
            if let happiness = convertToInt(happinessField?.text){
                let meal = Meal(name: name, happiness: happiness, items: selected)
                
                print("eaten \(meal.name) with happiness \(meal.happiness) with \(meal.items)!")
                return meal
            }
        }
        
        
        return nil
    }
    
    @IBAction func add() {
        
        if let meal = getMealFromForm(){
            if let meals = delegate{
                meals.add(meal)
                
                if let navigation = navigationController {
                    navigation.popViewController(animated: true)
                }else{
                    Alert(controller: self).show(message: "Unable to go back, but the meal was added.")
                }
                return
            }
        }
       Alert(controller: self).show()
        
    }
    
}










