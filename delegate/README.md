# delegate_1

# 目的
delegate とは何かを学ぶこと
具体例としてボタンを押した後の画面遷移プログラムを考える


# 実行結果
<img width = 300 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/41c64e92-8ed7-a718-d623-2f2f766f2a56.gif">


# プログラム
Github　のリポジトリを書いておきます。自由に見てください！


# delegate の利点
特定のView(=Button) では実装できない処理(=ViewControllerを使用する処理)を可能にする。
(例: ボタンを押した後の画面遷移 (=ViewController での処理, Button での処理ではない))


# 流れ
①: Protocol でメソッドを定義
②: メソッドの内容を記載
③: 画面遷移もとのView(=ボタン)にdelegate をセットする
④: 受け渡し先のView(=TableViewのセル)にdelegateを呼び出す


# ①: Protocol で宣言
ボタンを押したときに実行したい処理 に関するメソッドを宣言する。

```TestTableViewCell.swift
import UIkit

// ①: protocol を宣言
protocol TestTableViewCellDelegate {
    func tapedScreenTransitionButton()   // ボタンを押したときに実行したい処理
}

class TestTableViewCell: UITableViewCell {

    // UIButton の定義
    @IBAction func screenTransistionButton(_ sender: Any) {
        print("screenTransistionButton")
    }

    ・・・

}
```

### protocol とは？
`protocol`とは、規約である。
変数やメソッドを宣言することで protocol の定義が可能となる。
protocol で規約を作る → class が protocol を準拠する(protocolに書かれた変数やメソッドを実装する)

```exampleProtocol.swift
// !protocol は 変数 や メソッド の宣言のみを行う。
protocol exampleProtocol {
    var value1: String   // 変数
    func exampleFunction()   // メソッド
}
```


# ②: メソッドの内容を記載
① で作成した protocol に準拠し、処理を記載する。

```TestTableViewCell.swift
import UIkit

// ①: protocol を宣言
protocol TestTableViewCellDelegate {
    func tapedScreenTransitionButton()   // ボタンを押したときに実行したい処理
}

class TestTableViewCell: UITableViewCell {

    // UIButton の定義
    @IBAction func screenTransistionButton(_ sender: Any) {
        print("screenTransistionButton")
    }

    // ②: メソッドの内容を記載
    //                             👇 protocol を準拠している
    var testTableViewCellDelegate: TestTableViewCellDelegate?

    ・・・

}
```

```ViewController.swift
import UIkit

・・・

// TableView のセル の設定を行う
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    ・・・
}

// ②: メソッドの内容を記載    ↓ protocol を準拠
extension ViewController: TestTableViewCellDelegate {
    func tapedScreenTransitionButton() {
        print("ボタンが押されて、protocol のメソッドが呼び出されました")
        
        // 画面遷移を行う
        let secondViewController = SecondViewController()   // 画面遷移先のView
        navigationController?.pushViewController(secondViewController, animated: true)   // 画面遷移
    }
}
```


# ③: 画面遷移もとのView(=ボタン)にdelegate をセットする
今回は、ボタンを押すことで画面遷移を起こす。
そのため、画面遷移もとのView = ボタン と考え、delegate をセットする。

```TestTableViewCell.swift
import UIkit

// ①: protocol を宣言
protocol TestTableViewCellDelegate {
    func tapedScreenTransitionButton()   // ボタンを押したときに実行したい処理
}

class TestTableViewCell: UITableViewCell {

    // UIButton の定義
    @IBAction func screenTransistionButton(_ sender: Any) {
        print("screenTransistionButton")

        // ③: 画面遷移もとのView(=ボタン)にdelegate をセットする
        TestTableViewCellDelegate?.tapedScreenTransitionButton()
    }

    // ②: メソッドの内容を記載
    //                             👇 protocol を準拠している
    var testTableViewCellDelegate: TestTableViewCellDelegate?

    ・・・

}
```


# ④: 受け渡し先のView(=TableViewのセル)にdelegateを呼び出す
今回は、ボタンを押すことで画面遷移を起こす。
そのため、画面遷移もとのView = ボタン と考え、delegate をセットする。

```ViewController.swift
import UIkit

・・・

// TableView のセル の設定を行う
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5   // セルの数
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // ④: 受け渡し先のView(=TableViewのセル)にdelegateを呼び出す
        let cell = testTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TestTableViewCell
        cell.testTableViewCellDelegate = self   // delegate で使用するView (=セル(ボタンの親)) とする
        return cell   // 描画するセル
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100   // セルの高さ
    }

}
```


# 参考資料

https://youtu.be/QMC-64tUP8U

https://www.amazon.co.jp/iOSアプリ開発デザインパターン入門-技術書典シリーズ（NextPublishing）-千葉-大志-ebook/dp/B07DKT9YZX/ref=sr_1_2?__mk_ja_JP=カタカナ&crid=36RRMLESNLTRU&keywords=Swift+デザインパターン&qid=1645171220&s=digital-text&sprefix=swift+デザインパターン%2Cdigital-text%2C192&sr=1-2






