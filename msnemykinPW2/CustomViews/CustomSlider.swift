//
//  CustomSlider.swift
//  msnemykinPW2
//
//  Created by Михаил Немыкин on 26.10.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    enum Constants {
        static let leadingConstraint: CGFloat = 20
        static let trailingConstraint: CGFloat = 20
        static let topConstraint: CGFloat = 20
        static let bottomConstraint: CGFloat = 20
    }
    // MARK: - Fields
    var valueChanged: ((Int) -> Void)?
    
    var slider: UISlider = UISlider()
    var titleView: UILabel = UILabel()
    var valueView: UILabel = UILabel()
    
    // MARK: - Lifecycle methods
    init(titel: String,textColor: UIColor = .black, min: Int = 0, max: Int = 255) {
        super.init(frame: .zero)
        titleView.text = titel
        valueView.text = "\(Int(min))"
        
        titleView.textColor = textColor
        valueView.textColor = textColor
        
        slider.maximumValue = Float(max)
        slider.minimumValue = Float(min)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Methods
    func setValue(_ value: Int) {
        slider.value = Float(value)
        valueView.text = String(value)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        for view in [titleView, slider, valueView] {
            addSubview(view)
        }
        
        configureTitleView()
        configureValueView()
        configureSlider()
    }
    
    private func configureTitleView() {
        titleView.pinTop(to: topAnchor, Constants.topConstraint)
        titleView.pinLeft(to: leadingAnchor, Constants.leadingConstraint)
        titleView.pinRight(to: centerXAnchor)
        
        titleView.textAlignment = .left
    }
    
    private func configureValueView() {
        valueView.pinTop(to: topAnchor, Constants.topConstraint)
        valueView.pinRight(to: trailingAnchor, Constants.trailingConstraint)
        valueView.pinLeft(to: centerXAnchor)
        valueView.pinBottom(to: titleView.bottomAnchor)
        
        valueView.textAlignment = .right
    }
    
    private func configureSlider() {
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinLeft(to: leadingAnchor, Constants.leadingConstraint)
        slider.pinRight(to: trailingAnchor, Constants.trailingConstraint)
        slider.pinBottom(to: bottomAnchor, Constants.bottomConstraint)
    }
    // MARK: - Objc Methods
    @objc
    private func sliderValueChanged() {
        let value = Int(slider.value)
        valueChanged?(value)
        valueView.text = String(value)
    }
}

