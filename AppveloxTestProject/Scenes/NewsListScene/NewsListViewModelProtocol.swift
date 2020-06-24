public protocol NewsListViewModelProtocol: class {
    func updateNewsList() 
    func presentNewsInfoScene(with news: News)
}
