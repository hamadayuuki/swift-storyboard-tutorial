//
//  ViewController.swift
//  delegate_1
//
//  Created by 濵田　悠樹 on 2022/02/18.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "cellId"

    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testTableView.backgroundColor = .red
        
        // delegate の設定
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.tableFooterView = UIView()   // 作成したセルより下のセルを非表示
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5   // セルの数
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = testTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell   // 描画するセル
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100   // セルの高さ
    }
    
    
}

