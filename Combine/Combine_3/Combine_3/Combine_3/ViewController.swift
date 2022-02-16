//
//  ViewController.swift
//  Combine_3
//
//  Created by 濵田　悠樹 on 2022/02/16.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    // ユーザーID と パスワード の値渡し
    func load() {
        account.update(userId: "hoge", password: "pass")
    }
}

