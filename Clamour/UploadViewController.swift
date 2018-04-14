//
//  UploadViewController.swift
//  Clamour
//
//  Created by Anne Manzhura on 09.04.2018.
//

import Foundation
import UIKit

class UploadViewController : UIViewController
{
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var btnReUploadImage: UIBarButtonItem!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var imagePicker = UIImagePickerController()
    

    @IBAction func uploadPhoto(_ sender: UIButton) {
        chooseSourceOfPhoto()
    }
    
    @IBAction func reUploadPhoto(_ sender: UIButton) {
        chooseSourceOfPhoto()
    }
    
    func chooseSourceOfPhoto()
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        /*
         switch UIDevice.current.userInterfaceIdiom {
         case .pad:
         alert.popoverPresentationController?.sourceView = sender
         alert.popoverPresentationController?.sourceRect = sender.bounds
         alert.popoverPresentationController?.permittedArrowDirections = .up
         default:
         break
         }
         */
        
        self.present(alert, animated: true, completion: nil)
    }
    
    

    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDone.isEnabled=false
    }
}

//MARK: - UIImagePickerControllerDelegate
extension UploadViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        
        //if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
        //    self.myImageView.image = editedImage
        //}
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.myImageView.image = image
            submit(image: image)
        } else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.myImageView.image = image
            submit(image: image)
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
        
        
        btnUploadImage.isHidden=true
        btnDone.isEnabled=true
        btnReUploadImage.isEnabled=true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func submit(image: UIImage) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: "https://clamour-server.appspot.com/loader") else { return }
        //https://clamour-server.appspot.com/loader
        //http://localhost:8080/loader
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let imageData: Data = UIImageJPEGRepresentation(image, 0.4)!
        let imageStr = imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        request.httpBody = imageStr.data(using: String.Encoding.utf8)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Something went wrong: \(error)")
            }
            
            if let data = data {
                print(String.init(data: data, encoding: String.Encoding.utf8)!)
            }
        }
        
        dataTask.resume()
    }
    

    
}

