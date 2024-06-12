import Foundation

final class DependencyContainer {
    lazy var canvasRepository: CanvasRepository = {
        let repository = DefaultCanvasRepository(
            path: "api/testing",
            service: FakeHTTPClient(),
            deserializer: JSONDeserializer(),
            parser: CanvasParser(tileRegister: tileParserRepository)
        )
        return repository
    }()
    
    var tileParserRepository: TileParsersRegister = {
        DefaultTileParsersRegister()
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
extension DependencyContainer: TileParserRepositoryProvider {}
