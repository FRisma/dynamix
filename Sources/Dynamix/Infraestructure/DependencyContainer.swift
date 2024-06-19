import Foundation

final class DependencyContainer {
    private let httpClient: HTTPClient
    private let canvasParser: Parser
    private let endpoint: String

    init(
        httpClient: HTTPClient,
        canvasParser: Parser,
        endpoint: String
    ) {
        self.httpClient = httpClient
        self.canvasParser = canvasParser
        self.endpoint = endpoint
    }
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

extension DependencyContainer: CanvasRepositoryFactory {
    func makeCanvasRepository() -> CanvasRepository {
        DefaultCanvasRepository(
            endpoint: endpoint,
            httpService: httpClient,
            canvasParser: canvasParser
        )
    }
}
