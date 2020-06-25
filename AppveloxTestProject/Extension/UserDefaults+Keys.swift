import UIKit

extension UserDefaults {
    static var selectCategory: String {
        get {
            return UserDefaults.standard.string(forKey: "selectCategory") ?? Texts.NewsList.defaultCategory
        } set {
            UserDefaults.standard.set(newValue, forKey: "selectCategory")
        }
    }
}
