//
//  ViewController.swift
//  UITableView-tutorial
//
//  Created by 濵田　悠樹 on 2022/01/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let weeksName = ["月", "火", "水", "木", "金", "土", "日"]

    // 描画するセルの数
    // Fix を押すと自動で追加される①
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return weeksName.count   // 7

    }

    // 描画するセルを生成する
    // Fix を押すと自動で追加される②
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // セルを作成, Identifier が "Cell" となっているセルを呼び出す
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weeksName[indexPath.row]   // 表示する文字列
        return cell

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

