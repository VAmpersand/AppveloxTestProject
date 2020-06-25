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
                categories.insert(Texts.NewsList.defaultCategory, at: 0)
            }
        }
        
        public lazy var categoriyViews: UITableView = {
            let table = UITableView()
            table.register(CategoryCell.self,
                           forCellReuseIdentifier: CategoryCell.cellID)
            table.delegate = self
            table.dataSource = self
            table.showsVerticalScrollIndicator = false
            table.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            table.separatorStyle = .none
            
            return table
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
        addSubview(categoriyViews)
    }
    
    func constraintSubviews() {
        categoriyViews.snp.makeConstraints { make in
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

//MARK:- UITableViewDelegate
extension NewsListController.CategoriesView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .selectCategory,
                                        object: categories[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//MARK:- UITableViewDataSource
extension NewsListController.CategoriesView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListController.CategoryCell.cellID,
                                                 for: indexPath) as! NewsListController.CategoryCell
        cell.label.text = categories[indexPath.row]
        
        return cell
    }
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
