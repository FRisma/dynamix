//
//  DynamixViewController.swift
//
//
//  Created by Franco Risma on 04/04/2024.
//

import UIKit

protocol DynamixViewControllerFactory {
    func makeMainViewController() -> DynamixViewController
}

public final class DynamixViewController: UIViewController {
    typealias Dependencies = DynamixDirectorFactory
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
//    private(set) var containerCollectionViewController
    
    private let director: DynamixDirector
    
    init(dependencies: Dependencies) {
        self.director = dependencies.makeDirector()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        canvas.tiles.forEach { tile in
            print("FRISMA registering cell type \(tile.tileConfiguration.cellType)")
            collectionView.register(tile.tileConfiguration.cellType, forCellWithReuseIdentifier: "cellId")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.contentView.backgroundColor = [
            UIColor.red,
            UIColor.green,
            UIColor.blue,
            UIColor.lightGray,
            UIColor.systemBrown,
        ].randomElement()
        return cell
    }
}
