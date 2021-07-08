//
//  AddToStorageView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 18/06/2021.
//

import SwiftUI

struct AddToStorageView: View {
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var listProductName = [String]()
    @State private var selected : String = "Lúa Jasmine"
    @EnvironmentObject var productViewModel : ProductViewModel
    @EnvironmentObject var stockViewModel : StockViewModel
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    @State private var addProductSucess : Bool = false
    @Binding var showAddToStorage : Bool
    @Binding var showAddProdct : Bool
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    HStack {
                        Button(action: {
                            self.showAddToStorage.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                        })
                        Spacer()
                    }
                    .padding(.horizontal)
                    Text("Thu hoạch")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Chọn nông sản")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ZStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.showingImagePicker = true
                                    }, label: {
                                        if image != nil {
                                            image?
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "camera.fill")
                                                .foregroundColor(.black)
                                                .padding(40)
                                                .background(Color.gray.opacity(0.5))
                                                .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .clipShape(Circle())
                                        }
                                    })
                                    Spacer()
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
                        Button(action: {
                            showNames.toggle()
                        }, label: {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(productViewModel.product.name)
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        })
                        Button(action: {
                            showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(productViewModel.product.weight.reduce(0, +), specifier: "%.2f") kg")
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        })
                        Button(action: {
                            stockViewModel.addNewProduct(image: inputImage,product: productViewModel.product)
                            addProductSucess.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Thêm vào kho")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color("Color5"))
                            .clipShape(Capsule())
                            .padding()
                            .padding(.bottom)
                            
                        })
                    }
                }
                
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                VStack {
                    ImagePicker(image: $inputImage)
                }
            })
            .sheet(isPresented: $addProductSucess, content: {
                AddProductSuccessView(showAddProdct: $showAddProdct)
            })
            if showNames {
                NameOfProductView(show: $showNames, selected: $productViewModel.product.name, categoryName: $productViewModel.product.category)
            }
            if showInputWeight {
                UpdateListWeightView(show: $showInputWeight, product: $productViewModel.product)
            }
            
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddToStorageView_Previews: PreviewProvider {
    static var previews: some View {
        AddToStorageView(showAddToStorage: Binding.constant(false), showAddProdct: Binding.constant(false))
    }
}
