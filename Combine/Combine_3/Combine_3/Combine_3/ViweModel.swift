//
//  ViweModel.swift
//  Combine_3
//
//  Created by 濵田　悠樹 on 2022/02/16.
//

/*
 Model の役割
 MVC
 */
import Combine

// publish される値を表示用の値に変換する
/*
final class ViewModel {
    let labelText: AnyPublisher<String?, Never>
    private let account = Account()
    
    init() {
        labelText = account.$isValid
            .map { "isValid: \($0)" }
            .eraseToAnyPublisher()
    }
    
    func load() {
        account.update(userId: "hoge", password: "pass")
    }
}
*/

struct Article {
    var id: String
    var title: String
    var content: String
}

final class ViewModel {
    @Published private(set) var articles: [Article] = []
    
    // データを取得する
    func fetch() {
        let fetchedArticles = (0..<10)
            .map {
                Article(id: "id: \($0)", title: "title: \($0)", content: "content: \($0)")
            }
        //print("fetchedArticles Type: \(type(of: fetchedArticles))")
        articles = fetchedArticles
    }
}
