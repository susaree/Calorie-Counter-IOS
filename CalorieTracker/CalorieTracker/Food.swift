struct Food {
    var name:String
    var calories:Int
    var protein:Int
    var carbs:Int
    var fats:Int
    
    init(_ name:String,_ calories:Int,_ protein:Int,_ carbs:Int,_ fats:Int) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
    }
    
}
