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
        
        public static let cellID = String(describing: HeaderCell.self)
        
        private lazy var searchField: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.delegate = self
            
            return searchBar
        }()
    }
}

extension NewsListController.HeaderCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }
    
    func addSubviews() {
        addSubview(searchField)
    }
    
    func constraintSubviews() {
        searchField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1)
        }
    }
}

extension NewsListController.HeaderCell: UISearchBarDelegate {

}
