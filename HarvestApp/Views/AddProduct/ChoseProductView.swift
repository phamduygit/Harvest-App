//
//  ChoseProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 15/06/2021.
//

import SwiftUI

var rices = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
struct ChoseProductView: View {
    @State private var categories = [
        CarđData(id: 0, image: "cate_rice", color: Color.green, title: "Lúa", offset: 0),
        CarđData(id: 1, image: "cate_coffee", color: Color.gray, title: "Cà Phê", offset: 0),
        CarđData(id: 2, image: "cate_lychee", color: Color.pink, title: "Vải thiều", offset: 0),
        CarđData(id: 3, image: "cate_pepper", color: Color.purple, title: "Tiêu", offset: 0)
    ]
    @State var listWeightOfSack = [
        Sack(id: 0, weight: 49.6),
        Sack(id: 1, weight: 49.6),
        Sack(id: 2, weight: 49.6),
        Sack(id: 3, weight: 49.6),
        Sack(id: 4, weight: 49.6)
    ]
    @State private var ricesCategory = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
    @State private var scrolled : Int = 0
    @State private var indexFilter : Int = 0
    @State private var selected : String = "Lúa Jasmine"
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @Binding var show : Bool
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
                    .padding()
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
                            ForEach(categories.reversed()) { category in
                                HStack {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                        Image(category.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: calculateWidth(), height: UIScreen.main.bounds.height / 2 - CGFloat(category.id - scrolled) * 50, alignment: .center)
                                        VStack (alignment: .leading, spacing: 18) {
                                            HStack {
                                                Text(category.title)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                Spacer()
                                            }
                                            Button(action: {}, label: {
                                                Text("Chọn")
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding(.vertical, 6)
                                                    .padding(.horizontal, 25)
                                                    .background(Color.blue)
                                                    .clipShape(Capsule())
                                            })
                                        }
                                        .frame(width: calculateWidth() - 40)
                                        .padding(.leading, 20)
                                        .padding(.bottom, 20)
                                    }
                                    .background(category.color)
                                    .cornerRadius(15)
                                    .offset(x: (category.id - scrolled <= 2) ? CGFloat(category.id - scrolled) * 30 : 60, y: 0)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .offset(x: category.offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            withAnimation {
                                                if value.translation.width < 0 && category.id != categories.last!.id {
                                                    categories[category.id].offset = value.translation.width
                                                }
                                                else {
                                                    if category.id > 0 {
                                                        categories[category.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                                                    }
                                                }
                                            }

                                        }
                                        .onEnded { value in
                                            withAnimation {
                                                if value.translation.width < 0 {
                                                    if -value.translation.width > calculateWidth() / 2 && category.id != categories.last!.id {
                                                        categories[category.id].offset = -(calculateWidth() + 60)
                                                        scrolled += 1
                                                    }
                                                    else {
                                                        categories[category.id].offset = 0
                                                    }
                                                }
                                                else {
                                                    if category.id > 0 {
                                                        if value.translation.width > calculateWidth() / 2 {
                                                            categories[category.id - 1].offset = 0
                                                            scrolled -= 1
                                                        }
                                                        else {
                                                            categories[category.id - 1].offset = -(calculateWidth() + 60)
                                                        }
                                                    }
                                                }
                                            }

                                        }
                                )

                            }
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .padding(.horizontal)
                        .padding(.top)
                        Button(action: {
                            showNames.toggle()
                        }, label: {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(selected)
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding()
                        })
                        Button(action: {
                            self.showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Nhập sản lượng")
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
            if showNames {
                NameOfProductView(show: $showNames, selected: $selected, ricesCategory: $ricesCategory)
            }
            if showInputWeight {
                ListWeightView(category: "lúa", show: $showInputWeight, listWeightOfSack: $listWeightOfSack)
            }
        }
    }
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        let width = screen - (30 * 2)
        return width
    }
}

struct ChoseProductView_Previews: PreviewProvider {
    static var previews: some View {
        ChoseProductView(show: Binding.constant(false))
    }
}

struct CarđData : Identifiable{
    var id : Int
    var image : String = ""
    var color : Color
    var title : String = ""
    var offset: CGFloat
}
