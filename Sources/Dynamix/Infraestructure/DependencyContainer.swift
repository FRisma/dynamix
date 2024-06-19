import Foundation

public protocol DynamixExternalDependencies:
    HTTPClientServiceFactory,
    DeserializerServiceFactory,
    ParserServiceFactory {}

final class DependencyContainer {
//    private let externalDependencies: DynamixExternalDependencies
//
//    init(externalDependencies: DynamixExternalDependencies) {
//        self.externalDependencies = externalDependencies
//    }

    lazy var canvasRepository: CanvasRepository = {
        let repository = DefaultCanvasRepository(
            path: "api/testing",
            service: FakeHTTPClient(),
            deserializer: JSONDeserializer(),
            parser: CanvasParser(tileRegister: tileParserRepository)
        )
        return repository
    }()

    var tileParserRepository: TileParsersRegister = DefaultTileParsersRegister()
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

// extension DependencyContainer: HTTPClientServiceFactory {
//    func makeHTTPClientService() -> HTTPClient {
//        externalDependencies.makeHTTPClientService()
//    }
// }
//
// extension DependencyContainer: DeserializerServiceFactory {
//    func makeDeserializerService() -> Deserializer {
//        externalDependencies.makeDeserializerService()
//    }
// }
//
// extension DependencyContainer: ParserServiceFactory {
//    func makeParserService() -> Parser {
//        externalDependencies.makeParserService()
//    }
// }

extension DependencyContainer: CanvasRepositoryProvider {}
extension DependencyContainer: TileParserRepositoryProvider {}
