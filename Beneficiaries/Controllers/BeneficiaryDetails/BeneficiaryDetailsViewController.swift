//
//  BeneficiaryDetailsViewController.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/13/24.
//

import Foundation
import UIKit

final class BeneficiaryDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    let viewModel: BeneficiaryDetailsViewModelProtocol
    
    // MARK: Initialization
    
    init(viewModel: BeneficiaryDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        view.backgroundColor = .white
        setUpView()
    }
    
    // MARK: Setup
    
    private func setUpView() {
        fullNameLabel.text = "\(viewModel.beneficiary.fullName)"
        
        let addressValue = newValueLabel(value: viewModel.beneficiary.address.formatted)
        addressValue.numberOfLines = 0
        
        let addressStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Address:"),
            addressValue
        ])
        // adjust for multi-line label
        addressStack.alignment = .firstBaseline
        addressStack.distribution = .fill
        
        let beneficiaryTypeStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Beneficiary Type:"),
            newValueLabel(value: viewModel.beneficiary.beneficiaryType.rawValue)
        ])
        
        let birthDateStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Birth Date:"),
            newValueLabel(value: viewModel.formattedBirthDate())
        ])
        
        let designationStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Designation:"),
            newValueLabel(value: viewModel.beneficiary.designationCode.title)
        ])
        
        let phoneNumberStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Phone Number:"),
            newValueLabel(value: viewModel.beneficiary.phoneNumber)
        ])
        
        let ssnStack = newInfoStackView(arrangedSubviews: [
            newTitleLabel(title: "Social Security Number: "),
            newValueLabel(value: viewModel.beneficiary.ssn)
        ])
                                                                
        let rootStackView = UIStackView(arrangedSubviews: [
            fullNameLabel,
            addressStack,
            beneficiaryTypeStack,
            birthDateStack,
            designationStack,
            phoneNumberStack,
            ssnStack
        ])
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.spacing = 15
        rootStackView.distribution = .fillProportionally
        rootStackView.alignment = .leading
        rootStackView.axis = .vertical
        
        view.addSubview(rootStackView)
        
        let horizontalPadding: CGFloat = 15
        let verticalPadding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: verticalPadding),
            rootStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -verticalPadding),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: horizontalPadding),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
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
    
    private func newValueLabel(value: String) -> UILabel {
        let valueLabel = UILabel()
        valueLabel.text = value
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
