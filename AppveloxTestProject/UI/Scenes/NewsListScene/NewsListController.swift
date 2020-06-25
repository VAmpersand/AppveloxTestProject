import UIKit
import SnapKit

public final class NewsListController: BaseController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateNewsList()
        setupSelf()
    }
    
    public var viewModel: NewsListViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
        
    private var newsList: [News] = [] {
        didSet {
            filterNewsList()
            newsTableView.reloadData()
        }
    }
    
    private var sortedNewsList: [News] = [] 
 
    public lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellID)
        table.register(HeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: HeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.refreshControl = self.refreshControll
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self,
                           action: #selector(refreshControllHandle(sender:)),
                           for: .valueChanged)
        
        return controll
    }()
    
    private lazy var categoriesView = CategoriesView()
}

extension NewsListController {
    override func setupSelf() {
        super.setupSelf()
        addObserver()
    }
    
    override func addSubviews() {
        super.addSubviews()
        navigationBar = addStaticNavigationBar(StaticNavigationBar(title: Texts.NewsList.title)).navigationBar
        navigationBar.textAligment = .center
        view.addSubview(newsTableView)
        view.addSubview(categoriesView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        categoriesView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(60)
            make.right.equalTo(view.snp.left)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.bottom.equalToSuperview().inset(70)
        }
    }
}

// MARK: - NewsListControllerProtocol
extension NewsListController: NewsListControllerProtocol {
    public func setupNewsList(_ newsList: [News]) {
        self.newsList = newsList
    }
    
    public func updateCategoriesList(for newsList: [News]) {
        var categories: [String] = []
        newsList.forEach { news in
            if !categories.contains(news.category) {
                categories.append(news.category)
            }
        }
        
        categoriesView.setupCategoties(categories.sorted(by: <))
        categoriesView.categoriyViews.reloadData()
    }
}

// MARK: - Actions
extension NewsListController {
    @objc func refreshControllHandle(sender: UIRefreshControl) {
        categoriesView.moveOut()
        sender.endRefreshing()
        viewModel.updateNewsList()
    }
}

// MARK: - UITableViewDataSource
extension NewsListController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        return sortedNewsList.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellID,
                                                 for: indexPath) as! NewsCell
        
        cell.setupCell(with: sortedNewsList[indexPath.row])
        
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
        let cell = HeaderCell()
        cell.delegate = self
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoriesView.moveOut()
        viewModel.presentNewsInfoScene(with: sortedNewsList[indexPath.row])
    }
}

// MARK: - HeaderCellDelegate
extension NewsListController: HeaderCellDelegate {
    public func categoriesButtonPressed() {
        categoriesView.moveIn()
    }
}

extension NewsListController {
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectCategory(_:)),
                                               name: .selectCategory,
                                               object: nil)
    }
    
    @objc func selectCategory(_ notification: Notification) {
        guard let category = notification.object as? String else { return }
        UserDefaults.selectCategory = category
        filterNewsList()
        categoriesView.moveOut()
        newsTableView.reloadData()
    }
}

extension NewsListController {
     func filterNewsList() {
        if UserDefaults.selectCategory == Texts.NewsList.defaultCategory {
            sortedNewsList = newsList
        } else {
            sortedNewsList = newsList.filter() { $0.category == UserDefaults.selectCategory }
        }
    }
}
