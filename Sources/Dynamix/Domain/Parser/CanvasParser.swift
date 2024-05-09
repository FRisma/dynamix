//
//  CanvasParser.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

public struct CanvasParser: Parser {
    private let tileRegister: TileParsersRegister
    
    /// Initializes the Parser.
    /// - Parameter tileRegister: Defined supported tiles
    init(tileRegister: TileParsersRegister) {
        self.tileRegister = tileRegister
    }
    
    // MARK: - Parser
    
    /// Maps the provided data into a defined Canvas
    /// - Parameter data: raw data to map
    /// - Returns: If successful, a fully fledged `Canvas`
    public func parse(data: Any) throws -> Any {
        let validator = try ParsingValidator(
            object: ParsingValidator.object(forData: data)
        )
        
        let parsedCanvas = try Canvas(
            identifier: validator.get(key: .identifier),
            tiles: parseTiles(validator: validator)
        )
        
        return parsedCanvas
    }
    
    private func parseTiles(validator: ParsingValidator) throws -> [Tile] {
        let tilesJson: [JSON] = try validator.get(key: .tiles)
        let tiles: [Tile] = tilesJson.compactMap {
            do {
                return try tileRegister.initTileFrom(json: $0)
            } catch {
                print(error)
                return nil
            }
        }
        return tiles
    }
}

private extension String {
    static var identifier: String { "identifier" }
    static var tiles: String { "tiles" }
}
