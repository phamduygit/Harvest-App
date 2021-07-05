//
//  CategoryCard.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 05/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCard: View {
    
    var index = -1;
    @Binding var scrolled : Int
    @Binding var listProductName: [String]
    @EnvironmentObject var productViewModel : ProductViewModel
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    var body: some View {
        HStack {
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                AnimatedImage(url: URL(string: categoryViewModel.categories[index].image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: calculateWidth(), height: UIScreen.main.bounds.height / 2 - CGFloat(index - scrolled) * 50, alignment: .center)
                VStack (alignment: .leading, spacing: 18) {
                    HStack {
                        Text(categoryViewModel.categories[index].categoryName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    Button(action: {
                        productViewModel.product.category = categoryViewModel.categories[index].categoryName
                        productViewModel.product.name = categoryViewModel.categories[index].listProductName.first ?? ""

                    }, label: {
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
            .background(Color("\(categoryViewModel.categories[index].colorBackground)"))
            .cornerRadius(15)
            .offset(x: (index - scrolled <= 2) ? CGFloat(index - scrolled) * 30 : 60, y: 0)
            Spacer()
        }
        .contentShape(Rectangle())
        .offset(x: categoryViewModel.categories[index].offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        for category in categoryViewModel.categories {
                            print("\(category.categoryName): \(category.offset)")
                            
                        }
                        print("")
                        if value.translation.width < 0 && index != categoryViewModel.categories.count - 1 {
                            categoryViewModel.categories[index].offset = value.translation.width
                        }
                        else {
                            if index > 0 {
                                categoryViewModel.categories[index - 1].offset = -(calculateWidth() + 60) + value.translation.width
                            }
                        }
                    }

                }
                .onEnded { value in
                    withAnimation {
                        if value.translation.width < 0 {
                            if -value.translation.width > calculateWidth() / 2 && index != categoryViewModel.categories.count - 1 {
                                categoryViewModel.categories[index].offset = -(calculateWidth() + 60)
                                scrolled += 1
                            }
                            else {
                                categoryViewModel.categories[index].offset = 0
                            }
                        }
                        else {
                            if index > 0 {
                                if value.translation.width > calculateWidth() / 2 {
                                    categoryViewModel.categories[index - 1].offset = 0
                                    scrolled -= 1
                                }
                                else {
                                    categoryViewModel.categories[index - 1].offset = -(calculateWidth() + 60)
                                }
                            }
                        }
                    }

                }
        )
    }
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        let width = screen - (30 * 2)
        return width
    }
}

//struct CategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCard()
//    }
//}
