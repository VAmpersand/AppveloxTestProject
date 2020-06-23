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
        navigationBar = addStaticNavigationBar(StaticNavigationBar(title: "Test")).navigationBar
        navigationBar.textAligment = .center
        view.addSubview(newsTableView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - NewsListControllerProtocol
extension NewsListController: NewsListControllerProtocol {
    
}

// MARK: - Actions
extension NewsListController {
    
}

// MARK: - UITableViewDataSource
extension NewsListController: UITableViewDataSource {
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

// MARK: - UITableViewDelegate
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
        return HeaderCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentNewsInfoScene()
    }
}
