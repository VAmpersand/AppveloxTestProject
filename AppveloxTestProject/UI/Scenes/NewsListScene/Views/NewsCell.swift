import UIKit

extension NewsListController {
    public class NewsCell: UITableViewCell {
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: NewsCell.self)
        
        private lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            
            return label
        }()
        
        private lazy var positionLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 12)
            
            return label
        }()
        
        private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.spacing = 2
            stackView.axis = .vertical
            [
                nameLabel,
                positionLabel
            ].forEach { stackView.addArrangedSubview($0) }
            
            return stackView
        }()
        
        public lazy var adminRightsView: UIView = {
            let button = UIView()
            button.backgroundColor = .green
            
            return button
        }()
    }
}

extension NewsListController.NewsCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        backgroundColor = .green
    }
    
    func addSubviews() {
        addSubview(stackView)
        addSubview(adminRightsView)
    }
    
    func constraintSubviews() {
        stackView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.right.equalTo(adminRightsView.snp.left).offset(-10)
        }
        
        adminRightsView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(adminRightsView.snp.height)
        }
    }
}

extension NewsListController.NewsCell {

}
