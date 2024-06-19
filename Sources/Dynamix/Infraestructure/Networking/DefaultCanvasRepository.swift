//
//  DefaultCanvasRepository.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

/// Base implementation of CanvasRepository, use it to request any given canvas
final class DefaultCanvasRepository: CanvasRepository {
    private let endpoint: String
    private let httpService: HTTPClient
    private let deserializer: Deserializer = JSONDeserializer()
    private let canvasParser: Parser

    init(
        endpoint: String,
        httpService: HTTPClient,
        canvasParser: Parser
    ) {
        self.endpoint = endpoint
        self.httpService = httpService
        self.canvasParser = canvasParser
    }

    func request(completion: @escaping RepositoryCompletion) -> Cancellable? {
        httpService.requestData(path: endpoint) { [weak self] result in
            switch result {
            case let .success(data):
                self?.deserialize(data: data, completion: completion)
            case let .failure(error):
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
            let canvasResponse: Canvas = try validator.parse(using: canvasParser)
            completion(.success(canvasResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
