//
//  SwiftUIView.swift
//  
//
//  Created by Erif Fanani on 12/06/23.
//

import SwiftUI

struct ToastyleBackground2: Shape {
    
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
