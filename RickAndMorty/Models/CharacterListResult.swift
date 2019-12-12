//
//  Character.swift
//  RickAndMorty
//
//  Created by Ricardo Ruiz on 12/12/2019.
//  Copyright © 2019 Ricardo Ruiz. All rights reserved.
//

import Foundation

struct CharacterListResult : Encodable, Decodable {
    var info : PageInfo
    var results : [Character]
}

struct PageInfo : Encodable, Decodable {
    var count : Int
    var pages : Int
    var next : String
    var prev : String
}

struct Character : Encodable, Decodable {
    var id : Int
    var name : String
    var status : String
    var species : String
    var type : String
    var gender : String
    var origin : Origin
    var location : Location
    var image : String
    var episode : [String]
    var url : String
    var created : String
}

struct Origin : Encodable, Decodable {
    var name : String
    var url : String
}

struct Location : Encodable, Decodable {
    var name : String
    var url : String
}
