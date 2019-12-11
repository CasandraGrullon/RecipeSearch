//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
  
    //1. TODO: create a tableView
    @IBOutlet weak var tableView: UITableView!
    //2. TODO: recipes array
    //3. TODO: recipes array needs a didSet to update the tableview
    var recipes = [Recipe](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
    }
    var searchQuery = "scallion pancakes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(search: searchQuery)
        tableView.dataSource = self
    }
    //4. TODO: in cellForRow, show recipes label
    //5. TODO: RecipeSearchAPI.fetchRecipes accessing data to populate recipes array
    func loadData(search: String){
        RecipeSearchAPI.fetchRecipe(for: search) { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                self.recipes = data
            }
        }
    }
    
}
extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.label
        return cell 
    }
}
