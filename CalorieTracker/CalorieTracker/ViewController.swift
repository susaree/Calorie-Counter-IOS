//
//  ViewController.swift
//  CalorieTracker
//
//  Created by user915640 on 7/29/19.
//  Copyright © 2019 user915640. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var proteinField: UITextField!
    @IBOutlet weak var carbsfield: UITextField!
    @IBOutlet weak var fatsField: UITextField!
    @IBOutlet weak var caloriesField: UITextField!
    
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Totals")
    
    
    var foods = [Food]()
    var bread = Food("bread",80,4,12,4)
    var rice = Food("rice",130,3,28,1)
    var milk = Food("milk",109,9,13,2)
    var egg = Food("egg",78,6,1,5)
    var apple = Food("apple",95,1,25,1)
    
    
    
    
    var totalCalories: Int = 0
    var totalProtein: Int = 0
    var totalCarbs: Int = 0
    var totalFats: Int = 0
    
    
    @IBAction func resetButton(_ sender: Any) {
        totalCalories = 0
        totalProtein = 0
        totalCarbs = 0
        totalFats = 0
        updateCoreData()
    }
    
    
    @IBAction func addFood(_ sender: Any) {
        
        
        textField.resignFirstResponder()
        
        
        

        for food in foods {
            if textField.text == food.name{
                totalCalories += food.calories
                totalProtein += food.protein
                totalCarbs += food.carbs
                totalFats += food.fats
            }
            
        }
        
        updateCoreData()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        foods.append(bread)
        foods.append(rice)
        foods.append(milk)
        foods.append(egg)
        foods.append(apple)
        
        
        
        getCoreData()
        
        
        
    }
    
    func getCoreData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Totals")
        
        do{
            let results = try context.fetch(request)
            for data in results as! [NSManagedObject]{
                totalCalories = data.value(forKey: "calories") as! Int
                totalProtein = data.value(forKey: "protein") as! Int
                totalCarbs = data.value(forKey: "carbs") as! Int
                totalFats = data.value(forKey: "fat") as! Int
                
            }
        }catch {
            print("failed")
        }
        caloriesField.text = String(totalCalories)
        proteinField.text = String(totalProtein)
        carbsfield.text = String(totalCarbs)
        fatsField.text = String(totalFats)
    }
    
    func updateCoreData(){
        do {
            let results = try context.fetch(request)
            
            for data in results as! [NSManagedObject]{
                
                data.setValue(totalCalories, forKey: "calories")
                data.setValue(totalProtein, forKey: "protein")
                data.setValue(totalCarbs, forKey: "carbs")
                data.setValue(totalFats, forKey: "fat")
            }
            
            do{
                try context.save()
            }
            catch{
                print("failed")
            }
        }
        catch{
            print("failed")
        }
        getCoreData()
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        
        cell.setFood(food: food)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
