//
//  BaseNetwork.swift
//  Task
//
//  Created by Khaled on 24/12/2021.
//

import UIKit

public enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
}

class BaseNetwork {
    
    //MARK: - Call API Service
    final func callService<T : Codable>(url : String , method : HTTPMethod = .get , param : [String : Any]? = nil , header : [String : Any]? = nil , completionHandler : @escaping (Result<T? , ResultErrors>)->()) {
        guard var components = URLComponents(string: url) else {
            completionHandler(.failure(.err_message("URL ERROR")))
            return
        }
        
        if let parameter = param {
            components.queryItems = parameter.map({ (key , value) in
                return URLQueryItem(name: key, value: "\(value)")
            })
        }
        
        guard let reqUrl = components.url else { return }
        var request = URLRequest(url: reqUrl)
        request.httpMethod = method.rawValue
        
        if let head = header {
            head.forEach({ (key , value) in
                request.setValue(key, forHTTPHeaderField: "\(value)")
            })
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.err_message(error.debugDescription)))
                return
            }
            
            guard let data = data , let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.err_message("No Data")))
                return
            }
            
            guard response.statusCode == 200 else {
                completionHandler(.failure(.err_message("Status Code Error")))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                print("Response is \(responseData)")
                completionHandler(.success(responseData))
            } catch {
                print(error)
                completionHandler(.failure(.err_message(error.localizedDescription)))
            }
        }.resume()
        
    }
    
    //MARK: - DownLoad Image
    func loadImage(url : URL? , completionHandler : @escaping (String , UIImage?)->()) {
        
        guard let url = url else { return }
        
        if let dic = UserDefaults.standard.object(forKey: "ImgCache") as? [String : String] {
            if let path = dic["\(url)"] {
                if  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completionHandler("\(url)" , image)
                    }
                    return
                }
            }
        }
        
        URLSession.shared.dataTask(with: url) { (data , _ , error) in
            print("WILL DOWNLOAD IMAGE")
            guard error == nil else { print("Error Image") ; return }
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let img = UIImage(data: data) {
                    CacheImages().storeImages(imgURL: url, img: img)
                    completionHandler("\(url)" , img)
                }
            }
        }.resume()
    }
    
}
