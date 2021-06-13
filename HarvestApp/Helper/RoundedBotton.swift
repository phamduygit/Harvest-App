//
//  Rounded.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import Foundation
import SwiftUI

struct RoundedBotton : Shape {
    var cornerRaidus = 40
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRaidus, height: cornerRaidus))
        return Path(path.cgPath)
    }
}
