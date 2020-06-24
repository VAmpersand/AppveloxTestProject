import UIKit
import SnapKit
import Kingfisher

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
    
    private lazy var newsTitleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 19)
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    private lazy var articleView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
    
        return view
    }()
}

extension NewsInfoController {
    override func setupSelf() {
        super.setupSelf()
        viewModel.setupNews()
        
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
        contentView.addSubview(newsTitleContainer)
        newsTitleContainer.addSubview(newsTitle)
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
        
        newsTitleContainer.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(-20)
            make.right.equalToSuperview().inset(15)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.left.equalTo(imageView).offset(20)
        }
        
        articleView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleContainer.snp.bottom).offset(10)
            make.right.left.bottom.equalToSuperview().inset(15)
        }
    }
}

// MARK: - NewsInfoControllerProtocol
extension NewsInfoController: NewsInfoControllerProtocol {
    public func setupNews(_ news: News) {
        newsTitle.text = news.title
        articleView.text = news.fullText
        
        guard let imageURL = news.imageURL else {
            imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(0)
            }
            return
        }
        imageView.kf.setImage(with: URL(string: imageURL))
    }
}

