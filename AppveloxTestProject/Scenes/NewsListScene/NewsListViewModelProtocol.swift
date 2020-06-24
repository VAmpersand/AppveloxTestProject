import AlamofireRSSParser

public protocol NewsListViewModelProtocol: class {
    func updateNewsList() 
    func presentNewsInfoScene(with news: RSSFeed)
}
