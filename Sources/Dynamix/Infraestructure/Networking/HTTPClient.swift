//
//  HTTPClient.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation
import UIKit

public protocol HTTPClient {
    func requestData(path: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
