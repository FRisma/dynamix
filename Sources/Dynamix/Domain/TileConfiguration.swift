//
//  TileConfiguration.swift
//
//
//  Created by Franco Risma on 05/04/2024.
//

import UIKit
import Foundation

public struct TileConfiguration {
    let cellType: UICollectionViewCell.Type
    
    let reuseIdentifier: String
    
    public init(cellType: UICollectionViewCell, reuseIdentifier: String) {
        self.cellType = cellType
        self.reuseIdentifier = reuseIdentifier
    }
}
