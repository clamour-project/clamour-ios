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
    
    var items: [Int] = []
    
    var images: [UIImage] = []
    
    var count = 0;
    
    @IBOutlet weak var carousel: iCarousel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        var decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .coverFlow2
        
        miniature.image = miniatureImage
        miniature.layer.cornerRadius = miniature.bounds.width/12

        
        
        print("type")
        print("\(dataResult.type)")
         print("suitableTypes")
        print("\(dataResult.suitableTypes)")
         print("suitableColors")
        print("\(dataResult.suitableColors)")
        //print("suitableClothes")
        //print("\(dataResult.suitableClothes)")
    }
   
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        for i in 0 ... dataResult.suitableClothes.count-1 {
            items.append(i)
        }
        for i in 0 ... dataResult.suitableClothes.count-1 {
            images.append(convertBase64ToImage(base64String: dataResult.suitableClothes[i]))
        }
        return items.count
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView
        //var button: UIButton
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: carousel.frame.width*0.1, y: 0, width: carousel.frame.width*0.8, height: carousel.frame.height))
            itemView.image = images[count]
            count+=1
            // CONTENT MODE
            itemView.contentMode = .scaleAspectFill
            //itemView.contentMode = .center
            
            // Round corners
            itemView.layer.cornerRadius = itemView.bounds.width/24
            itemView.clipsToBounds = true
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        //label.text = "\(items[index])"
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
}

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
