//
//  HTTPClient.swift
//
//
//  Created by Franco Risma on 08/05/2024.
//

import Foundation
import UIKit

public protocol HTTPClientServiceFactory {
    func makeHTTPClientService() -> HTTPClient
}

public protocol HTTPClient {
    func requestData(path: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

struct FakeHTTPClient: HTTPClient {
    func requestData(path: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
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
                 "tile_type":"carousel_card",
                 "should_show_count": false,
                 "images":[
                    {
                       "icon_url":"https://cdn.arstechnica.net/wp-content/uploads/2023/07/inside-the-ars-vault.jpg",
                       "footer_text":"ARS Technica",
                       "footer_color":"orange"
                    },
                    {
                       "icon_url":"https://cdn.icon-icons.com/icons2/2699/PNG/512/techcrunch_logo_icon_170625.png",
                       "footer_text":"Tech Crunch",
                       "footer_color":"green"
                    },
                    {
                       "icon_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtOvyiNZuZAho9gWQ3I5AkLTd-Y8lbej-gCQpzqbkGAkueX42xVm6BTTMC5rUqZ6YTn-E&usqp=CAU",
                       "footer_text":"Hacker News",
                       "footer_color":"orange"
                    },
                    {
                       "icon_url":"https://computercity.com/wp-content/uploads/1_jfdwtvU6V6g99q3G7gq7dQ1.png",
                       "footer_text":"Medium",
                       "footer_color":"orange"
                    },
                    {
                       "icon_url":"https://www.puromarketing.com/uploads/img/contents/2023/2BYzTptdVO7vJ1EyI8hu/2BYzTptdVO7vJ1EyI8hu_post_imagen_top_content.webp",
                       "footer_text":"Reddit",
                       "footer_color":"orange"
                    },
                    {
                       "icon_url":"https://www.zdnet.com/a/img/resize/fc7b8d4b1f4b34862881ebf41dec855600480098/2022/08/01/71433421-11f6-4ee9-97d5-3249e8457842/stack-overflow-logo-crop-for-twitter.jpg?auto=webp&width=1280",
                       "footer_text":"StackOverflow",
                       "footer_color":"orange"
                    }
                 ]
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
              },
              {
                 "tile_type":"identity_card",
                 "profile_image_url":"https://media.licdn.com/dms/image/D4D03AQEwxssgqnULoQ/profile-displayphoto-shrink_400_400/0/1681695300111?e=2147483647&v=beta&t=VhVrgUf8RpNbW70aIbF-AmLP3mAn0dnqZZT88DDUI50",
                 "full_name":"Lorena Yacachury",
                 "birth_date":"23/12/1980 AC",
                 "notes":"En El Jardín Infinito MEC, estamos emocionadas por contar con speakers de renombre que nos brindarán una visión profunda sobre las tendencias más fascinantes en el mundo de la tecnología web3."
              }
           ]
        }
        """
    }
}
