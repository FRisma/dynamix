//
//  ContainerCollectionViewController.swift
//
//
//  Created by FRisma on 18/05/2024.
//

import UIKit

final class ContainerCollectionViewController: UICollectionViewController {
    var canvas: Canvas {
        didSet {
            assert(Thread.isMainThread)
            refreshCanvas()
        }
    }

    private func refreshCanvas() {
        registerCellTypes()
        collectionView.reloadData()
    }

    init(canvas: Canvas) {
        self.canvas = canvas
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let compositionalLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(collectionViewLayout: compositionalLayout)

        registerCellTypes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func registerCellTypes() {
        collectionView.backgroundColor = .systemBackground
        for tile in canvas.tiles {
            collectionView.register(tile.cellType, forCellWithReuseIdentifier: tile.reuseIdentifier)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension ContainerCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: canvas.tiles[indexPath.row].reuseIdentifier, for: indexPath)
        let tile = canvas.tiles[indexPath.item]
        tile.tileConfiguration.cellConfiguration(tile, cell, indexPath, parent as! DynamixViewController)
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension ContainerCollectionViewController {
    override func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        canvas.tiles.count
    }
}
