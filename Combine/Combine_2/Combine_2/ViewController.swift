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
import Foundation   // Timer, NotificationCenter, URLSession

// ===== ↓ Publisher =====
// イベントの送受信を仲介
// イベントは「文字列を渡して表示させる」というもの
public let subject = PassthroughSubject<String, Never>()   // <受信する型, 返信する型>

// イベントを送信する
// リストを Publisher に変更できる,
public let listPublisher = ["1", "2", "3", "4", "5"].publisher   // 型は Publishers.Sequence<[String], Never>

// タイマーを Publisher に変更
// Subscribeで .aoutconnect() を行う, Subscribe(sinkやassign)を行うため
public var timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)

// Notification を Publisher に変更
// post を実行して 通知を送信する必要あり
public let myNotification = Notification.Name("myNotification")
public var notificationPublisher = NotificationCenter.default.publisher(for: myNotification)

// URLSession を Publisher に変更
// Subscribe時は クラス外で定義した cancellable を使用する
public let url = URL(string: "https://api.github.com/search/repositories?q=swift+in:name&sort=stars")!
public let urlSessionPublisher = URLSession.shared.dataTaskPublisher(for: url)

// Publish(.send()) されるたびに状態を更新して保持する
public let currentSubject = CurrentValueSubject<String, Never>("A")
// Subject を Publisher として使用できる, Publisher(AnyPublisher型) に変換する
public let anyPublisher = currentSubject.eraseToAnyPublisher()

// 受信結果を保持し続けるために使用
public var cancellable: Cancellable?

// ===== Publisher =====

let sender = Sender()

let model = Model()

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
        
        // NotificationCenter の Publisher を実行する
        //NotificationCenter.default.post(Notification(name: myNotification))
        
        // Publish(.send()) されるたびに状態を更新して保持する
        /*
        currentSubject.send("あ")
        currentSubject.send("い")
        currentSubject.send("う")
        currentSubject.send("え")
        currentSubject.send("お")
        print("Current value : ", currentSubject.value)
         */
        
        // @Published プロパティが更新されると、その値を Publish する
        
        /*
        // sender の定義はグローバル変数として行う
        sender.event = "あ"
        sender.event = "い"
        sender.event = "う"
        sender.event = "え"
        sender.event = "お"
         */
        
        /*
        //let model = Model()   // → グローバル変数に変更
        model.value = "1"
        model.value = "2"
        model.value = "3"
        model.value = "4"
        model.value = "5"
         */
        
        /*
        model.value = 1
        model.value = 2
        model.value = 3
        model.value = 4
        model.value = 5
         */
        
        model.subject1.send("1")
        model.subject1.send("2")
        model.subject2.send("3")
        model.subject2.send("4")
        model.subject1.send("5")
    }
}

// 受け取り先を2つ作成
// final : 継承を禁止する
final class Receiver {
    // 受け取りを2つ用意
    //let subscription1: AnyCancellable
    //let subscription2: AnyCancellable
    var subscriptions = Set<AnyCancellable>()   // → 2つのsubscriptionを 1つにまとめるための subscription
    
    // let receiver = Receiver() で呼ばれる
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
        /*
        cancellable = timerPublisher
            .autoconnect()
            .sink { value in
                print(value)
            }
         */
        
        /*
        notificationPublisher
            .sink { value in
                print("Receive Value : ", value)
            }
            .store(in: &subscriptions)
        */
         
        // urlSession で得た結果を表示
        // 結果は (data: Data, response: URLResponse) で受け取る
        // 結果に含まれる情報(id, name, url など) を表示するには data を使用する
        /*
        cancellable = urlSessionPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("実行終了")
                case .failure(let error):
                    print("error : ", error)
                }
            }, receiveValue: { (data, response) in
                print("Recevied data : ", data)
                print("Recevied response : ", response)
            })
            //.store(in: &subscriptions)
         */
        
        /*
        currentSubject
            .sink { value in
                print("Received value : ", value)
            }
            .store(in: &subscriptions)
         */
        
        // eraseToAnyPublisher() によって Subject を Publisher として使用できる
        /*
        anyPublisher
            .sink { value in
                print("Received value : ", value)
            }
            .store(in: &subscriptions)
        print(type(of: currentSubject))   // CurrentValueSubject<String, Never>
        print(type(of: anyPublisher))   // AnyPublisher<String, Never>
         */
        
        /*
        // sender の定義はグローバル変数として行う
        sender.$event
            .sink { value in
                print("Received value : ", value)
            }
            .store(in: &subscriptions)
         */
        
        // Operator
        /*
        //let model = Model()   // → グローバル変数に変更
        let viewModel = ViewModel()
        // Controller(MVC) を担当, M(Model())のから受けた変更をV(ViewModel())に渡す
        model.$value
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
         */
        
        // map
        /*
        let viewModel = ViewModel()
        var formatter = NumberFormatter()   // Apple標準のメソッド, 数値の書式を変更する
        formatter.numberStyle = .spellOut   // 数値を日本語訳する
        
        model.$value
            // Publisher を 別のPublisher へ変更する
            .map { value in
                formatter.string(from: NSNumber(integerLiteral: value)) ?? ""
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
         */
        
        // filter
        /*
        let viewModel = ViewModel()
        var formatter = NumberFormatter()   // Apple標準のメソッド, 数値の書式を変更する
        formatter.numberStyle = .spellOut   // 数値を日本語訳する
        
        model.$value
            // 条件(偶数)に適合する値のみを通す
            .filter { value in
                value % 2 == 0
            }
            // Publisher を 別のPublisher へ変更する
            .map { value in
                formatter.string(from: NSNumber(integerLiteral: value)) ?? ""
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
        /*
         出力結果
         didSet text :  zero
         didSet text :  two
         didSet text :  four
         */
         */
        
        // compactMap
        /*
        let viewModel = ViewModel()
        var formatter = NumberFormatter()   // Apple標準のメソッド, 数値の書式を変更する
        formatter.numberStyle = .spellOut   // 数値を日本語訳する
        
        model.$value
            // map + 値が nil になった場合 Publish しない
            .compactMap { value in
                formatter.string(from: NSNumber(integerLiteral: value))
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
         */
        
        // combineLatest
        let viewModel = ViewModel()
        model.subject1
            // 2つのPublisher(subject1, subject2) から1つの Publisher を作る
            // 両方のPublisher から値を受け取った時点の状態を Publish する
            .combineLatest(model.subject2)
            .map { value1, value2 in
                "value1:" + value1 + " , value2:" + value2
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
        /*
         入力
         model.subject1.send("1")   // 1   // 1:"1", 2:    → ×
         model.subject1.send("2")   // 1   // 1:"2", 2:    → ×
         model.subject2.send("3")   // 2   // 1:"2", 2:"3" → ○
         model.subject2.send("4")   // 2
         model.subject1.send("5")   // 1
         
         出力結果
         didSet text :  value1:2 , value2:3
         didSet text :  value1:2 , value2:4
         didSet text :  value1:5 , value2:4
         */
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

// @Published を使用して、普通のプロパティから Publisher を生成する
// プロパティが更新されると、その値を Publish する
final class Sender {
    @Published var event: String = "A"
}

// Model(MVC) を担当
final class Model {
    //@Published var value: String = "0"
    // map
    @Published var value: Int = 0
    
    // combineLatest
    public let subject1 = PassthroughSubject<String, Never>()
    public let subject2 = PassthroughSubject<String, Never>()
}

// View(MVC) を担当
final class ViewModel {
    var text: String = "" {
        didSet {
            print("didSet text : ", text)
        }
    }
}
