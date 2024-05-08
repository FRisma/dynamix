//
//  CanvasLayout.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import UIKit

/// Defines the contentn layout for the Canvas
public struct CanvasLayout {
    let contentInsets: UIEdgeInsets
    let tileInsets: UIEdgeInsets

    public init(contentInsets: UIEdgeInsets, tileInsets: UIEdgeInsets) {
        self.contentInsets = contentInsets
        self.tileInsets = tileInsets
    }
}

public extension CanvasLayout {
    static var defaultList: CanvasLayout {
        .init(
            contentInsets: .zero,
            tileInsets: .init(top: .zero, left: .zero, bottom: 8, right: .zero)
        )
    }
    
    static var zero: CanvasLayout {
        .init(contentInsets: .zero, tileInsets: .zero)
    }
}
