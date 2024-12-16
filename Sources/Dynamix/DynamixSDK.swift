import UIKit

public enum DynamixSDK {
    public static func makeDynamixViewController(
        endpoint: String,
        canvasParser: Parser? = nil,
        tileParsers: [String: Parser],
        showNavigationBar: Bool = true,
        httpClient: HTTPClient
    ) -> UIViewController {
        let nonOptionalCanvasParser: Parser
        if let canvasParser {
            nonOptionalCanvasParser = canvasParser
        } else {
            let tileRegister = DefaultTileParsersRegister()
            for parser in tileParsers {
                tileRegister.register(type: parser.key, parser: parser.value)
            }
            nonOptionalCanvasParser = CanvasParser(tileRegister: tileRegister)
        }

        let dependencyContainer = DependencyContainer(
            httpClient: httpClient,
            canvasParser: nonOptionalCanvasParser,
            endpoint: endpoint
        )
        return dependencyContainer.makeMainViewController(shouldHideNavBar: !showNavigationBar)
    }
}
