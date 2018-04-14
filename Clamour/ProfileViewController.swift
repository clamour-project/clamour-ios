//
//  ProfileViewController.swift
//  Clamour
//
//  Created by Anne Manzhura on 10.04.2018.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profileImage.layer.cornerRadius = profileImage.bounds.width/2
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.lightGray.cgColor
        
        //self.btnEditProfile.layer.cornerRadius = 5
    }
    
    @IBAction func editProfile(_ sender: Any) {
        //chooseSourceOfPhoto()
        
        let url = URL(string: "https://clamour-server.appspot.com/loader")
        
        //let request = URLRequest(url: components.url!)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                if let data = data {
                    let parsedData = String.init(data: data, encoding: String.Encoding.utf8)
                    DispatchQueue.main.async {
                        self.userName.text = parsedData
                    }
                }
            }
        }
        task.resume()
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
    }
}
//MARK: - UIImagePickerControllerDelegate
extension ProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.profileImage.image = editedImage
        }
        
        //Dismisss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
