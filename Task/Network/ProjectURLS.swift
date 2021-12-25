//
//  ProjectURLS.swift
//  Task
//
//  Created by Khaled on 24/12/2021.
//

import Foundation

enum URLS {
    case home
    
    var url : String {
        switch self {
        case .home: return "http://api.tvmaze.com/search/shows?q=Future"
        }
    }
}
