import UIKit
import SnapKit
import AlamofireRSSParser

public final class NewsListController: BaseController {
    public var viewModel: NewsListViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    
    private var newsList: RSSFeed! {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    public lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellID)
        table.register(HeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: HeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.refreshControl = self.refreshControll
        
        return table
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self,
                           action: #selector(refreshControllHandle(sender:)),
                           for: .valueChanged)
        
        return controll
    }()
}

extension NewsListController {
    override func setupSelf() {
        super.setupSelf()
        viewModel.updateNewsList()
    }
    
    override func addSubviews() {
        super.addSubviews()
        navigationBar = addStaticNavigationBar(StaticNavigationBar(title: "NewsList")).navigationBar
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
    public func setupNewsList(_ newsList: RSSFeed) {
        self.newsList = newsList
    }
}

// MARK: - Actions
extension NewsListController {
    @objc func refreshControllHandle(sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel.updateNewsList()
    }
}

// MARK: - UITableViewDataSource
extension NewsListController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellID,
                                                 for: indexPath) as! NewsCell
        
        cell.setupCell(with: newsList[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsListController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
        viewModel.presentNewsInfoScene(with: newsList[indexPath.row])
    }
}
