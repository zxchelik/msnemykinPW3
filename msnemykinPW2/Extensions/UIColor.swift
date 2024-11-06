//
//  UIColor.swift
//  msnemykinPW2
//
//  Created by Михаил Немыкин on 26.10.2024.
//
import UIKit

extension UIColor {
    convenience init?(hexColor: String) {
        var hexFormatted = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        guard hexFormatted.count == 6 else {
            return nil
        }
        
        let redHex = String(hexFormatted.prefix(2))
        let greenHex = String(hexFormatted.dropFirst(2).prefix(2))
        let blueHex = String(hexFormatted.dropFirst(4).prefix(2))
        
        guard let red = UInt8(redHex, radix: 16),
              let green = UInt8(greenHex, radix: 16),
              let blue = UInt8(blueHex, radix: 16) else {
            return nil
        }
        
        self.init(red:CGFloat(red) / 255.0,green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0,alpha: 1)
    }
}
