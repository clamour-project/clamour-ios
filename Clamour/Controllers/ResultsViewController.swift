//
//  ResultsViewController.swift
//  Clamour
//
//  Created by Anne Manzhura on 21.04.2018.
//  San Nguyen and Anne Manzhura
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
    
    var isSaved = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        carousel.type = .coverFlow
        carousel.scrollSpeed = 0.8
        carousel.clipsToBounds = true
        carousel.type = .coverFlow
        miniature.image = miniatureImage
        miniature.layer.cornerRadius = 5
        carousel.reloadData()
        
        if (!isSaved) {
            let image = miniature.image
            if let data = UIImageJPEGRepresentation(image!, 0.8) {
                let code = UserDefaults.standard.integer(forKey: "lastSearchedImage")
                let filename = getDocumentsDirectory().appendingPathComponent("s\(code).jpeg")
                try? data.write(to: filename)
                UserDefaults.standard.set(code + 1, forKey: "lastSearchedImage")
                print("Image saved in documents")
            }
//            var cols: [UIColor] = []
//            if UserDefaults.standard.object(forKey: "savedColors") != nil {
//                cols = UserDefaults.standard.array(forKey: "savedColors") as! [UIColor]
//            }
//            cols.append(dataResult.suitableColors[0])
//            UserDefau
            //lts.standard.set(cols, forKey: "savedColors")
//            print("Color saved")
            UserDefaults.standard.synchronize()
        }
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
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ResultsViewController.tapDetected))
        itemView.isUserInteractionEnabled = true
        itemView.addGestureRecognizer(singleTap)

        
        return itemView
    }
    
    @objc func tapDetected() {
        let image = images[carousel.currentItemIndex]
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            let code = UserDefaults.standard.integer(forKey: "lastFoundImage")
            let filename = getDocumentsDirectory().appendingPathComponent("f\(code).jpeg")
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let save = UIAlertAction(title: "Save to profile", style: UIAlertActionStyle.default) {
                (alert) in
                try? data.write(to: filename)
                UserDefaults.standard.set(code + 1, forKey: "lastFoundImage")
                UserDefaults.standard.synchronize()
                print("Image saved in documents")
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                (alert) in
            }
            alert.addAction(save)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return carousel.frame.width * 0.85
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
