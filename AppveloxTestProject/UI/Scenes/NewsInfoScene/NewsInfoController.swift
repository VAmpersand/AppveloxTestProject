import UIKit
import SnapKit

public final class NewsInfoController: BaseController {
    public var viewModel: NewsInfoViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        
        return scrollView
    }()
    
    private var contentView = UIView()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        
        view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 19)
        label.numberOfLines = 0
        
        label.text = "init(coder:) has not been implemented"
        
        return label
    }()
    
    private lazy var articleView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        
        view.text = """
        Тестовое задание iOS

        Задание: реализовать простейшее приложение для чтения новостей по RSS.
        Описание: необходимое реализовать простое приложение для чтения новостей по RSS (для примера возьмите канал http://www.vesti.ru/vesti.rss). Приложение должно состоять из двух экранов:
        Основной экран со списком всех новостей - для каждой новости в списке показываем дату+время и заголовок, поля title и pubDate, должен поддерживаться pull to refresh для подгрузки новых новостей. По тапу на элемент списка переходим на экран конкретной новости. В списке новостей предусмотреть возможность фильтрации новостей по категориям.
        Экран с информацией о конкретной новости – здесь показываем выбранную новость полностью, показываем фото при наличии поля enclosure, под ним заголовок новости и полный контент новости из поля yandex:full-text. В топбаре необходимо разместить кнопку для возврата обратно к списку новостей.
        Результат задания направить в виде ссылки на открытый репозиторий в Github или Bitbucket.
        По каким-то вопросам, связанным с реализацией тех или иных функций данного приложения, можете принимать решения самостоятельно. В интерфейсе и пользовательском взаимодействии необходимо ориентироваться на гайдлайны компании Apple.
        В письме со ссылкой на результат необходимо предоставить обоснование выбора тех или иных технологий.

        Тестовое задание iOS

        Задание: реализовать простейшее приложение для чтения новостей по RSS.
        Описание: необходимое реализовать простое приложение для чтения новостей по RSS (для примера возьмите канал http://www.vesti.ru/vesti.rss). Приложение должно состоять из двух экранов:
        Основной экран со списком всех новостей - для каждой новости в списке показываем дату+время и заголовок, поля title и pubDate, должен поддерживаться pull to refresh для подгрузки новых новостей. По тапу на элемент списка переходим на экран конкретной новости. В списке новостей предусмотреть возможность фильтрации новостей по категориям.
        Экран с информацией о конкретной новости – здесь показываем выбранную новость полностью, показываем фото при наличии поля enclosure, под ним заголовок новости и полный контент новости из поля yandex:full-text. В топбаре необходимо разместить кнопку для возврата обратно к списку новостей.
        Результат задания направить в виде ссылки на открытый репозиторий в Github или Bitbucket.
        По каким-то вопросам, связанным с реализацией тех или иных функций данного приложения, можете принимать решения самостоятельно. В интерфейсе и пользовательском взаимодействии необходимо ориентироваться на гайдлайны компании Apple.
        В письме со ссылкой на результат необходимо предоставить обоснование выбора тех или иных технологий.
        Тестовое задание iOS

        Задание: реализовать простейшее приложение для чтения новостей по RSS.
        Описание: необходимое реализовать простое приложение для чтения новостей по RSS (для примера возьмите канал http://www.vesti.ru/vesti.rss). Приложение должно состоять из двух экранов:
        Основной экран со списком всех новостей - для каждой новости в списке показываем дату+время и заголовок, поля title и pubDate, должен поддерживаться pull to refresh для подгрузки новых новостей. По тапу на элемент списка переходим на экран конкретной новости. В списке новостей предусмотреть возможность фильтрации новостей по категориям.
        Экран с информацией о конкретной новости – здесь показываем выбранную новость полностью, показываем фото при наличии поля enclosure, под ним заголовок новости и полный контент новости из поля yandex:full-text. В топбаре необходимо разместить кнопку для возврата обратно к списку новостей.
        Результат задания направить в виде ссылки на открытый репозиторий в Github или Bitbucket.
        По каким-то вопросам, связанным с реализацией тех или иных функций данного приложения, можете принимать решения самостоятельно. В интерфейсе и пользовательском взаимодействии необходимо ориентироваться на гайдлайны компании Apple.
        В письме со ссылкой на результат необходимо предоставить обоснование выбора тех или иных технологий.

"""
    
        return view
    }()
}

extension NewsInfoController {
    override func setupSelf() {
        super.setupSelf()
        let navigationBarTuple = addStaticNavigationBar(
            StaticNavigationBar(title: "NewsInfo",
                                rightButtonImage: Icons.NewsInfo.back,
                                rightAction: {
                                    self.viewModel.handleClose()
            })
        )
        navigationBar = navigationBarTuple.navigationBar
        navigationBar.textAligment = .center
        closeButton = navigationBarTuple.rightButton
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(newsTitle)
        contentView.addSubview(articleView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.top.bottom.equalToSuperview()
            make.right.left.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.6)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
        
        articleView.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp.bottom).offset(10)
            make.right.left.bottom.equalToSuperview().inset(15)
//            make.height.equalTo(1000)
        }
    }
}

// MARK: - NewsInfoControllerProtocol
extension NewsInfoController: NewsInfoControllerProtocol {
 
}

// MARK: - Actions
extension NewsInfoController {

}


private extension NewsInfoController{

}


