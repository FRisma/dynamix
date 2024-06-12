//
//  ErrorView.swift
//
//
//  Created by FRisma on 12/06/2024.
//

import UIKit

final class DefaultErrorView: UIView {
    
    private let errorLabel: UILabel
    private let retryButton: UIButton
    
    var retryAction: (() -> Void)?
    
    override init(frame: CGRect) {
        self.errorLabel = UILabel()
        self.retryButton = UIButton(type: .system)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.errorLabel = UILabel()
        self.retryButton = UIButton(type: .system)
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        // Setup error label
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .darkGray
        self.addSubview(errorLabel)
        
        // Setup retry button
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        self.addSubview(retryButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc private func retryButtonTapped() {
        retryAction?()
    }
    
    func configure(message: String, retryAction: @escaping () -> Void) {
        errorLabel.text = message
        self.retryAction = retryAction
    }
}

