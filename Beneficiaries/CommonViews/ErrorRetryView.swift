//
//  ErrorRetryView.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/13/24.
//

import Foundation
import UIKit

final class ErrorRetryView: UIView {
    
    // MARK: Properties
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var retryButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Retry", for: .normal)
        return button
    }()
    
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: Initialization
    
    init(title: String = "Please try again.", onRetryAction action: UIAction) {
        super.init(frame: .zero)
        
        self.title = title
        self.retryButton.addAction(action, for: .touchUpInside)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setUpView() {
        let rootStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            retryButton
        ])
        
        rootStackView.axis = .vertical
        rootStackView.alignment = .center
        rootStackView.spacing = 15
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rootStackView)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -padding),
            rootStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rootStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
