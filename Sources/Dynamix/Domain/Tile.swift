//
//  Tile.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation
import UIKit

/// A model for a visual element that appears within a `Canvas`. Subclass to add additional properties for specific use cases.
open class Tile/*: Publisher*/ {
    /// The type of Tile, used to help inform which subclass to use for parsing and instantiation.
    public let tileType: String
    
    /// The cell type and configuration logic of the tile.
    public var tileConfiguration: TileConfiguration

    public init(tileType: String) {
        self.tileType = tileType
        tileConfiguration = TileConfiguration.emptyConfiguration
    }
    
    /// The calculated height of a corresponding tile view.
    ///
    /// This implementation returns 0.0, and subclasses should override it.
    ///
    /// - Parameter width: The width in which the tile view will be displayed.
    /// - Returns: The calculated height.
    open func height(forWidth width: CGFloat) -> CGFloat {
        return 0.0
    }
}
