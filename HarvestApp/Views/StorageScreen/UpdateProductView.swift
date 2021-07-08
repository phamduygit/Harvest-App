//
//  UpdateProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 04/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdateProductView: View {
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var listProdcutName = [String]()
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    @Binding var product : Product
    @Binding var show : Bool
    @State private var selected = ""
    @EnvironmentObject var stockViewModel : StockViewModel
    var body: some View {
        ZStack {
            VStack {
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
                    Text("Kho")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Cập nhật nông sản")
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
                                            if product.image == "" {
                                                Image(systemName: "camera.fill")
                                                    .foregroundColor(.black)
                                                    .padding(40)
                                                    .background(Color.gray.opacity(0.5))
                                                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                    .clipShape(Circle())
                                            } else {
                                                AnimatedImage(url: URL(string: product.image))
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding()
                                            }
                                            
                                        }
                                    })
                                    Spacer()
                                }
                            }
                        }
                        
                        .frame(height: UIScreen.main.bounds.height / 3)
                        Button(action: {
                            showNames.toggle()
                        }, label: {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(product.name)
                                Image(systemName: "chevron.right")
                                
                            }
                            .onAppear {
                                self.selected = product.name
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        Button(action: {
                            showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(product.weight.reduce(0, +), specifier: "%.2f") kg")
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }
                }
                
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .overlay(
                HStack {
                    Button(action: {
                        stockViewModel.saveProductAndImage(image: inputImage, product: product)
                        self.show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Lưu")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .clipShape(Capsule())
                        .padding()
                        .padding(.bottom)
                        
                    })
                }
                , alignment: .bottom
            )
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                VStack {
                    ImagePicker(image: $inputImage)
                }
            })
            if showNames {
                NameOfProductView(show: $showNames, selected: $product.name, categoryName: $product.category)
            }
            if showInputWeight {
                UpdateListWeightView(show: $showInputWeight, product: $product)
            }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProductView(product: Binding.constant(Product()), show: Binding.constant(false))
    }
}
