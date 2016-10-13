//
//  QueryEvent.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/13.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

class QueryEvent: BasicModel {

    /// 查询日期
    var day:String?
    /// 中文格式日期
    var data:String?
    /// 事件标题
    var title:String?
    /// 事件 id
    var e_id:String?
    
    
    /// 加载历史今天列表数据
    ///
    /// - parameter day:      日期 格式： "5/7"
    /// - parameter finished: 闭包回调 - 列表数据
    class func loadQueryEvent(day: String?, finished:@escaping (_ events: [QueryEvent]?,_ error: NSError?)->()) {
        // 1.接口地址
        let path = "queryEvent.php"
        // 2.判断是否有日期参数，没有的话取今日
        var day = day
        if day == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            // 设置时间的区域(真机必须设置, 否则可能不能转换成功)
            formatter.locale = Locale(identifier: "en")
            day = formatter.string(from: Date())
        }
        // 3.添加参数 参数不可为可选值
        let params = ["key": NetworkTools.AppKey as String,
                      "date": day! as String]
        NetworkTools.shareNetworkTools().get(path, parameters: params, progress: nil, success: { (_, JSON) in
            
            let jsonDic = JSON as! NSDictionary

            // 1.判断是接口返回是否正确
            let error_code = jsonDic["error_code"] as! Int
            if error_code == 0 {
                let events = dict2Model(jsonDic["result"] as! [[String: AnyObject]])
                finished(events, nil)
            } else {
                let error = NSError(domain: jsonDic["reason"] as! String, code: error_code, userInfo: nil)
                finished(nil, error)
            }
            
            }) { (_, error) in
                let error = error as NSError
                finished(nil, error)
        }
    }
    
    // 字典数组转换为模型数组
    class func dict2Model(_ list: [[String: AnyObject]]) -> [QueryEvent] {
        var models = [QueryEvent]()
        for dict in list {
            models.append(QueryEvent(dict:dict))
        }
        return models
    }
}
