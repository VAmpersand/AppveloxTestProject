import UIKit
import Alamofire
import SWXMLHash

final class NetworkService { }

//MARK: - Get
extension NetworkService {
    func loadRSS(complition: @escaping ([News]) -> Void) {
        let urlXml = "https://www.vesti.ru/vesti.rss/"
        var newsList: [News] = []
        
        AF.request(urlXml,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).response { responseData in
                    guard let data = responseData.data else {
                        return }
                    
                    let xml = SWXMLHash.parse(data)
                    xml["rss"]["channel"]["item"].all.forEach { item in
                        let title: String = try! item["title"].value()
                        let pubDate: String = try! item["pubDate"].value()
                        let fullText: String = try! item["yandex:full-text"].value()
                        let category: String = try! item["category"].value()
                        let imageURL: String? = item["enclosure"].element?.attribute(by: "url")?.text
                        
                        let news = News(
                            title: title,
                            pubDate: pubDate,
                            fullText: fullText,
                            category: category,
                            imageURL: imageURL
                        )
                        newsList.append(news)
                    }
                    complition(newsList)
        }
    }
}
