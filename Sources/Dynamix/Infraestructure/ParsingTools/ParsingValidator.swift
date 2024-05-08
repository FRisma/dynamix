//
//  ParsingValidator.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

/// Type-alias for a JSON object dictionary.
public typealias JSON = [String: AnyObject]

/// An object for validating the structure of JSON while parsing it.
public class ParsingValidator {
    /// Casts data to `JSON`, if possible. Otherwise, throws a `ParsingError`.
    ///
    /// - Parameter data: `Data` to be casted into `JSON`.
    /// - Returns: The data as `JSON`.
    /// - Throws: A `ParsingError` if the data could not be cast.
    public static func object(forData data: Any) throws -> JSON {
        guard let jsonData = data as? JSON else {
            throw ParsingError.typeMismatch(JSON.self, ParsingError.Context(codingPath: []))
        }

        return jsonData
    }
    
    private let object: JSON
    private let codingPath: [String]
    
    /// Creates a new `ParsingValidator`.
    ///
    /// - Parameters:
    ///   - object: The `JSON` object to parse and validate.
    ///   - codingPath: A coding path for the JSON object. Used for as a prefix for error generation. Defaults to `[]`.
    public init(object: JSON, codingPath: [String] = []) {
        self.object = object
        self.codingPath = codingPath
    }
    
    /// Returns the value of a given key.
    ///
    /// - Parameter key: The key that the value is associated with.
    /// - Returns: The value associated with `key`.
    /// - Throws: One of the following errors:
    ///
    /// * `ParsingError.keyNotFound` if `key` is not present
    /// * `ParsingError.valueNotFound` if the value associated with `key` is `null`
    /// * `ParsingError.typeMismatch` if the value is not of the expected type `T`.
    public func get<T>(key: String) throws -> T {
        do {
            guard let value = object[key] else {
                throw ParsingError.keyNotFound(ParsingError.Context(codingPath: []))
            }

            // It turns out that, if you cast an optional type to `AnyObject`, it gets turned into `NSNull`.
            // Hence the below check instead of a check for the value being an `Optional<T>`.
            if value is NSNull {
                throw ParsingError.valueNotFound(T.self, ParsingError.Context(codingPath: []))
            }

            guard let typedValue = value as? T else {
                throw ParsingError.typeMismatch(T.self, ParsingError.Context(codingPath: []))
            }

            return typedValue
        } catch let error as ParsingError {
            throw error.prepend(pathComponents: codingPath + [key])
        } catch {
            throw error
        }
    }
    
    /// Decodes a JSON object into a generic type.
    /// - Parameter decoder: The JSON decoder to use. Defaults to a decoder with the key decoding strategy set to convert from snake case.
    /// - Returns: The decoded object of type T.
    public func decode<T: Decodable>(
        decoder: () -> JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }) throws -> T {
        try decoder().decode(
            T.self,
            from: JSONSerialization.data(
                withJSONObject: object, options: []
            )
        )
    }
    
    /// Parses the object contained by the `ParsingValidator` instance.
    ///
    /// - Parameter parser: The `Parser` to use when parsing.
    /// - Returns: The parsed object.
    /// - Throws: A `ParsingError.typeMismatch` if the type returned from `parser` does not match the expected type.
    public func parse<T>(using parser: Parser) throws -> T {
        do {
            let parsedValue = try parser.parse(data: object)

            guard let value = parsedValue as? T else {
                throw ParsingError.typeMismatch(T.self, ParsingError.Context(codingPath: []))
            }

            return value
        } catch let error as ParsingError {
            throw error.prepend(pathComponents: codingPath)
        } catch {
            throw error
        }
    }
}
