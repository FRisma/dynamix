import Foundation

final class DependencyContainer {
    lazy var canvasRepository: CanvasRepository = {
        let tilesParser = DefaultTileParsersRegister()
        tilesParser.register(type: "earnings_rewards", parser: EarningsRewardsTileParser())
        tilesParser.register(type: "earnings_card", parser: EarningsCardTileParser())
        
        let repository = DefaultCanvasRepository(
            path: "api/testing",
            service: FakeHTTPClient(),
            deserializer: JSONDeserializer(),
            parser: CanvasParser(tileRegister: tilesParser)
        )
        return repository
    }()
}

extension DependencyContainer: DynamixViewControllerFactory {
    func makeMainViewController() -> DynamixViewController {
        DynamixViewController(dependencies: self)
    }
}

extension DependencyContainer: DynamixDirectorFactory {
    func makeDirector() -> DynamixDirector {
        DynamixDirector(dependencies: self, stateListener: { _ in })
    }
}

extension DependencyContainer: CanvasRepositoryProvider {}
