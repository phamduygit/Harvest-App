//
//  AddProductSuccessView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 05/07/2021.
//

import SwiftUI

struct AddProductSuccessView: View {
    @Binding var showAddProdct : Bool
    var body: some View {
        VStack {
            Text("Thêm nông sản vào kho thành công")
            Button(action: {
                showAddProdct = false
            }, label: {
                Text("Trở về màn hình chính")
            })
        }
        .background(Color("Color4").ignoresSafeArea())
        
    }
}

struct AddProductSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductSuccessView(showAddProdct: Binding.constant(false))
    }
}
