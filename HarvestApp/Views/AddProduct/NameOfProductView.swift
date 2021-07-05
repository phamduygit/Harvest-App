//
//  NameOfProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 16/06/2021.
//

import SwiftUI

struct NameOfProductView: View {
    @Binding var show : Bool
    @Binding var selected : String
    @Binding var categoryName: String
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    @State private var isAddName : Bool = false
    @State private var newName : String = ""
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                HStack {
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)
                    })
                    Spacer()
                }
                .padding(.horizontal)
                Text("Thu hoạch")
                    .font(.title2)
            }
            List {
                ForEach(categoryViewModel.categories[getIndexCategory()].listProductName, id: \.self) {product in
                    HStack {
                        if selected == product {
                            Image(systemName: "checkmark.circle.fill")
                                .onTapGesture {
                                    self.selected = product
                                }
                        } else {
                            Image(systemName: "circle")
                                .onTapGesture {
                                    self.selected = product
                                }
                        }
                        Text(product)
                            .foregroundColor(Color.black)
                    }
                    .cornerRadius(10)
                }
                if isAddName {
                    HStack {
                        Image(systemName: "circle")
                        TextField("Nhập tên nông sản", text: $newName)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isAddName = false
                            categoryViewModel.categories[getIndexCategory()].listProductName.append(newName)
                            self.newName = ""
                        }, label: {
                            Text("Lưu")
                        })
                    }
                }
            }
            Button(action: {
                self.isAddName.toggle()
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    Text("Thêm tên nông sản")
                }
            })
            .padding()
            .padding(.bottom)
        }
        .listStyle(GroupedListStyle())
        .background(Color("Color4").ignoresSafeArea())
    }
    func getIndexCategory() -> Int {
        let index = categoryViewModel.categories.firstIndex { category in
            category.categoryName == categoryName
        } ?? -1
        return index
    }
}

struct NameOfProductView_Previews: PreviewProvider {
    static var previews: some View {
        NameOfProductView(show: Binding.constant(false), selected: Binding.constant("Lúa Jasmine"), categoryName: Binding.constant("Lúa"))
    }
}
