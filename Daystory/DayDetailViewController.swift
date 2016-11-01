//
//  DayDetailViewController.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/16.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SVProgressHUD

class DayDetailViewController: UIViewController {

    /// 事件 id
    var e_id: String?
    
    var dayDetailView: DayDetailView?
    
    init(e_id: String) {
        self.e_id = e_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.设置ui
        view = DayDetailView()
        dayDetailView = view as! DayDetailView?
        // 2.加载网络数据
        loadData()
    }

    /// 加载网络数据
    func loadData() {
        SVProgressHUD.show()
        QureyDetail.loadQueryDetail(e_id: e_id) { (detail, error) in
            if error == nil {
                SVProgressHUD.dismiss()
                self.dayDetailView?.detail = detail
            } else {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
