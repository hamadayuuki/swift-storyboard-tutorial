//
//  ViewController.swift
//  Combine_2
//
//  Created by 濵田　悠樹 on 2022/02/06.
//

/*
 Combineの学習用
 */

import UIKit
import Combine

// イベントの送受信を仲介
// イベントは「文字列を渡して表示させる」というもの
public let subject = PassthroughSubject<String, Never>()   // <受信する型, 返信する型>

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // イベントの受け取り
        let subscription = subject
            .sink(receiveCompletion: { completion in
                print("Receive Completion : ", completion)
            }, receiveValue:{ value in
                print("Receive Value : ", value)
            })
         */
        
        // イベントの送信
        let receiver = Receiver()
        subject.send("あ")
        subject.send("い")
        receiver.subscription1.cancel()   // subscription1 を中止する
        subject.send("う")
        subject.send("え")
        subject.send("お")
        subject.send(completion: .finished)   // イベント終了を送信
        
    }


}

// 受け取り先を2つ作成
// final : 継承を禁止する
final class Receiver {
    // 受け取りを2つ用意
    let subscription1: AnyCancellable
    let subscription2: AnyCancellable
    
    init() {
        // 1つ目の受け取り
        subscription1 = subject
            .sink{ value in
                print("[1] subscription : ", value)
            }
        
        // 2つ目の受け取り
        subscription2 = subject
            .sink{ value in
                print("[2] subscription : ", value)
            }
    }
}
