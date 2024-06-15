//
//  ContainerCollectionViewController.swift
//
//
//  Created by FRisma on 18/05/2024.
//

import UIKit

final class ContainerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
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

        let compositionalLayout: UICollectionViewCompositionalLayout = {
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
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
        collectionView.backgroundColor = .systemCyan
        canvas.tiles.forEach { tile in
            collectionView.register(tile.cellType, forCellWithReuseIdentifier: tile.reuseIdentifier)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension ContainerCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: canvas.tiles[indexPath.row].reuseIdentifier, for: indexPath)
        let tile = canvas.tiles[indexPath.item]
        tile.tileConfiguration.cellConfiguration(tile, cell, indexPath, self.parent as! DynamixViewController)
        return cell
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(
//            width: collectionView.bounds.width,
//            height: canvas.tiles[indexPath.row].height(forWidth: collectionView.bounds.width))
//    }
}

//final class ContainerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    var canvas: Canvas {
//        didSet {
//            assert(Thread.isMainThread)
//            refreshCanvas()
//        }
//    }
//
//    private func refreshCanvas() {
//        registerCellTypes()
//        collectionView.reloadData()
//    }
//
//    init(canvas: Canvas) {
//        self.canvas = canvas
//
////        let layout = UICollectionViewFlowLayout()
////        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Padding for the section
////        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
////        layout.minimumLineSpacing = 10  // Space between rows
////        layout.minimumInteritemSpacing = 10
//
//        let layout = UICollectionViewFlowLayout()
////        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        super.init(collectionViewLayout: layout)
//        registerCellTypes()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//    private func registerCellTypes() {
//        collectionView.backgroundColor = .systemCyan
//        canvas.tiles.forEach { tile in
//            collectionView.register(tile.cellType, forCellWithReuseIdentifier: tile.reuseIdentifier)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension ContainerCollectionViewController {
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: canvas.tiles[indexPath.row].reuseIdentifier, for: indexPath)
//        let tile = canvas.tiles[indexPath.item]
//        tile.tileConfiguration.cellConfiguration(tile, cell, indexPath, self.parent as! DynamixViewController)
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension ContainerCollectionViewController {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        canvas.tiles.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(
//            width: collectionView.bounds.width,
//            height: canvas.tiles[indexPath.row].height(forWidth: collectionView.bounds.width))
//    }
//}
//
//
//
//final class TableFlowLayout: UICollectionViewFlowLayout {
//    override func prepare() {
//        super.prepare()
//        self.scrollDirection = .vertical
//        self.minimumInteritemSpacing = 0
//        self.minimumLineSpacing = 0
//    }
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.representedElementCategory == .cell {
//                layoutAttribute.frame.size.width = collectionView?.bounds.width ?? 0
//            }
//        }
//        return attributes
//    }
//    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attributes = super.layoutAttributesForItem(at: indexPath)
//        attributes?.frame.size.width = collectionView?.bounds.width ?? 0
//        return attributes
//    }
//}
