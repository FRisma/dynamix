//
//  TileRegister.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

public protocol TileParsersRegister {
    /// A map of tile parsers where the key is the one defined in the Canvas API contract
    var registry: [String: Parser] { get }
    
    /// Adds a new parser to the registry
    /// - Parameters:
    ///   - type: the `String` key for the tile
    ///   - parser: the `Parser` to use for the matching `key`
    func register(type: String, parser: Parser)
    
    func initTileFrom(json: JSON) throws -> Tile
}

/// A base implementation of TileRegister, use it to register any tile supported by the receiving `Canvas`
public final class DefaultTileParsersRegister: TileParsersRegister {
    public var registry: [String: Parser] = [:]
    
    private let tileTypeKey: String
    
    public init(tileTypeKey: String = "tile_type") {
        self.tileTypeKey = tileTypeKey
    }
    
    public func initTileFrom(json: JSON) throws -> Tile {
        let validator = ParsingValidator(object: json)
        let type: String = try validator.get(key: tileTypeKey)

        guard let entry = registry[type] else {
            throw MissingParserError(tileType: type)
        }

        let decodedTile: Tile = try validator.parse(using: entry)

        return decodedTile
    }
    
    public func register(type: String, parser: Parser) {
        registry[type] = parser
    }
}

struct MissingParserError: Error, LocalizedError {
    var errorDescription: String {
        "Missing parser for tile type: \(tileType)"
    }
    
    private let tileType: String
    
    init(tileType: String) {
        self.tileType = tileType
    }
}
