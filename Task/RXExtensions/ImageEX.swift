//
//  ImageEX.swift
//  Task
//
//  Created by Khaled on 25/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base : UIImageView {
    
    var imgURL : Binder<URL?> {
        return Binder(self.base , scheduler : ConcurrentDispatchQueueScheduler(qos: .background)) { img, url in
            BaseNetwork().loadImage(url: url) { _, image in
                img.image = image
            }
        }
    }
    
}
