import UIKit

extension NewsListController {
    public class NewsCell: UITableViewCell {
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: NewsCell.self)
        
        private lazy var title: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.italicSystemFont(ofSize: 19)
            label.numberOfLines = 0
            
            label.text = "init(coder:) has not been implemented"
            
            return label
        }()
        
        private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 12)
            
            label.text = "\(Date())"
            
            return label
        }()
        
        private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.spacing = 2
            stackView.axis = .vertical
            [
                title,
                dateLabel,
            ].forEach(stackView.addArrangedSubview)
            
            return stackView
        }()
    }
}

extension NewsListController.NewsCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        selectionStyle = .none
    }
    
    func addSubviews() {
        addSubview(stackView)
    }
    
    func constraintSubviews() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

extension NewsListController.NewsCell {
    func setupCell(with news: Item) {
        title.text = news.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = formatter.date(from: news.pubDate)
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        dateLabel.text = formatter.string(from: date ?? Date())
    }
}
