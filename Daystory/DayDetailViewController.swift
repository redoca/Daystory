//
//  DayDetailViewController.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/16.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

class DayDetailViewController: UIViewController {

    /// 事件 id
    var e_id: String?
    
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
        setupUI()
        
        // 2.加载网络数据
        QureyDetail.loadQueryDetail(e_id: e_id) { (detail, error) in
            print(detail)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
