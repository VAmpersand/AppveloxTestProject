import Foundation

public struct News {
    let title: String
    let pubDate: String
    let fullText: String
    let category: String
    let imageURL: String?
    
    init(title: String,
         pubDate: String,
         fullText: String,
         category: String,
         imageURL: String?) {
        self.title = title
        self.pubDate = pubDate
        self.fullText = fullText
        self.category = category
        self.imageURL = imageURL
    }
}
