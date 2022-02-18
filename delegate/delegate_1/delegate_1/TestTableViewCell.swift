//
//  TestTableViewCell.swift
//  delegate_1
//
//  Created by 濵田　悠樹 on 2022/02/18.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    @IBAction func screenTransistionButton(_ sender: Any) {
        print("screenTransistionButton")
    }
    
    // nibからの読み込みが完全に終わった時に呼び出されるので、値設定以外の初期化処理などはこの段階で行うのが良さそう
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
