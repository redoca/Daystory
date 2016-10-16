//
//  DayTableViewController.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/13.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SVProgressHUD

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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: eventsReuseIdentifier)

        // 加载数据
        loadData()
    }
    
    /// 加载历史上的今天列表数据
    func loadData() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: eventsReuseIdentifier, for: indexPath)

        let evnet = events![indexPath.row]
        
        cell.textLabel?.text = evnet.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events![indexPath.row]
        navigationController?.pushViewController(DayDetailViewController(e_id: event.e_id!), animated: true)
    }
}

