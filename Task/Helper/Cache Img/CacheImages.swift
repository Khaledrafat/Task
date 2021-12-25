//
//  CacheImages.swift
//  Task
//
//  Created by Khaled on 25/12/2021.
//

import UIKit

class CacheImages {
    
    func storeImages(imgURL : URL , img : UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 1)
        try? data?.write(to: url)
        
        var dic = UserDefaults.standard.object(forKey: "ImgCache") as? [String : String]
        if dic == nil {
            dic = [String : String]()
        }
        if dic!.count > 40 {
            for item in dic! {
                let key = item.key
                dic!.removeValue(forKey: key)
                break
            }
        }
        dic!["\(imgURL)"] = path
        UserDefaults.standard.setValue(dic, forKey: "ImgCache")
    }
    
}
