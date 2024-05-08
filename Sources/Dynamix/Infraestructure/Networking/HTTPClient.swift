//
//  HTTPClient.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation

public protocol HTTPClient {
    func requestData<T: Decodable>(path: String, completion: (Result<T, Error>) -> Void) -> Cancellable?
}
