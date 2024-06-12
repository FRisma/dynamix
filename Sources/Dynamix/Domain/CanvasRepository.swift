//
//  CanvasRepository.swift
//  
//
//  Created by FRisma on 12/06/2024.
//

import Foundation

protocol CanvasRepositoryProvider {
    var canvasRepository: CanvasRepository { get }
}

public protocol CanvasRepository {
    typealias RepositoryCompletion = (Result<Canvas, Error>) -> Void
    
    /// Used to fetch the canvas from a source, like network, storage, etc.
    /// - Parameter completion: a Canvas completion
    /// - Returns: a token for cancelling the process
    func request(completion: @escaping RepositoryCompletion) -> Cancellable?
}
