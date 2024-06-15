import UIKit

public enum DynamixSDK {
    
    public static func makeDynamixViewController(
        endpoint: String,
        tileParsers: [String: Parser]
    ) -> UIViewController {
        let dependencyContainer = DependencyContainer()
        tileParsers.forEach { register in
            dependencyContainer.tileParserRepository.register(type: register.key, parser: register.value)
        }
        return  dependencyContainer.makeMainViewController()
    }
}

public struct DynamixSDKFactory {
    private var parsers: [String: Parser] = [:]
    private var networkEndpoint: String = "/api/network" // Default value

    public init() {}

    public mutating func register(parser: Parser, tileType: String) {
        parsers[tileType] = parser
    }

    public mutating func setNetworkEndpoint(_ endpoint: String) {
        networkEndpoint = endpoint
    }

    public func make() -> UIViewController {
        DynamixSDK.makeDynamixViewController(
            endpoint: networkEndpoint,
            tileParsers: parsers
        )
    }
}
