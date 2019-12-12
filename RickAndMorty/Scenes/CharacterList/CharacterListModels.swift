//
//  CharacterListModels.swift
//  RickAndMorty
//
//  Created by Ricardo Ruiz on 12/12/2019.
//  Copyright (c) 2019 Ricardo Ruiz. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CharacterList
{
    // MARK: Use cases
    
    enum LoadCharacters
    {
        struct Request
        {
        }
        
        struct Response
        {
            var characterListResult : CharacterListResult
        }
        
        struct ViewModel
        {
            var characterListResult : [Character]
        }
        
    }
    
    enum CharacterDetails
    {
        struct Request
        {
            var character : Character
        }
        
        struct Response
        {
        }
        
        struct ViewModel
        {
        }
        
    }
}
