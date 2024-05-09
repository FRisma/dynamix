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

struct FakeHTTPClient: HTTPClient {
    func requestData(path: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print("Dynamix - Requesting to \(path)")
            let data = String.mockedResponse.data(using: .utf8)!
            completion(.success(data))
//        }
        return nil
    }
}


private extension String {
    static var mockedResponse: Self {
        """
        {
            "identifier": "earnings-hub",
            "tiles":
            [
                {
                    "tile_type": "earnings_card",
                    "title": "Your earnings",
                    "subtitle": "This week you have generated $10 USD"
                },
                {
                    "tile_type": "earnings_rewards",
                    "currency_icon_url": "https://mobile-stageassets.bitso.com/assets/icon/usd@2x.png",
                    "currency": "usd",
                    "header_section":
                    {
                        "header_title": "Digital Dollars (USDC)",
                        "header_subtitle": "All-time earnings",
                        "header_amount": "630.38",
                        "header_currency": "USD"
                    },
                    "expandable_section":
                    {
                        "expandable_title": "Active in Earnings since",
                        "expandable_subtitle": "05/03/24",
                        "expandable_switch_text": "Earnings in USD:"
                    }
                },
                {
                    "tile_type": "earnings_rewards",
                    "currency_icon_url": "https://mobile-stageassets.bitso.com/assets/icon/usdt@2x.png",
                    "currency": "usdt",
                    "header_section":
                    {
                        "header_title": "Tether USD",
                        "header_subtitle": "All-time earnings",
                        "header_amount": "10.00",
                        "header_currency": "USDT"
                    },
                    "expandable_section":
                    {
                        "expandable_title": "Active in Earnings since",
                        "expandable_subtitle": "05/03/24",
                        "expandable_switch_text": "Earnings in USDT:"
                    }
                }
            ]
        }        
        """
    }
}
