//
//  DayTableViewController.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/13.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SVProgressHUD
import SDAutoLayout

let eventsReuseIdentifier = "eventsReuseIdentifier"

class DayTableViewController: UITableViewController {
    
    var events: [QueryEvent]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "历史上的今天"
        tableView.register(DayTableViewCell.self, forCellReuseIdentifier: eventsReuseIdentifier)

        setupUI()
        
        // 加载数据
        loadData()
    }
    
    /// 设置UI
    private func setupUI() {
        navigationItem.leftBarButtonItem = leftBarBtnItem
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    func setDate() {
        
    }
    
    /// 加载历史上的今天列表数据
    private func loadData() {
        SVProgressHUD.show()
        QueryEvent.loadQueryEvent(day: nil) { (events, error) in
            if error == nil {
                self.events = events
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
        }
    }
    
    // MARK: - 懒加载
    private lazy var leftBarBtnItem = UIBarButtonItem(title: Date().dateMDChinese, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DayTableViewController.setDate))

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    // MARK: - Table view data source
extension DayTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: eventsReuseIdentifier, for: indexPath) as! DayTableViewCell
        cell.event = event
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let event = events![indexPath.row]
        let detailVC = DayDetailViewController(e_id: event.e_id!)
        detailVC.title = event.date
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let event = events![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: eventsReuseIdentifier) as! DayTableViewCell
        return cell.rowHight(model: event)
    }
}

