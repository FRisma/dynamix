//
//  Deserializer.swift
//  
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

public protocol Deserializer {
    func deserialize(data: Data) throws -> Any
}

/// An enum that represent an error trying to deserialize `Data`
public enum DeserializeError: Error {
    /// `deserializationFailed` is used to identify when deserialization fails
    case deserializationFailed
}

/// The `JSONDeserializer` type converts Data to a JSON object.
public final class JSONDeserializer: Deserializer {
    /// Initializes a new `JSONDeserializer` object.
    public init() {}
    
    /// Deserializes data into JSON.
    ///
    /// - Parameter data: The data to deserialize.
    /// - Returns: A result type with the JSON object, or an error if one occurred during deserialization.
    public func deserialize(data: Data) throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch _ {
            throw DeserializeError.deserializationFailed
        }
    }
}
