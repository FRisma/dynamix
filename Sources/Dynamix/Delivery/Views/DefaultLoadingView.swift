//
//  DefaultLoadingView.swift
//
//
//  Created by FRisma on 12/06/2024.
//

import UIKit

final class DefaultLoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView

    override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Set the background color and other view properties if needed
        backgroundColor = .systemBackground

        // Set up the activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        // Center the activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        // Start animating when the view is added to a window
        if window != nil {
            activityIndicator.startAnimating()
        }
    }
}
