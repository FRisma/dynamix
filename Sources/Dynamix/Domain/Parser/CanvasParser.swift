//
//  CanvasParser.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

public struct CanvasParser: Parser {
    // MARK: - Parser
    
    /// Maps the provided data into a defined Canvas
    /// - Parameter data: raw data to map
    /// - Returns: If successful, a fully fledged `Canvas`
    public func parse(data: Any) throws -> Any {
//        let validator = try ParsingValidator(
//            object: ParsingValidator.object(forData: data)
//        )
//        
//        let parsedCanvas = try Canvas(
//            identifier: validator.get(key: .identifier),
//            tiles: parseTiles(validator: validator)
//        )
        
        return "parsedCanvas"
    }
}

private extension String {
    static var identifier: String { "identifier" }
    static var tiles: String { "tiles" }
}
