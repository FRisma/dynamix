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
        view.backgroundColor = .systemBackground
        director.stateListener = { [weak self] state in
            DispatchQueue.main.async {
                self?.handleDirectorState(state)
            }
        }
        director.handleAction(.viewIsReady)
    }
    
    private func handleDirectorState(_ state: DynamixDirector.State) {
        switch state {
        case .loading:
            showLoading()
        case .loaded(let canvas):
            hideLoading()
            hideError()
            display(canvas)
        case .error(let error):
            hideLoading()
            handleError(error)
        }
    }
    
    private func display(_ canvas: Canvas) {
        guard !canvas.tiles.isEmpty else {
            showEmptyState()
            return
        }
        
        let containerCollectionView = ContainerCollectionViewController(canvas: canvas)
        
        add(containerCollectionView, frame: view.frame)
    }
    
    private func showEmptyState() {
        // TODO: Add injected empty state
    }
    
    private func handleError(_ error: Error) {
        // TODO: Show injected error view if any otherwise show default one
        let errorView = DefaultErrorView()
        errorView.configure(message: "Oops something went wrong") { [weak self] in
            self?.director.handleAction(.viewIsReady)
        }
        
        self.view.addSubview(errorView)
    }
    
    private func hideError() {
        view.subviews.filter { $0 is DefaultErrorView }.forEach { $0.removeFromSuperview() }
    }
    
    private func showLoading() {
        // TODO: Show custom loading view if provided otherwise show default one
        let loadingView = DefaultLoadingView(frame: self.view.bounds)
        self.view.addSubview(loadingView)
    }
    
    private func hideLoading() {
        view.subviews.filter { $0 is DefaultLoadingView }.forEach { $0.removeFromSuperview() }
    }
}

private extension UIViewController {
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
