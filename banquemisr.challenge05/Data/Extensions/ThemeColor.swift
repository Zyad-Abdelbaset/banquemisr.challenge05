//
//  ThemeColor.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}
struct ColorTheme {
    
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let myGreen = UIColor(named: "GreenColor")
    let myRed = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
    
}

struct LaunchTheme {
    let accent = UIColor(named: "LaunchAccentColor")
    let background = UIColor(named: "LaunchBackgroundColor")
    
}
