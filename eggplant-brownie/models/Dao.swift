//
//  Dao.swift
//  eggplant-brownie
//
//  Created by Rodrigo Filomeno on 30/04/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation

class Dao{
    let mealsArchive: String
    let itensArchive:String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        self.mealsArchive = "\(dir)/eggplant-brownie-meals.dados"
        self.itensArchive = "\(dir)/eggplant-brownie-itens.dados"
    }
    
    func save(_ meals:Array<Meal>){
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
    }
    
    func save(_ itens:Array<Item>){
        NSKeyedArchiver.archiveRootObject(itens, toFile: itensArchive)
    }
    
    func load() -> Array<Meal>{
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: mealsArchive){
            let meals = loaded as! Array<Meal>
            return meals
        }
        
        return []
    }
    
    func load() -> Array<Item>{
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itensArchive){
            let itens = loaded as! Array<Item>
            return itens
        }
        
        return []
    }
    
    
}
