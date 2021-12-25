//
//  Home.swift
//  Task
//
//  Created by Khaled on 24/12/2021.
//

import Foundation

protocol HomeNetworkProtocol {
    func getHomeTVShows(completionHandler : @escaping (Result<ShowData?, ResultErrors>)->())
}

class HomeNetwork : HomeNetworkProtocol {
    
    var networkClass = BaseNetwork()
    
    func getHomeTVShows(completionHandler : @escaping (Result<ShowData?, ResultErrors>)->()) {
        networkClass.callService(url: URLS.home.url, param: nil) { (result : Result<ShowData? , ResultErrors>) in
            completionHandler(result)
        }
    }
    
}
