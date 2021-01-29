//
//  MovieData.swift
//  Proyecto
//
//  Created by Jessica Villa on 26/01/21.
//

import Foundation

struct MovieData: Codable{
    let results: [Results]?
    
    struct Results: Codable {
        let id: Int?
        let overview: String?
        let title: String?
        let vote_average: Double?
        let poster_path: String?
    }
    
 
}
