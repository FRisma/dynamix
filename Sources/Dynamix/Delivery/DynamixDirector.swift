//
//  DynamixDirector.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

protocol DynamixDirectorFactory {
    func makeDirector() -> DynamixDirector
}

final class DynamixDirector {
    enum State {
        case loading
        case loaded(Canvas)
        case error(Error)
    }

    enum Action {
        case viewIsReady
        case reload
    }

    typealias Dependencies = CanvasRepositoryFactory
    private let canvasRepository: CanvasRepository

    var stateListener: (State) -> Void

    init(dependencies: Dependencies, stateListener: @escaping (State) -> Void) {
        canvasRepository = dependencies.makeCanvasRepository()
        self.stateListener = stateListener
    }

    func handleAction(_ action: Action) {
        switch action {
        case .viewIsReady:
            stateListener(.loading)
            requestCanvas()
            
        case .reload:
            requestCanvas()
        }
    }

    private func requestCanvas() {
        canvasRepository.request { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(canvas):
                handleReceivedCanvas(canvas)
            case let .failure(error):
                stateListener(.error(error))
            }
        }
    }

    private func handleReceivedCanvas(_ canvas: Canvas) {
        stateListener(.loaded(canvas))
    }
}
