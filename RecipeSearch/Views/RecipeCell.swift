//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by casandra grullon on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
 
    func configureCell(for recipe: Recipe){
        recipeLabel.text = recipe.label
        
        //set image using UIImageView extension
        recipeImage.getImage(with: recipe.image) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.recipeImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.recipeImage.image = image
                }
            }
        }
        
    }
    
}
