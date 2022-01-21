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
    }
    
}


// 【第2回目】
/*
class Test {
    
    var personName: String
    var score: Int
    init(personName: String, score: Int) {
        self.personName = personName
        self.score = score
    }
}
*/
