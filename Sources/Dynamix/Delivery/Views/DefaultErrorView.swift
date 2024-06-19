//
//  DefaultErrorView.swift
//
//
//  Created by FRisma on 12/06/2024.
//

import UIKit

final class DefaultErrorView: UIView {
    private let errorTitleLabel: UILabel
    private let errorDescriptionLabel: UILabel
    private let retryButton: UIButton

    var retryAction: (() -> Void)?

    override init(frame: CGRect) {
        errorTitleLabel = UILabel()
        errorDescriptionLabel = UILabel()
        retryButton = UIButton(type: .system)
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Not supported")
    }

    private func setupView() {
        backgroundColor = .systemBackground

        // Setup error label
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorTitleLabel.textAlignment = .center
        errorTitleLabel.numberOfLines = 0
        errorTitleLabel.font = UIFont.systemFont(ofSize: 16)
        errorTitleLabel.textAlignment = .center
        errorTitleLabel.textColor = .label
        errorTitleLabel.text = "Something went wrong"

        // Setup error description label
        errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        errorDescriptionLabel.textAlignment = .center
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        errorDescriptionLabel.textAlignment = .center
        errorDescriptionLabel.textColor = .secondaryLabel

        // Setup retry button
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle("Try again!", for: .normal)
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        addSubview(retryButton)

        let vStack = UIStackView(arrangedSubviews: [errorTitleLabel, errorDescriptionLabel, retryButton])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        addSubview(vStack)

        // Layout constraints
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            vStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            vStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ])
    }

    @objc private func retryButtonTapped() {
        retryAction?()
    }

    func configure(message: String, retryAction: @escaping () -> Void) {
        errorDescriptionLabel.text = message
        self.retryAction = retryAction
    }
}
