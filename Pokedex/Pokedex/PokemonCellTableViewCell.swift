//
//  PokemonCellTableViewCell.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/10/23.
//

import UIKit

//implements a custom cell view to be returned in UITableCell
class PokemonCellTableViewCell: UITableViewCell {

    var pokemonImage = UIImageView()
    var pokemonName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(pokemonImage)
        addSubview(pokemonName)
        
        configureImageView()
        configurePokemonName()
        setImageConstraints()
        setLabelConstraints()
    }
    
    func setCellViewInfo(name:String, num:Int) {
        //pokemonImage.image = UIImage(image) //sets the image for the UIImageView included in cell
        pokemonName.text = name //sets the text label for view to name of pokemon
        pokemonImage.image = UIImage(named: "\(num)")
    }
    
    func configureImageView() {
        pokemonImage.layer.cornerRadius = 10
        pokemonImage.clipsToBounds = true
    }
    
    func configurePokemonName() {
        pokemonName.numberOfLines = 0
        pokemonName.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant:12).isActive = true
        pokemonImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pokemonImage.widthAnchor.constraint(equalTo: pokemonImage.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setLabelConstraints() {
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pokemonName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant:20).isActive = true
        pokemonName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
