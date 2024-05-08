//
//  TileConfiguration.swift
//
//
//  Created by Franco Risma on 05/04/2024.
//

import UIKit
import Foundation

public typealias CellConfiguration = (Tile, UICollectionViewCell, IndexPath, DynamixViewController) -> Void

public struct TileConfiguration {
    public let cellType: UICollectionViewCell.Type
    public let reuseIdentifier: String
    public let cellConfiguration: CellConfiguration
    
    /// Creates a new `TileConfiguration`.
    ///
    /// - Parameters:
    ///   - cellType: The type of the cell to be configured
    ///   - reuseIdentifier: An optional reuse identifier to provide when reusing a cell of `cellType`.
    ///                      This is helpful for when multiple tiles use the same `cellType`.
    ///   - cellConfiguration: Closure used to configure the cell.
    public init(
        cellType: UICollectionViewCell.Type,
        reuseIdentifier: String,
        cellConfiguration: @escaping CellConfiguration
    ) {
        self.cellType = cellType
        self.reuseIdentifier = reuseIdentifier
        self.cellConfiguration = cellConfiguration
    }
}

public extension TileConfiguration {
    /// A default value for Tile definition
    static var emptyConfiguration: TileConfiguration {
        TileConfiguration(
            cellType: UICollectionViewCell.self,
            reuseIdentifier: "cellId",
            cellConfiguration: { _, _, _, _ in
                assertionFailure("A tile must have a frame configuration set during initialization.")
            }
        )
    }
}
