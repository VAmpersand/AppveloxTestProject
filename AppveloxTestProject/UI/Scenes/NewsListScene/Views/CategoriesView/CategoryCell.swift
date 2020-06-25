import UIKit

extension NewsListController {
    public final class CategoryCell: UITableViewCell {
        public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: CategoryCell.self)
        
        public lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)

            return label
        }()
    }
}

private extension NewsListController.CategoryCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        selectionStyle = .none
        backgroundColor = .clear
    }

    func addSubviews() {
        addSubview(label)
    }

    func constraintSubviews() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
