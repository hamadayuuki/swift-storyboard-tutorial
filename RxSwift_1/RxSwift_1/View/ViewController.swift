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
    
    let sampleTextLabel: UILabel = {
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
    
    // SnapKit を使って画面を描画
    private func setupLayout() {
        view.backgroundColor = .blue
        view.addSubview(sampleTextField)
        view.addSubview(sampleTextLabel)
        
        sampleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        sampleTextLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(sampleTextField.snp.bottom)
            make.topMargin.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }


}

