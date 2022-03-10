//
//  RxDataSourcesViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/09.
//

import UIKit
import RxSwift
import RxDataSources

// TableView の作成
class RxDataSourcesViewController: UIViewController {
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    let contents = ["あいうえお", "かきくけこ", "さしすせそ", "たちつてと", "なにぬねの", "はひふへほ"]
    private var viewModel: RxDataSourcesViewModel!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<RxDataSourcesModel>(configureCell: configureCell)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<RxDataSourcesModel>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, _) in
        
        let item = dataSource[indexPath]
        
        switch item {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accessoryType
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "text"
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "productCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
                           
    }
    
    private func setupViewController() {
        navigationItem.title = "設定"
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account: break
                case .security: break
                case .notification: break
                case .contents: break
                case .sounds: break
                case .dataUsing: break
                case .accessibility: break
                case .description: break
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = RxDataSourcesViewModel()
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.updateItems()
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
extension RxDataSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! tableViewCell
        cell.nameLabel.text = contents[indexPath.row]
        cell.nameLabel.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInsection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
