//
//  CustomColorSelector.swift
//  msnemykinPW2
//
//  Created by Михаил Немыкин on 29.10.2024.
//

import UIKit

final class CustomColorSelector: UIStackView {
    // MARK: - Constants
    enum Constants {
        static let stackCornerRadius: CGFloat = 20
        
        static let defaultRedValue: Int = 0
        static let defaultGreenValue: Int = 0
        static let defaultBlueValue: Int = 0
        
        static let red: String = "red"
        static let green: String = "green"
        static let blue: String = "blue"
        
        static let redColor: UIColor = .red
        static let greenColor: UIColor = .green
        static let blueColor: UIColor = .blue
    }
    // MARK: - Fields
    var onColorChange: ((UIColor) -> Void)?
    
    var red: Int = Constants.defaultRedValue
    var green: Int = Constants.defaultGreenValue
    var blue: Int = Constants.defaultBlueValue
    
    let redSlider: CustomSlider = CustomSlider(titel: Constants.red, textColor: Constants.redColor)
    let greenSlider: CustomSlider = CustomSlider(titel: Constants.green, textColor: Constants.greenColor)
    let blueSlider: CustomSlider = CustomSlider(titel: Constants.blue,textColor: Constants.blueColor)
    // MARK: - Properties
    var hexColor: String {
        String(format: "#%02X%02X%02X", red, green, blue)
    }
    
    var color: UIColor {
        return UIColor(hexColor: hexColor)!
    }
    // MARK: - Lifecycle methods
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {        
        configureStack()
        configureSliders()
    }
    
    private func configureStack() {
        self.pinCenter(to: self)
        self.pinLeft(to: leadingAnchor)
        self.pinTop(to: topAnchor)
        
        self.layer.cornerRadius = Constants.stackCornerRadius
        
        self.axis = .vertical
        self.clipsToBounds = true
    }
    
    private func configureSliders() {
        redSlider.setValue(Constants.defaultRedValue)
        greenSlider.setValue(Constants.defaultGreenValue)
        blueSlider.setValue(Constants.defaultBlueValue)
        
        for slider in [redSlider, greenSlider, blueSlider] {
            self.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] value in
                switch slider {
                case self?.redSlider:
                    self?.red = Int(value)
                case self?.greenSlider:
                    self?.green = Int(value)
                case self?.blueSlider:
                    self?.blue = Int(value)
                default: break
                }
                self?.onColorChange?(self!.color)
            }
        }
    }
}
