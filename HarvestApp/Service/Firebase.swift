//
//  Firebase.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 28/06/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height

    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}
func uploadImage(image: UIImage) {
    guard let userID = Auth.auth().currentUser?.uid else {
        print("UserID not exists")
        return
    }
    let resizedImage = resizeImage(image: image, targetSize: CGSize.init(width: 150, height: 150))
    if let imageData = resizedImage.jpegData(compressionQuality: 1) {
        let storage = Storage.storage()
        storage.reference().child("avatar/\(userID)").putData(imageData, metadata: nil) { data, error in
            if error != nil {
                print("ERROR: \(String(describing: error?.localizedDescription))")
            }
            else {
                print("Upload image sucessfully")
            }
        }
    }
}
func signIn(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { data, error in
        if error != nil {
            print("Sign Error \(error?.localizedDescription ?? "")")
        }
    }
}
func createAccount(avatar: UIImage, fullName: String, email: String, phone: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { data, err in
        if err != nil {
            print("create user error: \(err?.localizedDescription ?? "")")
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else {
            print("UserID not exists")
            return
        }
        let resizedImage = resizeImage(image: avatar, targetSize: CGSize.init(width: 150, height: 150))
        if let imageData = resizedImage.jpegData(compressionQuality: 1) {
            let storage = Storage.storage().reference().child("avatar/\(userID)")
            storage.putData(imageData, metadata: nil) { data, error in
                if error != nil {
                    print("ERROR: \(String(describing: error?.localizedDescription))")
                }
                else {
                    print("Upload image sucessfully")
                    storage.downloadURL { url, error in
                        if error != nil {
                            return
                        }
                        guard let downloadURL = url else {
                            return
                        }
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = fullName
                        changeRequest?.photoURL = downloadURL
                        changeRequest?.commitChanges { (error) in
                        
                        }
                    }
                }
            }
        }
    }
}
