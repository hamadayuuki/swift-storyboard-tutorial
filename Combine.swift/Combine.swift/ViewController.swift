//
//  ViewController.swift
//  Combine.swift
//
//  Created by 濵田　悠樹 on 2022/01/20.
//

import UIKit
import Foundation
import Combine

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 【第1回目】
        // Combine パブリッシャー(Just) を用いた基本的な使い方
        /*
        // ① : パブリッシャーの作成
        let publisher = Just(100)
        
        // ② : サブスクライバーの作成
        let subscriber = Subscribers.Sink<Int, Never>(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("実行完了")
            case .failure:
                print("エラー")
            }
            
        }, receiveValue: { value in
            print("取得結果")
            print(value)
        })
        
        // ③ : パブリッシャーとサブスクライバーをサブスクライブする
        publisher.subscribe(subscriber)
        */
        
        // 【第2回目】
        // オペレータの使い方
        /*
        // オペレータに使用するインスタンスを作成
        var taroTest = Test(personName: "Taro", score: 50)
        
        // ①,②,③: taroTest の score を パブリッシャーから得られた値に変更する
        //          cancellabele は、インスタンスの値を変更するだけの機能
        //let cancellable = Just(100).assign(to: \.score, on: taroTest)   // 1回目と同じ
        
        // ①,②,③,④ : オペレータを使用した場合
        let cancellable = Just(100)
            // オペレーター
            .map({ value in
                return Int(value)
            })
            // (再) サブスクライバー
            .assign(to: \.score, on: taroTest)
        
        print(taroTest.score)
        */
        
        // 【第3回目】
        // NotificationCenter と Combine を組み合わせて、イベント通知された値を扱う
        /*
        // オペレータに使用するインスタンスを作成
        var taroTest = Test(personName: "Taro", score: 50)
        
        // パブリッシャー : 値を発行する
        // 今回は Notification の通知を使い値を受け取る
        let cancelable = NotificationCenter.default.publisher(for: .notifyName, object: nil)
            // オペレーター : パブリッシャーから受け取ったデータを整形する
            .map({ notifyName in
                // Notification の通知から値を受け取り
                return notifyName.userInfo?["result"] as? Int ?? 0
            })
            // サブスクライバー : 値を受け取る, 受け取って何か行う.今回では .assign を使ってデータの代入
            .assign(to: \.score, on: taroTest)
        
        // Notificationの通知によって渡された 50 が表示される
        print(taroTest.score)   // 50
        
        // 通知を送る
        NotificationCenter.default.post(name: .notifyName, object: nil, userInfo: ["result" : 90])
        */
        
        // 【第4回目】
        // ? GithubAPIからのデータ取得をどう実装すれば良いのかわかっていない
        var decoder = JSONDecoder()

        let url = URL(string: "https://pythonchannel.com/media/codecamp/201902/JSON-Sample1.json")!
        
        var request = URLRequest(url: url)
                
        let cancelable = URLSession.shared.dataTaskPublisher(for: request)
            .map( { (data, response) in
                return data
            })
            .decode(type: GithubAPI.self, decoder: decoder)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("実行完了")
                case .failure(let error):
                    print("エラー")
                    print(error)
                }
                print("completion")
            },receiveValue: { value in
                print("value")
                print(value)
            })
        
    }
    
}


// 【第2,3回目】
class Test {
    
    var personName: String
    var score: Int
    init(personName: String, score: Int) {
        self.personName = personName
        self.score = score
    }
}

// 【第3回目】
// Notification の名前づけ
extension Notification.Name {
    static let notifyName = Notification.Name("notifyName")
}

// 【第4回目】
struct GithubAPI: Codable {
    //var title: String
    var total_count: Int
    var items: [ItemModel]
}
struct ItemModel: Codable {
    var url: String
}
