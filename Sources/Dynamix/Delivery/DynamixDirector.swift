//
//  DynamixDirector.swift
//  
//
//  Created by Franco Risma on 04/04/2024.
//

import Foundation

final class DynamixDirector {
    enum State {
        case loading
        case loaded(Canvas)
        case error(Error)
    }
    
    enum Action {
        case viewIsReady
    }
    
    private let stateListener: (State) -> Void
    
    init(stateListener: @escaping (State) -> Void) {
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
        // TODO: Make network request to fetch UI + Data
        sleep(2)
        stateListener(.loaded)
    }
}
