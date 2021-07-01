//
//  LogInWithEmailPassword.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 30/06/2021.
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
func uploadImage(image: UIImage, completion: @escaping ((String) -> Void)) {
    var strURL = ""
    let imageName = NSUUID().uuidString
    let resizedImage = resizeImage(image: image, targetSize: CGSize.init(width: 150, height: 150))
    if let imageData = resizedImage.jpegData(compressionQuality: 1) {
        let storage = Storage.storage().reference().child("avatar/\(imageName)")
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
//                    avatarURL = url?.absoluteString ?? "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png"
                    if let urlText = url?.absoluteString {

                        strURL = urlText
                        print("///////////tttttttt//////// \(strURL)   ////////")

                        completion(strURL)
                    }
                }
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
    while(Auth.auth().currentUser == nil) {
        
    }
}
func createAccount(email: String, password: String) -> String {
    var uid = "none"
    Auth.auth().createUser(withEmail: email, password: password) { data, err in
        if err != nil {
            print("create user error: \(err?.localizedDescription ?? "")")
            return
        }
    }
    while(Auth.auth().currentUser == nil) {
        
    }
    uid = Auth.auth().currentUser?.uid ?? "none"
    return uid
}
func updateProfile(photoURL: String, fullName: String) {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.displayName = fullName
    changeRequest?.photoURL = URL(string: photoURL)
    changeRequest?.commitChanges { (error) in
    
    }
}
