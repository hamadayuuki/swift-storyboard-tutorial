//
//  ViewController.swift
//  Combine_3
//
//  Created by 濵田　悠樹 on 2022/02/16.
//

import UIKit
import Combine

/*
public let label = UILabel()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIの作成
        label.frame = CGRect(x: 100, y: 100, width: 280, height: 20)
        label.textColor = .black
        label.text = "initial text"
        self.view.addSubview(label)   // View に文字列を追加
        
        let receiver = Receiver()
        receiver.load()
    }


}

// ユーザーID と パスワード の入力
final class Account {
    private(set) var userId = ""
    private(set) var password = ""
    @Published private(set) var isValid = false
    
    func update(userId: String, password: String) {
        self.userId = userId
        self.password = password
        isValid = (userId.count >= 4) && (password.count >= 4)   // boolean
        
    }
}

// 渡された値の表示, 受け取り
final class SomeObject {
    var value: Bool = false {
        didSet {
            print("isValid: \(value)")
            /*
             isValid: false   // 初期状態
             isValid: true   // 値がセットされて状態が変化した時に通知された, load() が呼ばれた後
             */
        }
    }
}

// 値を渡す, 仲介役
final class Receiver {
    private var subscriptions = Set<AnyCancellable>()   // subscription の初期化
    private let object = SomeObject()
    private let account = Account()
    
    init() {
        // isValid の状態を監視し,変化があると SomeObject() に渡す
        account.$isValid
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
        
        // 描画する文字列を変更
        account.$isValid
            .map { "isValid: \($0)"}
            .assign(to: \.text, on: label)   // UIの更新
            .store(in: &subscriptions)
    }
    
    // ユーザーID と パスワード の値渡し
    func load() {
        account.update(userId: "hoge", password: "pass")
    }
}
 */

public let label = UILabel()

// 描画のみを担当
/*
 View の役割
 MVC
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIの作成
        label.frame = CGRect(x: 100, y: 100, width: 280, height: 20)
        label.textColor = .black
        label.text = "initial text"
        self.view.addSubview(label)   // View に文字列を追加
        
        let receiver = Receiver()
        //receiver.load()
        receiver.updateView()
    }


}

/*
 Controller の役割
 MVC
 */
final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ViewModel()
    
    init() {
        // Model から値を取得して, Viewに渡す
        /*
        viewModel.labelText
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
         */
        
        viewModel.$articles
            .sink { articles in
                print(type(of: articles))
                print("articles: \(articles)")
                for article in articles {
                    label.text = article.id   // 処理が終わるまで描画されない
                }
            }
            .store(in: &subscriptions)
    }
    
    /*
    func load() {
        viewModel.load()
    }
     */
    
    func updateView() {
        viewModel.fetch()   // データ取得, Publisher を作成
    }
}

// ユーザーID と パスワード の入力
final class Account {
    private(set) var userId = ""
    private(set) var password = ""
    @Published private(set) var isValid = false
    
    func update(userId: String, password: String) {
        self.userId = userId
        self.password = password
        isValid = (userId.count >= 4) && (password.count >= 4)   // boolean
        
    }
}

