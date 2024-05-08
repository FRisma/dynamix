//
//  Canvas.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

/// Actual Canvas table directory containing the `Tile` array for dynamic UI rendering
public final class Canvas {
    /// Canvas' identifier
    public let identifier: String
    
    /// Tiles' array. Each tile represents a UI component to be mapped and rendered on screen
    public var tiles: [Tile]
    
    /// Canvas' layout padding
    public let layout: CanvasLayout
    
    init(
        identifier: String,
        tiles: [Tile],
        layout: CanvasLayout = .zero
    ) {
        self.identifier = identifier
        self.tiles = tiles
        self.layout = layout
    }
}
