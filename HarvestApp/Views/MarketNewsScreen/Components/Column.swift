//
//  Column.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct Column: View {
    let maxValue = data.max {$0.value < $1.value}
    var index : Int = 0
    var width : CGFloat = 50.0
    @Binding var currentIndex : Int
    var body: some View {
        VStack {
            if currentIndex == index {
                VStack() {
                    Text("\(data[index].value)")
                        .font(.system(size: 12))
                    Color.red.frame(width: width, height: (CGFloat(data[index].value) / CGFloat(maxValue!.value)) * 150.0, alignment: .center)
                        .cornerRadius(5)
                }
                    
            } else {
                Color.blue.frame(width: width, height: (CGFloat(data[index].value) / CGFloat(maxValue!.value)) * 150.0, alignment: .center)
                    .cornerRadius(5)
            }
            
            Text(data[index].name)
                .font(.headline)
        }
        
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        Column(currentIndex: Binding.constant(0))
        
    }
}
