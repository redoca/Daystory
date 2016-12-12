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
        dayDetailView?.detailDelegate = self
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
}


extension DayDetailViewController: DayDetailViewDelegate {
    /// 图片浏览
    ///
    /// - Parameters:
    ///   - index: 显示 index
    ///   - urls: 图片 url 数组
    func imageClick(index: Int, urls: [URL]) {
        // 1.创建图片浏览器
        let vc = PhotoBrowserController(index: index, urls: urls)
        // 2.显示图片浏览器
        present(vc, animated: true, completion: nil)
    }
}
