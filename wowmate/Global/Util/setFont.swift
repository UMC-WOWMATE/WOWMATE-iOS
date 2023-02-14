//
//  setFont.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/28.
//

import UIKit

enum BasicFont: String {
    case regular = "AppleSDGothicNeo-Regular"
    case bold = "AppleSDGothicNeo-Bold"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case light = "AppleSDGothicNeo-Light"
}
extension UIFont {
    // Headline
    static let head = UIFont(name: BasicFont.bold.rawValue, size: 25)
    // SubHeadline
    static let subHead_20B = UIFont(name: BasicFont.bold.rawValue, size: 20)
    static let subHead_20R = UIFont(name: BasicFont.regular.rawValue, size: 20)
    static let subHead_18B = UIFont(name: BasicFont.bold.rawValue, size: 18)
    static let subHead_18SB = UIFont(name: BasicFont.semibold.rawValue, size: 18)
    static let subHead_18R = UIFont(name: BasicFont.regular.rawValue, size: 18)
    // Body
    static let body_16B = UIFont(name: BasicFont.bold.rawValue, size: 16)
    static let body_16SB = UIFont(name: BasicFont.semibold.rawValue, size: 16)
    static let body_16R = UIFont(name: BasicFont.regular.rawValue, size: 16)
    static let body_14B = UIFont(name: BasicFont.bold.rawValue, size: 14)
    static let body_14R = UIFont(name: BasicFont.regular.rawValue, size: 14)
    static let body_14L = UIFont(name: BasicFont.light.rawValue, size: 14)
    static let body_11R = UIFont(name: BasicFont.regular.rawValue, size: 11)
    static let body_11L = UIFont(name: BasicFont.light.rawValue, size: 11)
}
