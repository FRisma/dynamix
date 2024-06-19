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
    }

    typealias Dependencies = CanvasRepositoryProvider
    private let dependencies: Dependencies

    var stateListener: (State) -> Void

    init(dependencies: Dependencies, stateListener: @escaping (State) -> Void) {
        self.dependencies = dependencies
        self.stateListener = stateListener
    }

    func handleAction(_ action: Action) {
        switch action {
        case .viewIsReady:
            stateListener(.loading)
            requestCanvas()
        }
    }

    private func requestCanvas() {
        dependencies.canvasRepository.request { [weak self] result in
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
