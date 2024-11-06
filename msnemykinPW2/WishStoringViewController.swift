//
//  WishStoringViewController.swift
//  msnemykinPW2
//
//  Created by Михаил Немыкин on 06.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    // MARK: - Constants
    enum Constants {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        static let numberOfSections = 2
        static let numberOfRowsInSection0: Int = 1
        
        static let addWishButtonOffset: CGFloat = 20
        static let buttonHeight: CGFloat = 50
        static let buttonBottom: CGFloat = 40
        static let buttonSide: CGFloat = 20
        static let buttonText = "Save wish"
        static let buttonRadius: CGFloat = 20
        
        static let Key = "Ya krutoi(Net)"
        
        static let backgroundColor: UIColor = .darkGray
        static let borderColor: CGColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        static let borderWidth: CGFloat = 2
        static let textColor: UIColor = .white
    }
    
    // MARK: - Properties
    private let addWishButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    private let table = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private var currentWishText = ""
    private let defaults = UserDefaults.standard

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        loadWishes()
        configureAddWishButton()
        configureTable()
    }
    
    // MARK: - UI Configuration
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = Constants.backgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pinCenterX(to: view)
        table.pinLeft(to: view, Constants.tableOffset)
        table.pinRight(to: view, Constants.tableOffset)
        table.pinTop(to: view, Constants.tableOffset)
        table.pinBottom(to: addWishButton.topAnchor, Constants.tableOffset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = Constants.backgroundColor
        addWishButton.layer.borderWidth = Constants.borderWidth
        addWishButton.layer.borderColor = Constants.borderColor
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        
        addWishButton.setTitleColor(Constants.textColor, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    
    // MARK: - Data Persistence
    private func saveWishes() {
        defaults.set(wishArray, forKey: Constants.Key)
    }
    
    private func loadWishes() {
        if let savedWishes = defaults.array(forKey: Constants.Key) as? [String] {
            wishArray = savedWishes
        }
    }
    // MARK: - Objc methods
    @objc private func addWishButtonPressed() {
        guard !currentWishText.isEmpty && !wishArray.contains(currentWishText) else { return }
        wishArray.append(currentWishText)
        currentWishText = ""
        saveWishes()
        
        if let addWishCell = table.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddWishCell {
            addWishCell.resetText()
        }
        
        table.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            if let wishCell = cell as? WrittenWishCell {
                wishCell.configure(with: wishArray[indexPath.row])
                wishCell.onDeletePressed = { [weak self] wish in
                    guard let self = self, let index = self.wishArray.firstIndex(of: wish) else { return }
                    self.wishArray.remove(at: index)
                    self.saveWishes()
                    
                    self.table.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            if let addWishCell = cell as? AddWishCell {
                addWishCell.addWish = { [weak self] text in
                    self?.currentWishText = text
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
