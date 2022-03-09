//
//  RxDataSourcesViewontroller.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/09.
//

import UIKit
import RxSwift
import RxDataSources

// TableView の作成
class RxDataSourcesViewontroller: UIViewController {
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    let contents = ["あいうえお", "かきくけこ", "さしすせそ", "たちつてと", "なにぬねの", "はひふへほ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "productCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
                           
    }
}

// セルの作成
class tableViewCell: UITableViewCell{
    static let nameLabelFrame = CGRect(x: 10, y: 10, width: 300, height: 0)
    let nameLabel = UILabel(frame: tableViewCell.nameLabelFrame)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(nameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Delegate
extension RxDataSourcesViewontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! tableViewCell
        cell.nameLabel.text = contents[indexPath.row]
        cell.nameLabel.sizeToFit()
        return cell
    }
}
