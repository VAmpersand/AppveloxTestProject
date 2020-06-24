import UIKit

extension NewsListController {
    public final class CategoryView: UIView {
        init(category: String) {
            self.category = category
            super.init(frame: .zero)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var category: String {
            didSet {
                button.setTitle(category, for: .normal)
            }
        }
        var onTap: ((String) -> Void)?

        private lazy var button: UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)

            return button
        }()
    }
}

private extension NewsListController.CategoryView {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }

    func addSubviews() {
        addSubview(button)
    }

    func constraintSubviews() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK:-Action
private extension NewsListController.CategoryView {
    @objc private func handleButton() {
        NotificationCenter.default.post(name: .selectCategory, object: category)
    }
}
