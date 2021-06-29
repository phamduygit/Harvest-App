//
//  InputSecureField.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import Foundation
import SwiftUI

struct InputSecureField: View {
    @State private var showPassword: Bool = false
    var title : String
    var placeHolder : String
    @Binding var inputText : String
    var body: some View {
        VStack (alignment: .leading, spacing: 10 ) {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            HStack {
                if showPassword {
                    TextField(placeHolder, text: $inputText)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                } else {
                    SecureField(placeHolder, text: $inputText)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    if showPassword {
                        Image(systemName: "eye")
                            .foregroundColor(Color.black)
                    }
                    else {
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color.black)
                    }
                })
            }
            Divider()
        }
        .padding(.horizontal)
    }
}
