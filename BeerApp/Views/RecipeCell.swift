//
//  RecipeCell.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import UIKit

final class RecipeCell: UITableViewCell {
    
    @IBOutlet var abv: UILabel!
    @IBOutlet var tagLine: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descript: UILabel!
    @IBOutlet var butleImage: UIImageView!
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        abv.text = "ABV: \(recipe.abv ?? 0)"
        descript.text = recipe.description
        tagLine.text = recipe.tagLine
        
        DispatchQueue.global().async {
            guard let stringUrl = recipe.imageUrl else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.butleImage.image = UIImage(data: imageData)
            }
        }
    }
}

