//
//  CanvasRepository.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

protocol CanvasRepositoryProvider {
    var canvasRepository: CanvasRepository { get }
}

public typealias CanvasRepositoryCompletion = (Result<Canvas, Error>) -> Void

public protocol CanvasRepository {
    /// Used to fetch the canvas from a source, like network, storage, etc.
    /// - Parameter completion: a Canvas completion
    /// - Returns: a token for cancelling the process
    func request(completion: @escaping CanvasRepositoryCompletion) -> Cancellable?
}

/// Base implementation of CanvasRepository, use it to request any given canvas
final class DefaultCanvasRepository: CanvasRepository {
    private let service: HTTPClient
    private let deserializer: Deserializer
    private let parser: Parser
    private let requestPath: String
    
    init(
        path: String,
        service: HTTPClient,
        deserializer: Deserializer,
        parser: Parser
    ) {
        self.service = service
        self.parser = parser
        self.deserializer = deserializer
        requestPath = path
    }
    
    func request(completion: @escaping CanvasRepositoryCompletion) -> Cancellable? {
        service.requestData(path: self.requestPath) { [weak self] result in
            switch result {
            case .success(let data):
                self?.deserialize(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension DefaultCanvasRepository {
    func deserialize(data: Data, completion: @escaping CanvasRepositoryCompletion) {
        do {
            let unwrappedParser = parser
            let validator = try ParsingValidator(
                object: ParsingValidator.object(
                    forData: deserializer.deserialize(data: data)
                )
            )
            let canvasResponse: Canvas = try validator.parse(using: unwrappedParser)
            completion(.success(canvasResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
