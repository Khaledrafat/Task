//
//  HomeCell.swift
//  Task
//
//  Created by Khaled on 25/12/2021.
//

import UIKit
import Cosmos

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var premierLbl: UILabel!
    @IBOutlet weak var imgIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosView.settings.fillMode = .precise
    }
    
    //MARK: - Setup Data
    func setupCell(data : ShowDetails) {
        nameLbl.text = data.show?.name
        urlLbl.text = data.show?.url
        premierLbl.text = data.show?.premiered
        
        if let rate = data.score {
            cosmosView.rating = rate * 10
        } else {
            cosmosView.rating = 0
        }
        imgIndicator.alpha = 0
        if let stURL = data.show?.image?.medium , let url = URL(string: stURL) {
            showImg.image = UIImage()
            imgIndicator.alpha = 1
            imgIndicator.startAnimating()
            BaseNetwork().loadImage(url: url) {[weak self] (imgURL, img) in
                guard let self = self else { return }
                self.showImg.image = img
                self.imgIndicator.alpha = 0
                self.imgIndicator.stopAnimating()
            }
        } else {
            showImg.image = UIImage()
        }
    }

}
