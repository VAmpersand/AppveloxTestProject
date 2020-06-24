import UIKit

extension NewsListController {
    public class HeaderCell: UITableViewHeaderFooterView {
        override public init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        weak var delegate: HeaderCellDelegate?
        public static let cellID = String(describing: HeaderCell.self)
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            
            return view
        }()
        
        private lazy var catgoriesButton: UIButton = {
            let button = UIButton()
            button.setTitle("Категории", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self,
                             action: #selector(buttonPressed),
                             for: .touchUpInside)
            
            return button
        }()
    }
}

extension NewsListController.HeaderCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(catgoriesButton)
    }
    
    func constraintSubviews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        catgoriesButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}

private extension NewsListController.HeaderCell {
    @objc func buttonPressed() {
        delegate?.categoriesButtonPressed()
    }
}
