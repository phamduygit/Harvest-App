//
//  TabBarStock.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 23/06/2021.
//

import SwiftUI

struct TabBarStock: View {
    @Binding var offset : CGFloat
    var tabs : [String] = ["Trong kho", "Đăng bán", "Đã bán"]
    @State private var width : CGFloat = 0;
    var body: some View {
        GeometryReader {geometry -> AnyView in
            let equalWidth = geometry.frame(in: .global).width / CGFloat(tabs.count)
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            return AnyView(
                ZStack(alignment: .bottomLeading) {
                    Capsule()
                        .fill(Color("Color2"))
                        .frame(width: equalWidth - 15, height: 4)
                        .offset(x: getOffset() + 7)
                    HStack (spacing: 0){
                        ForEach(tabs.indices) {index in
                            Text(tabs[index])
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: equalWidth, height: 40, alignment: .center)
                                .onTapGesture {
                                    withAnimation {
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                        print(offset)
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .clipShape(Capsule())
            )
        }
        .frame(height: 40)
    }
    func getOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        return progress * width
    }
}

struct TabBarStock_Previews: PreviewProvider {
    static var previews: some View {
        TabBarStock(offset: Binding.constant(0))
    }
}
