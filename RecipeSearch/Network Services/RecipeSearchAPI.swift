//
//  RecipeSearchAPI.swift
//  RecipeSearch
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearchAPI {
    
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError >) -> ()) {
        
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKeys.appId)&app_key=\(SecretKeys.appKey)&from=0&to=50"
        
        guard let url = URL(string: recipeEndpointURL) else {
            completion(.failure(.badURL(recipeEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let searchResults = try JSONDecoder().decode(RecipeSearch.self, from: data)
                   //1. TODO: Use searchResults to create an array of recipes.
                    //2. TODO: capture an array of recipes in the completion handler
                    
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            
            }
        }
        
        
    }
    
}
