//
//  Tile.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation
import UIKit

/// A model for a visual element that appears within a `Canvas`. Subclass to add additional properties for specific use cases.
open class Tile {
    /// The type of Tile, used to help inform which subclass to use for parsing and instantiation.
    public let tileType: String
    
    /// The type of cell that going to be used
    public let cellType: UICollectionViewCell.Type
    
    /// The reuse identifier for collection view cells
    public let reuseIdentifier: String
    
    /// The cell type and configuration logic of the tile.
    public var tileConfiguration: TileConfiguration

    public init(
        tileType: String,
        cellType: UICollectionViewCell.Type,
        reuseIdentifier: String
        
    ) {
        self.tileType = tileType
        self.cellType = cellType
        self.reuseIdentifier = reuseIdentifier
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
