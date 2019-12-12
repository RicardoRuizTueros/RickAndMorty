//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Ricardo Ruiz on 12/12/2019.
//  Copyright © 2019 Ricardo Ruiz. All rights reserved.
//

import Foundation
import UIKit

class CharacterCell : UITableViewCell {
    var characterImage = UIImageView()
    var name = UILabel()
    var species = UILabel()
    
    convenience init(character : Character)
    {
        self.init(style: .default, reuseIdentifier: "CharacterCell")
        
        name.text = character.name
        species.text = character.species
        species.font = UIFont.preferredFont(forTextStyle: .subheadline)
        characterImage.load(url: URL(string: character.image)!)
        
        addSubview(characterImage)
        addSubview(name)
        addSubview(species)

        characterImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        species.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            characterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            characterImage.widthAnchor.constraint(equalTo: heightAnchor),

            name.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5),
            name.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 250),

            species.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            species.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            species.heightAnchor.constraint(equalToConstant: 20),
            species.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
