//
//  ShowDetailsVC.swift
//  Task
//
//  Created by Khaled on 25/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class ShowDetailsVC: BaseVC {
    
    //Outlets
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var genreStack: UIStackView!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var endedLbl: UILabel!
    @IBOutlet weak var premLbl: UILabel!
    @IBOutlet weak var runTimeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Variables
    var showDetailsVM : ShowDetailsVM?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindUI()
    }
    
    //MARK: - Bind Ui
    func bindUI() {
        self.showDetailsVM?.name.asDriver()
            .drive(self.rx.title).disposed(by: disposeBag)
        
        self.showDetailsVM?.rate.asDriver()
            .drive(self.rateLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.genre.asDriver()
            .drive(self.genreLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.hasGenre.asDriver()
            .drive(self.genreStack.rx.isHidden).disposed(by: disposeBag)
        
        self.showDetailsVM?.language.asDriver()
            .drive(self.langLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.type.asDriver()
            .drive(self.typeLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.type.asDriver()
            .drive(self.typeLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.status.asDriver()
            .drive(self.statusLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.premier.asDriver()
            .drive(self.premLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.ended.asDriver()
            .drive(self.endedLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.runTime.asDriver()
            .drive(self.runTimeLbl.rx.text).disposed(by: disposeBag)
        
        self.showDetailsVM?.img.asDriver()
            .drive(self.showImg.rx.imgURL).disposed(by: disposeBag)
    }

}
