import UIKit

public enum Icons { }

// MARK: - NewsInfo
public extension Icons {
    enum NewsInfo {
        static var back: UIImage {
            image(named: "newsInfo_close")
        }
    }
}
extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
