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
        // Dispose of any resources that can be recreated.
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

        cell.textLabel?.text = events?[indexPath.row].title

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

