//
//  ResultsViewController.swift
//  Clamour
//
//  Created by Anne Manzhura on 21.04.2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit
import iCarousel

class ResultsViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var miniature: UIImageView!
    var miniatureImage: UIImage!
    var dataResult: Result!
    
    var images: [UIImage] = []

    
    @IBOutlet weak var carousel: iCarousel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        let decodedimage = UIImage(data: decodedData! as Data)
        return decodedimage!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        carousel.type = .cylinder
        carousel.scrollSpeed = 0.8
        carousel.clipsToBounds = true
        
        
        miniature.image = miniatureImage
        miniature.layer.cornerRadius = 5
        carousel.reloadData()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        for i in 0 ... dataResult.suitableClothes.count-1 {
            images.append(convertBase64ToImage(base64String: dataResult.suitableClothes[i]))
        }
        return dataResult.suitableClothes.count
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: carousel.frame.width * 0.8,
                                             height: carousel.frame.height * 0.9))
        itemView.image = images[index]
        itemView.contentMode = .scaleAspectFill
        itemView.layer.cornerRadius = 5
        itemView.clipsToBounds = true
        
        return itemView
    }
}

//MARK: - Top color collection view
extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataResult.suitableColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorMatchViewCell
        cell.colorRec.layer.cornerRadius = 5
        cell.colorRec.clipsToBounds = true
        cell.colorRec.backgroundColor = self.dataResult.suitableColors[indexPath.row]
        return cell;
    }
    
}
