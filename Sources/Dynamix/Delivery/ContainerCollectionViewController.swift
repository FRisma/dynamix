//
//  File.swift
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
    
    init(canvas: Canvas, layout: UICollectionViewLayout) {
        self.canvas = canvas
        
        let customLayout = UICollectionViewFlowLayout()
        customLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)  // Set the size of the cells here
        customLayout.minimumLineSpacing = 10  // Space between rows
        customLayout.minimumInteritemSpacing = 10
        
        
        super.init(collectionViewLayout: customLayout)
        view.backgroundColor = .green
        registerCellTypes()
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
}
