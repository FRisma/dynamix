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
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Set the background color and other view properties if needed
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        // Set up the activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        // Center the activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        // Start animating when the view is added to a window
        if self.window != nil {
            activityIndicator.startAnimating()
        }
    }
}
