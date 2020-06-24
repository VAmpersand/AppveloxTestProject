import AlamofireRSSParser

protocol NewsListRouterProtocol {
    func presentNewsInfoScene(with news: RSSFeed)
}
