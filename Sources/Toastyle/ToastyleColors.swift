//
//  Color.swift
//  
//
//  Created by ok fits on 26/04/23.
//

import SwiftUI

@available(iOS 14.0, OSX 11, *)
public extension Color {
    static let alertWarning = getColor("alertWarning")
    static let alertFailed = getColor("alertFailed")
    static let alertInfo = getColor("alertInfo")
    static let alertSuccess = getColor("alertSuccess")
    static let dialogOverlay = getColor("dialogOverlay")
    static let shadow = getColor("shadow")
    
    private static func getColor(_ name: String) -> Color {
        return Color(name, bundle: .module)
    }
    
}
