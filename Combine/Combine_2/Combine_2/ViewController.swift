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
        
        // イベントの受け取り
        let subscription = subject
            .sink(receiveCompletion: { completion in
                print("Receive Completion : ", completion)
            }, receiveValue:{ value in
                print("Receive Value : ", value)
            })
        
        // イベントの送信
        subject.send("あ")
        subject.send("い")
        subject.send("う")
        subject.send("え")
        subject.send("お")
        subject.send(completion: .finished)   // イベント終了を送信
        
    }


}

