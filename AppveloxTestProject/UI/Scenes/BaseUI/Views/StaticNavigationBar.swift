import UIKit

public final class StaticNavigationBar: UIView {
    init(title: String,
         leftButtonImage: UIImage? = nil,
         leftAction: (() -> Void)? = nil,
         rightButtonImage: UIImage? = nil,
         rightAction: (() -> Void)? = nil) {
        super.init(frame: .zero)

        setupSelf()
        self.title = title
        self.leftAction = leftAction
        self.rightAction = rightAction

        if let leftButtonImage = leftButtonImage, let leftAction = leftAction {
            addLeftButton(with: leftButtonImage, action: leftAction)
        }

        if let rightButtonImage = rightButtonImage, let rightAction = rightAction {
            addRightButton(with: rightButtonImage, action: rightAction)
        }
    }

    private var leftAction: (() -> Void)?
    private var rightAction: (() -> Void)?

    var leftButton: UIButton?
    var rightButton: UIButton?

    public var textAligment: NSTextAlignment {
        get {
            return titleLabel.textAlignment
        } set {
            titleLabel.textAlignment = newValue
        }
    }

    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get {
            return titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()
}

public extension StaticNavigationBar {
    func setupSelf() {
        addSubview(titleLabel)

        constraintSubviews()
    }

    func addLeftButton(with image: UIImage, action: (() -> Void)) {
        let leftButton = UIButton(type: .system)
        leftButton.setImage(image, for: .normal)
        leftButton.addTarget(nil, action: #selector(handleLeftButton), for: .touchUpInside)

        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(titleLabel.snp.top)
        }
        self.leftButton = leftButton
    }

    func addRightButton(with image: UIImage, action: (() -> Void)) {
        let rightButton = UIButton(type: .system)
        rightButton.setImage(image, for: .normal)
        rightButton.addTarget(nil, action: #selector(handleRightButton), for: .touchUpInside)

        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(20)
        }
        self.rightButton = rightButton
    }

    @objc func handleLeftButton() {
        leftAction?()
    }

    @objc func handleRightButton() {
        rightAction?()
    }

    func constraintSubviews() {
        titleLabel.snp.makeConstraints {make in
            make.right.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(27)
        }
    }
}
