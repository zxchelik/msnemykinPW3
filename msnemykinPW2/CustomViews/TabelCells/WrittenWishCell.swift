//
//  WrittenWishCell.swift
//  msnemykinPW2
//
//  Created by Михаил Немыкин on 06.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    
    // MARK: - Constants
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let numberOfLines: Int = 0
        static let lineBreakMode: NSLineBreakMode = .byWordWrapping
        
        static let trashColor: UIColor = .red
    }
    
    // MARK: - Fields
    private let wishLabel = UILabel()
    private let deleteButton = UIButton(type: .custom)
    private let wrap = UIView()
    
    var onDeletePressed: ((String) -> Void)?
    
    // MARK: - Lifecycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        isUserInteractionEnabled = false
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.isUserInteractionEnabled = false
        addSubview(wrap)
        
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        configureDeleteButton()
        configureWishLabel()
    }
    
    private func configureDeleteButton() {
        wrap.addSubview(deleteButton)
        
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteButton.tintColor = Constants.trashColor
        
        deleteButton.pinRight(to: wrap.trailingAnchor,Constants.wishLabelOffset)
        deleteButton.pinVertical(to: wrap,Constants.wishLabelOffset)
        deleteButton.isUserInteractionEnabled = true
        
        deleteButton.addTarget(self, action: #selector(DeletePressed), for: .touchUpInside)
    }
    
    private func configureWishLabel() {
        wrap.addSubview(wishLabel)
        wishLabel.isUserInteractionEnabled = false
        
        wishLabel.pinVertical(to: wrap,Constants.wishLabelOffset)
        wishLabel.pinLeft(to: wrap,Constants.wishLabelOffset)
        wishLabel.pinRight(to: deleteButton.leadingAnchor,Constants.wishLabelOffset)
        
        wishLabel.numberOfLines = Constants.numberOfLines
        wishLabel.lineBreakMode = Constants.lineBreakMode
    }
    
    @objc
    private func DeletePressed() {
        if let text = wishLabel.text {
            onDeletePressed?(text)
        }
    }
}
