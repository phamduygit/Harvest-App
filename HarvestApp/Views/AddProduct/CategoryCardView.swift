//
//  CategoryCardView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 15/06/2021.
//

import SwiftUI

struct CategoryCardView: View {
    var image : String = "cate_rice"
    var title : String = "Lúa"
    var color : Color = Color.green
    var id : Int = 0
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: calculateWidth(), height: UIScreen.main.bounds.height / 2, alignment: .center)
            VStack (alignment: .leading, spacing: 18) {
                HStack {
                    Text(title)
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
        .background(color)
        .cornerRadius(15)
    }
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        let width = screen - 30 * 2
        return width
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView()
    }
}
