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
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
    
}

struct ColorTheme2 {
    let accent = UIColor(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
    let background = UIColor(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
    let green = UIColor(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
    let red = UIColor(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
    let secondaryText = UIColor(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

struct LaunchTheme {
    
    let accent = UIColor(named: "LaunchAccentColor")
    let background = UIColor(named: "LaunchBackgroundColor")
    
}
