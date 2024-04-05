//
//  Parser.swift
//  
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

/// A protocol that defines a common API for objects that parse received data and return a different value.
public protocol Parser {
    /// Parses passed-in data into another type.
    /// - Note: This function uses `Any` as input, since more-specific associated types cause major limitations with storage and casting.
    /// Please cast appropriately in conformers and clients to the expected types.
    ///
    /// - Parameter data: The input data to parse.
    /// - Returns: A type parsed from the input data, or `nil` if parsing was not successful.
    func parse(data: Any) throws -> Any
}
