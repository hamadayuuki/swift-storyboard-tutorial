//
//  ViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit   // レイアウト

class ViewController: UIViewController {
    
    // MARK: Cells
    let sampleTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.placeholder = "文字を入力してください"
        textField.backgroundColor = UIColor.yellow
        return textField
    }()
    
    var bindTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .green
        label.textColor = .black
        return label
    }()
    
    var subscribeTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .red
        label.textColor = .black
        return label
    }()

    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBinding()
        
        viewModel = ViewModel()
        
        // ■ 受け取りに使用する
        let helloWorldObservable = viewModel.helloWorldObservable   // ①: Subject の定義
        
        // ■ 受け取り口, 受け取りを"宣言"する
        helloWorldObservable   // ②: Subject を購読
            // ③: 流れてきたデータを表示
            .subscribe(onNext: { [weak self] message in
                print("massage: \(message)")
            })
            .disposed(by: disposeBag)
        
        // ■ 流す
        viewModel.updateItem()   // ④: イベントを流す
    }
    
    // SnapKit を使って画面を描画
    private func setupLayout() {
        view.backgroundColor = .blue
        view.addSubview(sampleTextField)
        view.addSubview(bindTextLabel)
        view.addSubview(subscribeTextLabel)
        
        sampleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        bindTextLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(sampleTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        subscribeTextLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(bindTextLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        // bind を使用
        sampleTextField.rx.text
            //     ↓変換前  ↓変換後
            .map { text -> String? in
                guard let text = text else { return nil }
                return "あと\(10 - text.count)文字"
            }
            .bind(to: bindTextLabel.rx.text)
            .disposed(by: disposeBag)
        
        // subscribe を使用
        sampleTextField.rx.text
            .subscribe(onNext: { [weak self] text in
                self?.subscribeTextLabel.text = text
            })
            .disposed(by: disposeBag)
    }


}

