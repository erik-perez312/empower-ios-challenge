//
//  BeneficiaryTableViewCell.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import UIKit

final class BeneficiaryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "BeneficiaryTableViewCell"
    
    private lazy var beneficiaryValueLabel = newValueLabel()
    private lazy var designationValueLabel = newValueLabel()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        return nameLabel
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        beneficiaryValueLabel.text = nil
        designationValueLabel.text = nil
    }
    
    // MARK: Methods
    
    func configure(with beneficiary: Beneficiary) {
        nameLabel.text = "\(beneficiary.firstName) \(beneficiary.lastName)"
        beneficiaryValueLabel.text = beneficiary.beneficiaryType.rawValue
        designationValueLabel.text = beneficiary.designationCode.title
    }
    
    // MARK: Setup
    
    private func setUpContentView() {
        let beneficiaryTypeStackView = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Beneficiary Type:"),
            beneficiaryValueLabel
        ])
        
        let designationStackView = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Designation:"),
            designationValueLabel
        ])
        
        let rootStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            beneficiaryTypeStackView,
            designationStackView
        ])
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.spacing = 5
        rootStackView.distribution = .fill
        rootStackView.alignment = .leading
        rootStackView.axis = .vertical
        
        contentView.addSubview(rootStackView)
        
        let horizontalPadding: CGFloat = 15
        let verticalPadding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, 
                                               constant: verticalPadding),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, 
                                                  constant: -verticalPadding),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, 
                                                   constant: horizontalPadding),
            rootStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, 
                                                    constant: -horizontalPadding)
        ])
    }
    
    private func newTitleLabel(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return titleLabel
    }
    
    private func newValueLabel() -> UILabel {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        return valueLabel
    }
    
    private func newInfoStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }
}
