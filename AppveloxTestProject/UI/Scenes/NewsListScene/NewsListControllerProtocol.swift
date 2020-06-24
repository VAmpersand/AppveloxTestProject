public protocol NewsListControllerProtocol: class {
    func setupNewsList(_ newsList: [News])
    func updateCategoriesList(for newsList: [News])
}

