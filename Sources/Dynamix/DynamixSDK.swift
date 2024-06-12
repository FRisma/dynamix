import UIKit

public struct DynamixSDK {
    private let dependencyContainer = DependencyContainer()
    
    public init() {}
    
    public func register(parser: Parser, forTileType tileType: String) {
        dependencyContainer.tileParserRepository.register(type: tileType, parser: parser)
    }
    
    public func setNetworkEndpoint(_ endpoint: String) {
        // TODO: @FRisma today it's hardcoded in the repository
    }
    
    public func makeDynamixViewController() -> UIViewController {
        dependencyContainer.makeMainViewController()
    }
}
