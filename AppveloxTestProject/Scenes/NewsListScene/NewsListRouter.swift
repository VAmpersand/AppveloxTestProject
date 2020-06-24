import AlamofireRSSParser

final class NewsListRouter: BaseRouter {
    
    // weaver: newsInfoScene = NewsInfoScene
    // weaver: newsInfoScene.scope = .transient
    
    private let dependencies: NewsListRouterDependencyResolver
    
    init(injecting dependencies: NewsListRouterDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - NewsListRouterProtocol
extension NewsListRouter: NewsListRouterProtocol {
    func presentNewsInfoScene(with news: RSSFeed) {
        let newsInfoScene = dependencies.newsInfoScene(parentRouter: self,
                                                       news: news)
        present(newsInfoScene, using: PopoverPresentation())
    }

}
