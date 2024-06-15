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
    public let cellConfiguration: CellConfiguration
    
    /// Creates a new `TileConfiguration`.
    ///
    /// - Parameters:
    ///   - cellConfiguration: Closure used to configure the cell.
    public init(
        cellConfiguration: @escaping CellConfiguration
    ) {
        self.cellConfiguration = cellConfiguration
    }
}

public extension TileConfiguration {
    /// A default value for Tile definition
    static var emptyConfiguration: TileConfiguration {
        TileConfiguration(
            cellConfiguration: { _, _, _, _ in
                assertionFailure("A tile must have a frame configuration set during initialization.")
            }
        )
    }
}
