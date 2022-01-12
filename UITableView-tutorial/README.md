# 目的
Swift + storyboard での開発を経験したい。
UITableView の実装を経験したい。


# 流れ
1. プロジェクト作成
2. storyboard の作成
3. TableView の配置
4. TableView の接続
5. TableViewCell の作成
6. ViewController.swift の作成
7. 実行・確認


# 1. プロジェクト作成

<img width = 600 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/e9eae6f7-f43b-b7f6-a1e2-a57aca606294.png">
<img width = 350 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/444a8790-23c5-0040-b804-1a8c518e007a.png">


# 2. storyboard の作成

画面左側の Main.storyboard を選択

画面右上にある 「+」 を押す

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/2f1775eb-80d2-0bb0-eebd-855b07c02bce.png">


# 3. TableView の配置

検索タブに 「UITable」 と、打ち込む

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/de41901f-9201-8d56-cec9-a484eb2d672e.png">

「UITableView」 を、スマホ画面まで ドラッグ&ドロップ

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/6a3d289e-cc98-9e6f-89ce-6d75d4b54b10.png">

UITableView を画面いっぱいに引き伸ばす( =上下左右の余白を 0 にする → 「add Constraints」 をクリック )

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/f8928350-1e3b-b6f6-8db5-990668b09073.png">

下図のように、UITableView が画面いっぱいに広がっていれば、UITableViewの作成は完了

<img width = 350 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/5de6821c-7e75-bad1-1298-dc2e516ece05.png">


下図の赤丸部分を押す

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/370b24e0-abfe-1253-9114-55efb4eb65ce.png">


# 4. TableView の接続

接続を行う。 赤矢印のように、ドラッグ&ドロップ を行う。
`「data Source」 と　「View Controller」`
`「delegate」 と　「View Controller」`


<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/989a14f6-517f-faf7-2d9c-d30d6c4b09d7.png">

接続後、接続状況を確認

<img width = 350 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/87d2dcc0-9e2c-7fa5-9527-d1c7e0b071e1.png">


# 5. TableViewCell の作成

3. TableView の配置 を参考に、「TableViewCell」 を下図のように配置する

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/bd3786fe-394b-6ae8-4220-369c2d335f7c.png">


TableViewCell の 「Identifier」 を 「Cell」 にする

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/d93e982f-cc9a-68cb-a79d-6440514dc76d.png">


# 6. ViewController.swift の作成

ViewController.swift にプログラムを追加していく

TabView の 「dataScore」 「delegate」 を ViewContoroller に継承する

```ViewController.swift
import UIKit

// UITableViewDelegate, UITableViewDataSource を追加
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
```

エラーが発生する。

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/d4a32b13-6576-47de-536b-193ff7632bf0.png">

エラーの詳細を確認し、「Fix」を押す

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/27f6ccfa-eb3d-10b1-daf0-9ceff65e06f0.png">

押すと、以下のように ①と② が追加される
また、  `let weeksName = ["月", "火", "水", "木", "金", "土", "日"]` を追加する

```ViewController.swift
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let weeksName = ["月", "火", "水", "木", "金", "土", "日"]

    // ①: Fix を押すと自動で追加される
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    // ②: Fix を押すと自動で追加される
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
```

①,② の説明 と, プログラムの追加

```①.swift
// 描画するセルの数

// ①: Fix を押すと自動で追加される
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return weeksName.count   // 7

}
```

```②.swift
// 描画するセルを生成する

// ②: Fix を押すと自動で追加される
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // セルを作成, Identifier が "Cell" となっているセルを呼び出す
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)   
    cell.textLabel?.text = weeksName[indexPath.row]   // 表示する文字列
    return cell

}
```

完成したプログラム

```ViewController.swift
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let weeksName = ["月", "火", "水", "木", "金", "土", "日"]
    
    // Fix を押すと自動で追加される①
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weeksName.count   // 7
        
    }
    
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
```

# 7. 実行・確認

Main.storyboard への TableView, TableViewCell の配置

ViewController.swift へのプログラム追加 

が完了したら、次は実行を行う。

実行機(iPhone) を選択する。
今回は iPhone12mini を選択。

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/6f852652-8c69-ac28-6ec2-59d2ca8bf430.png">

<img width = 350 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/2f1b964d-e70a-c500-6e5f-133993c7ccce.png">

画面左上の 「◀︎」 を押して、プログラムを実行する

<img width = 500 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/cf27090e-1e3d-2fd6-afcb-7c4e13e3e7a6.png">


実行結果を確認。
予想通りの実行結果が得られた。

<img width = 350 src = "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/764557/ad26693f-df96-dbbf-54d5-8899d704bcf5.png">


# 参考文献

https://tech.playground.style/swift/tableview-list-fastest-beginner/

https://weblabo.oscasierra.net/swift-uitableview-1/

https://qiita.com/senseiswift/items/9b5476531a843b0e314a







