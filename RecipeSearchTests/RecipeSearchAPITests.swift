//
//  RecipeSearchAPITests.swift
//  RecipeSearchTests
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchAPITests: XCTestCase {

    //async test - not unit test
    func testSearchScallionPancakes() {
        //1. arrange
        
        //q section from postman
        let searchQuery = "scallion pancakes".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        //.addingPercentEncoding allows us to add a space to a url
        
        //****REQUIRED
        let exp = XCTestExpectation(description: "search found")
        
        //using string interpolation to build endpointURL
        //Later we will look at URLComponents and URLQueryItems
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKeys.appId)&app_key=\(SecretKeys.appKey)&from=0&to=50"
        
        let request = URLRequest(url: URL(string: recipeEndpointURL)!)
        
        //2. act
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let data):
                //****REQUIRED
                //without exp.fulfill(), the assert will never happen
                exp.fulfill()
                //3. assert
                XCTAssertGreaterThan(data.count, 800000, "data should be greater than \(data.count)")
            }
        }
        //****REQUIRED
        //waiting to get data. After 5 seconds, app fails
        wait(for: [exp], timeout: 5.0)
        
    }
    
    //3. write an async test to validate you do get back 50 recipes for the search.
    func testFetchRecipes(){
        //arrange
        let expectedRecipeCount = 50
        let exp = XCTestExpectation(description: "50 recipes found")
        
        let searchQuery = "scallion pancakes"
        
        //act
        RecipeSearchAPI.fetchRecipe(for: searchQuery) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let recipes):
                exp.fulfill()
                XCTAssertEqual(recipes.count, expectedRecipeCount)
                
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}
