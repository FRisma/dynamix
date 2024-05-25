import UIKit

public enum DynamixSDK {
    public static func makeDynamixViewController(
        endpoint: String
    ) -> UIViewController {
        
        let dc = DependencyContainer()
        let vc = dc.makeMainViewController()
        
        return vc
    }
}

struct EarningsRewardsTileParser: Parser {
    func parse(data: Any) throws -> Any {
        let jsonData = try JSONSerialization.data(withJSONObject: ParsingValidator.object(forData: data))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedTileModel = try decoder.decode(Model.self, from: jsonData)
        
        return EarningsRewardsTile(model: decodedTileModel)
    }
    
    struct Model: Decodable {
        let tileType: String
        let currencyIconUrl: URL
        let currency: String
        let headerSection: HeaderSection
        let expandableSection: ExpandableSection
        
        struct HeaderSection: Decodable {
            let headerTitle: String
            let headerSubtitle: String
            let headerAmount: String
            let headerCurrenct: String
        }
        
        struct ExpandableSection: Decodable {
            let expandableTitle: String
            let expandableSubtitle: String
            let expandableSwitchText: String
        }
    }
    
    final class EarningsRewardsTile: Tile {
        init(model: Model) {
            super.init(tileType: model.tileType)
            
            self.tileConfiguration = TileConfiguration(
                cellType: UICollectionViewCell.self,
                reuseIdentifier: model.tileType,
                cellConfiguration: { tile, cell, indexPath, viewController in
                    cell.backgroundColor = .systemBlue
                    
                    let customView = FancyTextView()
                    customView.translatesAutoresizingMaskIntoConstraints = false
                    customView.configure(with: "Lorena", subtitle: "Risma esta a punto de vender su camioneta por un monto de 25mil dolares lo cual no es tanto y la re concha de la lora")
                    cell.contentView.addSubview(customView)
                    NSLayoutConstraint.activate([
                        customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                        customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                        customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                        customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                    ])
                }
            )
        }
    }
}

struct EarningsCardTileParser: Parser {
    func parse(data: Any) throws -> Any {
        let jsonData = try JSONSerialization.data(withJSONObject: ParsingValidator.object(forData: data))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedTileModel = try decoder.decode(Model.self, from: jsonData)
        
        return EarningsCardTile(model: decodedTileModel)
    }
    
    struct Model: Decodable {
        let tileType: String
        let title: String
        let subtitle: String
    }
    
    final class EarningsCardTile: Tile {
        init(model: Model) {
            super.init(tileType: model.tileType)
            
            self.tileConfiguration = TileConfiguration(
                cellType: UICollectionViewCell.self,
                reuseIdentifier: model.tileType,
                cellConfiguration: { tile, cell, indexPath, viewController in
                    cell.backgroundColor = .red
                    
                    let customView = FancyTextView()
                    customView.translatesAutoresizingMaskIntoConstraints = false
                    customView.configure(with: "Franco", subtitle: "Risma esta a punto de vender su camioneta por un monto de 25mil dolares lo cual no es tanto y la re concha de la lora")
                    cell.contentView.addSubview(customView)
                    NSLayoutConstraint.activate([
                        customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                        customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                        customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                        customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                    ])
                }
            )
        }
    }
}


import UIKit

final class FancyTextView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.darkGray
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
