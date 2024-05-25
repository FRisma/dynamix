import UIKit

public enum DynamixSDK {
    public static func makeDynamixViewController(
        endpoint: String
    ) -> UIViewController {
        
        let dc = DependencyContainer()
        let vc = dc.makeMainViewController()
        
        return vc
    }
}

struct EarningsRewardsTileParser: Parser {
    func parse(data: Any) throws -> Any {
        let jsonData = try JSONSerialization.data(withJSONObject: ParsingValidator.object(forData: data))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedTileModel = try decoder.decode(Model.self, from: jsonData)
        
        return EarningsRewardsTile(model: decodedTileModel)
    }
    
    struct Model: Decodable {
        let tileType: String
        let currencyIconUrl: URL
        let currency: String
        let headerSection: HeaderSection
        let expandableSection: ExpandableSection
        
        struct HeaderSection: Decodable {
            let headerTitle: String
            let headerSubtitle: String
            let headerAmount: String
            let headerCurrenct: String
        }
        
        struct ExpandableSection: Decodable {
            let expandableTitle: String
            let expandableSubtitle: String
            let expandableSwitchText: String
        }
    }
    
    final class EarningsRewardsTile: Tile {
        init(model: Model) {
            super.init(tileType: model.tileType)
            
            self.tileConfiguration = TileConfiguration(
                cellType: UICollectionViewCell.self,
                reuseIdentifier: model.tileType,
                cellConfiguration: { tile, cell, indexPath, viewController in
                    
                }
            )
        }
    }
}

struct EarningsCardTileParser: Parser {
    func parse(data: Any) throws -> Any {
        let jsonData = try JSONSerialization.data(withJSONObject: ParsingValidator.object(forData: data))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedTileModel = try decoder.decode(Model.self, from: jsonData)
        
        return EarningsCardTile(model: decodedTileModel)
    }
    
    struct Model: Decodable {
        let tileType: String
        let title: String
        let subtitle: String
    }
    
    final class EarningsCardTile: Tile {
        init(model: Model) {
            super.init(tileType: model.tileType)
            
            self.tileConfiguration = TileConfiguration(
                cellType: UICollectionViewCell.self,
                reuseIdentifier: model.tileType,
                cellConfiguration: { tile, cell, indexPath, viewController in
                    
                }
            )
        }
    }
}
