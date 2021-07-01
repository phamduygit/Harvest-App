//
//  RoundedTop.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import Foundation
import SwiftUI

struct RoundedTop : Shape {
    var cornerRaidus = 40
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRaidus, height: cornerRaidus))
        return Path(path.cgPath)
    }
}
