//
//  FoodCell.swift
//  CalorieTracker
//
//  Created by user915640 on 8/5/19.
//  Copyright © 2019 user915640. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    
    @IBOutlet weak var foodLabel: UILabel!
    
    
    func setFood(food: Food){
        foodLabel.text = food.name
    }
    
    func getFood(food: Food)->Food{
        return food
    }
    
}
