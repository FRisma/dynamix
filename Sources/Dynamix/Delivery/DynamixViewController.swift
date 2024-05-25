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
    
    private(set) var containerCollectionViewController: ContainerCollectionViewController?
    
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
        
        let containerCollectionView = ContainerCollectionViewController(canvas: canvas, layout: UICollectionViewFlowLayout())
        
        add(containerCollectionView, frame: view.frame)
        
//        self.addChild(containerCollectionView)
//        containerCollectionView.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(containerCollectionView.view)
//        NSLayoutConstraint.activate([
//            containerCollectionView.view.topAnchor.constraint(equalTo: view.topAnchor),
//            containerCollectionView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            containerCollectionView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            containerCollectionView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//        containerCollectionView.didMove(toParent: self)
    }
    
    private func showEmptyState() {
        // TODO: Add injected empty state
    }
    
    private func handleError(_ error: Error) {
        // TODO: Show injected error view
    }
    
    private func showLoading() {
        // TODO: Show Loading
    }
}

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
