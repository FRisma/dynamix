//
//  ParsingError.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

/// An error type used for when an error occurs while parsing using a `ParsingValidator`.
public enum ParsingError: Error {
    /// A structure describing the context in which a `ParsingError` ocurred.
    public struct Context {
        /// The path of coding keys taken to get to the point of the failing parse call.
        public let codingPath: [String]

        /// Creates a new context with the given path of coding keys.
        ///
        /// - Parameter codingPath: The path of coding keys taken to get to the point of the failing parse call.
        public init(codingPath: [String]) {
            self.codingPath = codingPath
        }
    }

    /// An error indicating that a key could not be found that was requested during parsing.
    case keyNotFound(Context)

    /// An error indicating that a value was not found for a given key.
    case valueNotFound(Any.Type, Context)

    /// An error indicating that a value was found for a given key, but the value was not of the expected type.
    case typeMismatch(Any.Type, Context)

    /// An error indicating that the data is corrupted or otherwise invalid.
    case dataCorrupted(Context)
}

extension ParsingError {
    /// Prepends path components to the `ParsingError.Context`'s `codingPath`.
    ///
    /// - Parameter pathComponents: The path components to prepend.
    /// - Returns: A new instance of the same error with an updated context containing the new coding path.
    func prepend(pathComponents: [String]) -> ParsingError {
        switch self {
        case .keyNotFound(let context):
            return .keyNotFound(ParsingError.Context(codingPath: pathComponents + context.codingPath))
        case .valueNotFound(let type, let context):
            return .valueNotFound(type, ParsingError.Context(codingPath: pathComponents + context.codingPath))
        case .typeMismatch(let type, let context):
            return .typeMismatch(type, ParsingError.Context(codingPath: pathComponents + context.codingPath))
        case .dataCorrupted(let context):
            return .dataCorrupted(ParsingError.Context(codingPath: pathComponents + context.codingPath))
        }
    }

    /// Prepends a path component to the `ParsingError.Context`'s `codingPath`.
    ///
    /// - Parameter pathComponent: The path component to prepend.
    /// - Returns: A new instance of the same error with an updated context containing the new coding path.
    func prepend(pathComponent: String) -> ParsingError {
        return prepend(pathComponents: [pathComponent])
    }
}
