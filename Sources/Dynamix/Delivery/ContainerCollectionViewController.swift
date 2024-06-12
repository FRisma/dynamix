//
//  ContainerCollectionViewController.swift
//
//
//  Created by FRisma on 18/05/2024.
//

import UIKit
import Foundation

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
        
        let customLayout = UICollectionViewFlowLayout()
        customLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)  // Set the size of the cells here
        customLayout.minimumLineSpacing = 10  // Space between rows
        customLayout.minimumInteritemSpacing = 10
        
        super.init(collectionViewLayout: customLayout)
        registerCellTypes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCellTypes() {
        canvas.tiles.forEach { tile in
            let configuration = tile.tileConfiguration
            collectionView.register(configuration.cellType, forCellWithReuseIdentifier: configuration.reuseIdentifier)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension ContainerCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let tile = canvas.tiles[indexPath.item]
        tile.tileConfiguration.cellConfiguration(tile, cell, indexPath, self.parent as! DynamixViewController)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = canvas.tiles[indexPath.row].tileConfiguration.reuseIdentifier
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension ContainerCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        canvas.tiles.count
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 100) // Set item size here
    }
}
