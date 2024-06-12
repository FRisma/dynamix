//
//  CanvasRepository.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

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
    
    func request(completion: @escaping CanvasRepository.RepositoryCompletion) -> Cancellable? {
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
    func deserialize(data: Data, completion: @escaping RepositoryCompletion) {
        do {
            let validator = try ParsingValidator(
                object: ParsingValidator.object(
                    forData: deserializer.deserialize(data: data)
                )
            )
            let canvasResponse: Canvas = try validator.parse(using: parser)
            completion(.success(canvasResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
