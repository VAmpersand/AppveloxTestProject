import UIKit
import SnapKit

public final class NewsListController: BaseController {
    public var viewModel: NewsListViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    
    public lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellID)
        table.register(HeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: HeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
}


extension NewsListController {
    override func setupSelf() {
        super.setupSelf()
        
    }
    
    override func addSubviews() {
        super.addSubviews()
        navigationBar = addStaticNavigationBar("Test").navigationBar
        view.addSubview(newsTableView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - NewsListControllerProtocol
extension NewsListController: NewsListControllerProtocol {
    
}

// MARK: - Actions
extension NewsListController {
    
}

extension NewsListController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellID,
                                                 for: indexPath) as! NewsCell
        
        
        return cell
    }
}

extension NewsListController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView,
                          viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderCell()
        
        return header
    }
}
