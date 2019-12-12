//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
        searchRecipe(search: searchQuery)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    //4. TODO: in cellForRow, show recipes label
    //5. TODO: RecipeSearchAPI.fetchRecipes accessing data to populate recipes array
    func searchRecipe(search: String){
        RecipeSearchAPI.fetchRecipe(for: search) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                self?.recipes = data
            }
        }
    }
    
}

extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
            fatalError("recipe cell issue")
        }
        let recipe = recipes[indexPath.row]
        
        cell.configureCell(for: recipe)
        return cell 
    }
}

extension RecipeSearchController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension RecipeSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //use guard to unwrap the searchbar.text property - bc its optional
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        
        searchRecipe(search: searchText)
        
    }
}
