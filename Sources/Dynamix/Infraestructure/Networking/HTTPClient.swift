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
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print("Dynamix - Requesting to \(path)")
            let data = String.mockedResponse2.data(using: .utf8)!
            completion(.success(data))
        }
        return nil
    }
}


private extension String {
    static var mockedResponse: Self {
        """
        {
           "identifier":"expample-canvas",
           "tiles":[
                           {
                              "tile_type":"identity_card",
                              "profile_image_url":"https://thumbs.dreamstime.com/z/cartoon-wanted-poster-bandit-face-d-fat-cowboy-red-bandanna-hat-isolated-white-background-eps-file-available-you-35172594.jpg",
                              "full_name":"Satoshi Nakamoto",
                              "birth_date":"Unknown",
                              "notes":"The creator of Bitcoin... missing since 2008"
                           }
           ]
        }
        """
    }
    
    static var mockedResponse3: Self {
        """
        {
           "identifier":"expample-canvas",
           "tiles":[
              {
                 "tile_type":"card_article",
                 "title":"Revolutionizing iOS Development: The Rise of Backend-Driven UI",
                 "text":"In a significant shift for iOS development, the concept of backend-driven UI is transforming the way applications are built and maintained. Traditionally, iOS apps have relied heavily on front-end code to render user interfaces. However, with backend-driven UI, the focus is now on managing UI components and their state from the server side. This approach not only streamlines development processes but also enhances the user experience by enabling dynamic content updates and reducing the need for frequent app updates. As more developers adopt this methodology, the potential for creating more responsive, scalable, and user-centric applications is expanding rapidly, marking a new era in mobile app development."
              }
           ]
        }
        """
    }
    
    static var mockedResponse2: Self {
        """
        {
           "identifier":"expample-canvas",
           "tiles":[
              {
                 "tile_type":"identity_card",
                 "profile_image_url":"https://thumbs.dreamstime.com/z/cartoon-wanted-poster-bandit-face-d-fat-cowboy-red-bandanna-hat-isolated-white-background-eps-file-available-you-35172594.jpg",
                 "full_name":"Satoshi Nakamoto",
                 "birth_date":"Unknown",
                 "notes":"The creator of Bitcoin... missing since 2008"
              },
              {
                 "tile_type":"card_article",
                 "title":"Revolutionizing iOS Development: The Rise of Backend-Driven UI",
                 "text":"In a significant shift for iOS development, the concept of backend-driven UI is transforming the way applications are built and maintained. Traditionally, iOS apps have relied heavily on front-end code to render user interfaces. However, with backend-driven UI, the focus is now on managing UI components and their state from the server side. This approach not only streamlines development processes but also enhances the user experience by enabling dynamic content updates and reducing the need for frequent app updates. As more developers adopt this methodology, the potential for creating more responsive, scalable, and user-centric applications is expanding rapidly, marking a new era in mobile app development."
              },
              {
                 "tile_type":"card_article",
                 "title":"Bitcoin: The Future of Digital Currency or a Passing Fad?",
                 "text":"Bitcoin, the pioneering cryptocurrency, continues to stir debate and capture the imagination of investors, technologists, and regulators alike. Since its inception in 2009, Bitcoin has revolutionized the concept of digital currency, offering a decentralized, secure, and transparent way to conduct transactions without the need for traditional banking systems. Its volatile price swings have both exhilarated and alarmed the financial community, raising questions about its long-term viability and regulatory challenges. As mainstream adoption grows and technological advancements improve scalability and security, Bitcoin’s role in the future financial landscape remains a topic of intense scrutiny and speculation, promising both opportunities and risks for the global economy."
              },
                      {
                         "tile_type":"card_article",
                         "title":"Bitcoin: The Future of Digital Currency or a Passing Fad?",
                         "text":"Bitcoin, the pioneering cryptocurrency, continues to stir debate and capture the imagination of investors, technologists, and regulators alike. Since its inception in 2009, Bitcoin has revolutionized the concept of digital currency, offering a decentralized, secure, and transparent way to conduct transactions without the need for traditional banking systems. Its volatile price swings have both exhilarated and alarmed the financial community, raising questions about its long-term viability and regulatory challenges. As mainstream adoption grows and technological advancements improve scalability and security, Bitcoin’s role in the future financial landscape remains a topic of intense scrutiny and speculation, promising both opportunities and risks for the global economy. Y aca va de vuelta FRISMAAAAAAAAAAAAA Bitcoin, the pioneering cryptocurrency, continues to stir debate and capture the imagination of investors, technologists, and regulators alike. Since its inception in 2009, Bitcoin has revolutionized the concept of digital currency, offering a decentralized, secure, and transparent way to conduct transactions without the need for traditional banking systems. Its volatile price swings have both exhilarated and alarmed the financial community, raising questions about its long-term viability and regulatory challenges. As mainstream adoption grows and technological advancements improve scalability and security, Bitcoin’s role in the future financial landscape remains a topic of intense scrutiny and speculation, promising both opportunities and risks for the global economy."
                      },
                      {
                         "tile_type":"identity_card",
                         "profile_image_url":"https://thumbs.dreamstime.com/z/cartoon-wanted-poster-bandit-face-d-fat-cowboy-red-bandanna-hat-isolated-white-background-eps-file-available-you-35172594.jpg",
                         "full_name":"Satoshi Nakamoto",
                         "birth_date":"Unknown",
                         "notes":"The creator of Bitcoin... missing since 2008"
                      },
                      {
                         "tile_type":"card_article",
                         "title":"Bitcoin: The Future of Digital Currency or a Passing Fad?",
                         "text":"Bitcoin, the pioneering cryptocurrency, continues to stir debate and capture the imagination of investors, technologists, and regulators alike. Since its inception in 2009, Bitcoin has revolutionized the concept of digital currency, offering a decentralized, secure, and transparent way to conduct transactions without the need for traditional banking systems. Its volatile price swings have both exhilarated and alarmed the financial community, raising questions about its long-term viability and regulatory challenges. As mainstream adoption grows and technological advancements improve scalability and security, Bitcoin’s role in the future financial landscape remains a topic of intense scrutiny and speculation, promising both opportunities and risks for the global economy."
                      }
           ]
        }
        """
    }
}
