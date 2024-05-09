import UIKit

public enum DynamixSDK {
    public static func makeDynamixViewController() -> UIViewController {
        let repository = DefaultCanvasRepository(
            path: "/api/testing",
            service: FakeHTTPClient(),
            deserializer: JSONDeserializer(),
            parser: CanvasParser(tileRegister: DefaultTileParsersRegister()),
            tileRegister: DefaultTileParsersRegister()
        )
        
        
        repository.request { result in
            switch result {
            case .success(let canvas):
                print("Success")
            case .failure(let error):
                print("Error \(error)")
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        return viewController
    }
}
