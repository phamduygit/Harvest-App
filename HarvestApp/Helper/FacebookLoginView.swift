//
//  FacebookLoginView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 02/07/2021.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct FacebookLoginView : UIViewRepresentable {
    func makeCoordinator() -> FacebookLoginView.Coordinator {
        return FacebookLoginView.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<FacebookLoginView>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.delegate = context.coordinator
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FacebookLoginView>) {

    }

    class Coordinator : NSObject, ObservableObject,LoginButtonDelegate{

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
            print("Did logout")
        }

        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

            if error != nil  {
                print((error?.localizedDescription)!)
                return
            }

            if AccessToken.current != nil {

                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) {(res ,  er) in

                    if er != nil{
                        print((er?.localizedDescription)!)
                        return
                    }

                    print("SUCCES! ")
                }
            }
        }
    }
}
