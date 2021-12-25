//
//  HomeVM.swift
//  Task
//
//  Created by Khaled on 24/12/2021.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

class HomeVM {
    
    private var showData_PS = PublishSubject<ShowData>()
    var showData : Observable<ShowData> {
        return showData_PS.asObservable()
    }
    
    var homeNetwork : HomeNetworkProtocol!
    
    var showLoader = PublishSubject<Bool>()
    
    //MARK: - INIT
    init(homeNet : HomeNetworkProtocol = HomeNetwork()) {
        self.homeNetwork = homeNet
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.getHomeData()
        }
    }
    
    //MARK: - Get Home Data
    func getHomeData() {
        showLoader.onNext(true)
        homeNetwork.getHomeTVShows {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error) :
                self.showLoader.onNext(false)
                print("error \(error.errorMessage)")
            case .success(let data) :
                guard let data = data else { return }
                self.showData_PS.onNext(data)
                self.showLoader.onNext(false)
            }
        }
    }
    
}
