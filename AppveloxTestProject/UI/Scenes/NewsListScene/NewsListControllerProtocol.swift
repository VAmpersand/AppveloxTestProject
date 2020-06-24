import AlamofireRSSParser

public protocol NewsListControllerProtocol: class {
    func setupNewsList(_ newsList: RSSFeed)
}

