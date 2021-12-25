//
//  ShowDetailsVM.swift
//  Task
//
//  Created by Khaled on 25/12/2021.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

class ShowDetailsVM {
    
    private var showDetails_PS = PublishSubject<ShowDetails>()
    var showDetails : Observable<ShowDetails> {
        return showDetails_PS.asObservable()
    }
    
    var name = BehaviorRelay<String>(value: "")
    var genre = BehaviorRelay<String>(value: "")
    var link = BehaviorRelay<String>(value: "")
    var rate = BehaviorRelay<String>(value: "0")
    var type = BehaviorRelay<String>(value: "")
    var language = BehaviorRelay<String>(value: "")
    var status = BehaviorRelay<String>(value: "")
    var premier = BehaviorRelay<String>(value: "")
    var ended = BehaviorRelay<String>(value: "")
    var runTime = BehaviorRelay<String>(value: "")
    var hasGenre = BehaviorRelay<Bool>(value: true)
    var img = BehaviorRelay<URL?>(value: nil)
    
    //MARK: - INIT
    init(data : ShowDetails) {
        self.passData(data: data)
    }
    
    //MARK: - Pass Data
    func passData(data : ShowDetails) {
        self.showDetails_PS.onNext(data)
        self.name.accept(data.show?.name ?? "")
        self.link.accept(data.show?.url ?? "")
        self.type.accept(data.show?.type?.rawValue ?? "")
        self.language.accept(data.show?.language?.rawValue ?? "")
        self.status.accept(data.show?.status?.rawValue ?? "")
        self.premier.accept(data.show?.premiered ?? "")
        self.runTime.accept("\(data.show?.runtime ?? 0)")
        self.ended.accept(data.show?.ended ?? "")
        
        let rate = String(format: "%.2f", (data.score ?? 0) * 10)
        self.rate.accept(rate)
        
        if let img = URL(string: data.show?.image?.medium ?? "") {
            self.img.accept(img)
        }
        
        if data.show?.genres?.count != 0 {
            var genres = ""
            data.show?.genres?.forEach({ gen in
                genres = genres.isEmpty ? gen : genres + " , \(gen)"
            })
            self.genre.accept(genres)
            self.hasGenre.accept(genres.isEmpty)
        }
    }
    
}
