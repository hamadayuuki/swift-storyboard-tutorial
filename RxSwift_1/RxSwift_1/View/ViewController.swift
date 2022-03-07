//
//  ViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/07.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        
        viewModel = ViewModel()
        
        // ■ 受け取りに使用する
        let helloWorldObservable = viewModel.helloWorldObservable   // ①: Subject の定義
        
        // ■ 受け取る, 受け取りを"宣言"する
        helloWorldObservable   // ②: Subject を購読
            // ③: 流れてきたデータを表示
            .subscribe(onNext: { [weak self] message in
                print("massage: \(message)")
            })
            .disposed(by: disposeBag)
        
        // ■ 流す
        viewModel.updateItem()   // ④: イベントを流す
    }


}

