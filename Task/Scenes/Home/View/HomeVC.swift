//
//  HomeVC.swift
//  Task
//
//  Created by Khaled on 24/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: BaseVC {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var homeVM : HomeVM!

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        homeVM = HomeVM()
        bindVM()
        bindCollection()
    }
    
    //MARK: - Navigation Style
    func setupNavigationStyle() {
        self.title = "Shows List"
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Bind VM
    func bindVM() {
        //Bind Loader
        homeVM.showLoader.bind(to: self.rx.showLoader).disposed(by: self.disposeBag)
    }
    
    //MARK: - Bind Collection
    func bindCollection() {
        self.collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        self.homeVM.showData
            .observe(on: MainScheduler.instance)
            .bind(to: self.collectionView.rx.items(cellIdentifier: "HomeCell" , cellType: HomeCell.self)) { (index , element , cell) in
                cell.setupCell(data: element)
            }
            .disposed(by: self.disposeBag)
        
        self.collectionView.rx.modelSelected(ShowDetails.self)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (model) in
                guard let self = self else { return }
                self.openDetailsVC(model)
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    //MARK: - Open Details VC
    func openDetailsVC(_ data : ShowDetails) {
        let vc = ShowDetailsVC()
        let vm = ShowDetailsVM(data: data)
        vc.showDetailsVM = vm
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - Cell Size
extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(272)
        let width = (self.collectionView.frame.size.width - 16)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}
