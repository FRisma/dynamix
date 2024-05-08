//
//  TileRegister.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

public protocol TileRegister {
    var registry: [String: Parser] { get }

    func initTileFrom(json: [String: [String: Any]]) throws -> Tile
    func register(type: String, parser: Parser)
}
