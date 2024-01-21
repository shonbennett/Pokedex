//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/10/23.
//

import UIKit

//implements a custom cell view to be returned in UITableCell
class PokemonViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"
    
    var pokemonImage = UIImageView()
    var pokemonName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(pokemonImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pokemonImage.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.image = nil
    }
    
    func setCellViewInfo(name:String, num:Int) {
        pokemonName.text = name //sets the text label for view to name of pokemon
        pokemonImage.image = UIImage(named: "\(num)") //sets the pokemon image for the UIImageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
