//
//  Rounded.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import Foundation
import SwiftUI

struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}
