//
//  DynamixViewController.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import UIKit

public final class DynamixViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let director = DynamixDirector(stateListener: { _ in })
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        director.stateListener = { [weak self] state in
            self?.handleDirectorState(state)
        }
        director.handleAction(.viewIsReady)
    }
    
    private func handleDirectorState(_ state: DynamixDirector.State) {
        switch state {
        case .loading:
            break
        case .loaded(let canvas):
            display(canvas)
        case .error(let error):
            handleError(error)
        }
    }
    
    private func display(_ canvas: Canvas) {
        guard !canvas.tiles.isEmpty else {
            showEmptyState()
            return
        }
        
        collectionView.reloadData()
    }
    
    private func showEmptyState() {
        // TODO: Add injected empty state
    }
    
    private func handleError(_ error: Error) {
        // TODO: Show injected error view
    }
}

extension DynamixViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
