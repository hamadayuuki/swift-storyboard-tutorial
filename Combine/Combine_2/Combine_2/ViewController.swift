//
//  ViewController.swift
//  Combine_2
//
//  Created by 濵田　悠樹 on 2022/02/06.
//

/*
 Combineの学習用
 
 ! Combineの実行結果が出ない時は、cancellable を クラス外に グローバル変数として定義して、Subscribe時に cancellable を使用する
   → 関数内で定義すると、関数を抜けた後、受信できなくなるから
 */

import UIKit
import Combine
import Foundation   // Timer

// イベントの送受信を仲介
// イベントは「文字列を渡して表示させる」というもの
public let subject = PassthroughSubject<String, Never>()   // <受信する型, 返信する型>

// イベントを送信する
// リストを Publisher に変更できる,
public let listPublisher = ["1", "2", "3", "4", "5"].publisher   // 型は Publishers.Sequence<[String], Never>

// タイマーを Publisher に変更
// Subscribeで .aoutconnect() を行う, Subscribe(sinkやassign)を行うため
public var timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)

// 受信結果を保持し続けるために使用
public var cancellable: Cancellable?

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
        
        
        /*
        // イベントの送信
        let receiver = Receiver()
        subject.send("あ")
        subject.send("い")
        //receiver.subscription1.cancel()   // subscription1 を中止する
        subject.send("う")
        subject.send("え")
        subject.send("お")
        subject.send(completion: .finished)   // イベント終了を送信
         */
        
        let receiver = Receiver()
        /*
        cancellable = Timer.publish(every: 1, on: .main, in: .default)
               .autoconnect()
               .sink(receiveValue: { value in
                   print(value)
               })
         */
        
    }
}

// 受け取り先を2つ作成
// final : 継承を禁止する
final class Receiver {
    // 受け取りを2つ用意
    //let subscription1: AnyCancellable
    //let subscription2: AnyCancellable
    var subscriptions = Set<AnyCancellable>()   // → 2つのsubscriptionを 1つにまとめるための subscription
    
    init() {
        /*
        // 1つ目の受け取り
        //subscription1 = subject
        // 1つのsubscriptionにまとめる場合は subjectを変数で保持する必要なし
        subject
            .sink{ value in
                print("[1] subscription : ", value)
            }
            .store(in: &subscriptions)   // 1つのsubscriptionにまとめる
        
        // 2つ目の受け取り
        //subscription2 = subject
        subject
            .sink{ value in
                print("[2] subscription : ", value)
            }
            .store(in: &subscriptions)   // 1つのsubscriptionにまとめる
         */
        
        /*
        // 受信結果をクラスの変数に代入する
        subject
            .assign(to: \.value, on: SomeObject())
            .store(in: &subscriptions)
         */
        
        /*
         publisher(リストをpublisherへ変換したもの) からの受信結果を表示
         subscribe(sink や assign) を行うと、型が　AnyCancellable型になる
         → sink や assign を使用できなくなる
           → 実行を役割毎に分けて、storeで一つの subscription にまとめる
         */
        /*
        listPublisher
            //.assign(to: \.value, on: SomeObject())
            .sink(receiveCompletion: { completion in
                print("Receive Completion : ", completion)
            }, receiveValue:{ value in
                print("Receive Value : ", value)
            })
            .store(in: &subscriptions)   // 1つの subscription にまとめる
        
        listPublisher
            .assign(to: \.value, on: SomeObject())
            .store(in: &subscriptions)   // 1つの subscription にまとめる
         */
        
        // クラス外に定義した cancellable を使用しないと、実行結果を確認できない
        /*
         listPublisher        :  Sequence<Array<String>, Never>(sequence: ["1", "2", "3", "4", "5"])
         listPublisher type   :  Sequence<Array<String>, Never>
         timerPublisher       :  (extension in Foundation):__C.NSTimer.TimerPublisher
         timerPublisher type  :  TimerPublisher
         → TimerPublisher は,他のPublisher とは 型が異なる.
         */
        cancellable = timerPublisher
            .autoconnect()
            .sink { value in
                print(value)
            }
        
    }
}

// 値が代入されるか確認するためにクラス
final class SomeObject {
    var value: String = "" {
        didSet {
            print("didSet value : ", value)
        }
    }
}
