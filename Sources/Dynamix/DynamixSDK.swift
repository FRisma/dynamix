import UIKit

public enum DynamixSDK {
    public static func makeDynamixViewController() -> UIViewController {
        let tilesParser = DefaultTileParsersRegister()
        tilesParser.register(type: "earnings_rewards", parser: EarningsRewardsTileParser())
        tilesParser.register(type: "earnings_card", parser: EarningsCardTileParser())
        
        let repository = DefaultCanvasRepository(
            path: "/api/testing",
            service: FakeHTTPClient(),
            deserializer: JSONDeserializer(),
            parser: CanvasParser(tileRegister: tilesParser)
        )
        
        repository.request { result in
            switch result {
            case .success(let canvas):
                print("Success")
                // TODO: Here create a UIViewController
            case .failure(let error):
                print("Error \(error)")
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        return viewController
    }
}

private struct EarningsRewardsTileParser: Parser {
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

private struct EarningsCardTileParser: Parser {
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
