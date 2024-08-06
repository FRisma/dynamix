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
        director = dependencies.makeDirector()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
        case let .loaded(canvas):
            hideLoading()
            hideError()
            display(canvas)
        case let .error(error):
            hideLoading()
            handleError(error)
        }
    }

    private func display(_ canvas: Canvas) {
        guard !canvas.tiles.isEmpty else {
            showEmptyState()
            return
        }

        if let containerCollectionViewController {
            containerCollectionViewController.canvas = canvas
        } else {
            let containerCollectionView = ContainerCollectionViewController(canvas: canvas)
            containerCollectionView.onPullToRefresh = { [weak self] in
                self?.director.handleAction(.reload)
            }
            add(containerCollectionView, frame: view.frame)
            containerCollectionViewController = containerCollectionView
        }
    }

    private func showEmptyState() {
        // TODO: Add injected empty state
    }

    private func handleError(_ error: Error) {
        // TODO: Show injected error view if any otherwise show default one
        let errorView = DefaultErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.configure(message: error.localizedDescription) { [weak self] in
            self?.director.handleAction(.viewIsReady)
        }

        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func hideError() {
        view.subviews.filter { $0 is DefaultErrorView }.forEach { $0.removeFromSuperview() }
    }

    private func showLoading() {
        // TODO: Show custom loading view if provided otherwise show default one
        let loadingView = DefaultLoadingView(frame: view.bounds)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
