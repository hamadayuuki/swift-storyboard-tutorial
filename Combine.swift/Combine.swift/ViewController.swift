//
//  ViewController.swift
//  Combine.swift
//
//  Created by 濵田　悠樹 on 2022/01/20.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 基本的な使い
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
        
    }
    
}
