import UIKit

extension NewsListController {
    public class CategoriesView: UIView {
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupSelf()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var categories: [String] = [] {
            didSet {
                categories.insert("Все категории", at: 0)
            }
        }
        
        private lazy var categoriyViews: [CategoryView] = {
            var views: [CategoryView] = []
            categories.forEach {
                let view = CategoryView(category: $0)
                views.append(view)
            }
            
            return views
        }()
        
        private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.spacing = 20
            stackView.axis = .vertical
            categoriyViews.forEach(stackView.addArrangedSubview)
            
                        
            return stackView
        }()
        
        private lazy var leftSwipe: UISwipeGestureRecognizer = {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(moveOut))
            swipe.direction = .left
            
            return swipe
        }()
    }
}

extension NewsListController.CategoriesView {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        addGestureRecognizer(leftSwipe)
    }
    
    func addSubviews() {
        addSubview(stackView)
    }
    
    func constraintSubviews() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
            make.left.right.equalToSuperview().inset(10)
        }
    }
}

extension NewsListController.CategoriesView {
    func setupCategoties(_ categories: [String]) {
        self.categories = categories
    }
}

extension NewsListController.CategoriesView {
  
}

extension NewsListController.CategoriesView {
    func moveIn() {
        UIView.animate(withDuration: 0.4) {
            self.frame.origin.x = UIScreen.main.bounds.origin.x - 20
        }
    }
    
    @objc func moveOut() {
        UIView.animate(withDuration: 0.4) {
            self.frame.origin.x = UIScreen.main.bounds.origin.x - self.frame.width
        }
    }
}
