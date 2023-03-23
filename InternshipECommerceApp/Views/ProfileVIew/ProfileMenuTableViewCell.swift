//
//  ProfileMenuTableViewCell.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit

class ProfileMenuTableViewCell: UITableViewCell {

    static let reuseID = "ProfileMenuTableViewCell"
    
    private let itemImageView: UIImageView = {
       let itemImageView = UIImageView()
        itemImageView.contentMode = .center
        itemImageView.backgroundColor = UIColor(hexString: "#EEEFF4")
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        return itemImageView
    }()
    
    private let itemLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium, fontSize: 16, alingment: .left)
    private let balanceLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratRegular, fontSize: 14, alingment: .right)

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubviews(itemImageView, itemLabel, balanceLabel)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemLabel.text = nil
        balanceLabel.isHidden = true
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupCell()
    }
    
    // MARK: - setupCell
    private func setupCell() {
        itemLabel.textColor = UIColor(hexString: "#040402")
        itemImageView.layer.cornerRadius = itemImageView.frame.height / 2
        itemImageView.clipsToBounds = true
    }
    
    /// Configure cell
    /// - Parameter model: ProfileMenuItems model
    public func configure(with model: ProfileMenuItems) {
        itemImageView.image = model.itemImage
        itemLabel.text = model.itemName
        if model.itemIndicator == .disclosureIndicator {
            addCustomDisclosureIndicator(with: UIColor(hexString: "#040402"))
        }
        if model == .balance {
            balanceLabel.isHidden = false
            balanceLabel.text = "$ 1593"
        }
    }
    
    // MARK: - set constraints
    private func setConstraints() {
        [itemImageView, itemLabel, balanceLabel].forEach {
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            itemImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            itemImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            balanceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            balanceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            itemLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 5),
            itemLabel.rightAnchor.constraint(equalTo: balanceLabel.leftAnchor, constant: 5)
        ])
    }
    
}
