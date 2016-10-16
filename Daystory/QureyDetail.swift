
//
//  QureyDetail.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/16.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

class QureyDetail: BasicModel {
    var e_id: String?
    var title: String?
    var content: String?
    var picNo: String?
    var picUrl: [DetailPicUrl]?
    
    class func loadQueryDetail(e_id: String?, finished:@escaping (_ detail: QureyDetail?,_ error: NSError?)->()) {
        // 1.接口地址
        let path = "queryDetail.php"
        // 3.添加参数 参数不可为可选值
        let params = ["key": APIAppKey as String,
                      "e_id": e_id! as String]
        NetworkTools.shareNetworkTools().get(path, parameters: params, progress: nil, success: { (_, JSON) in
            let jsonDic = JSON as! NSDictionary
            // 1.判断是接口返回是否正确
            let error_code = jsonDic["error_code"] as! Int
            if error_code == 0 {
                let detail = QureyDetail(dict: (jsonDic["result"] as! [AnyObject]).first as! [String : AnyObject])
                finished(detail, nil)
            } else {
                let error = NSError(domain: jsonDic["reason"] as! String, code: error_code, userInfo: nil)
                finished(nil, error)
            }
        }) { (_, error) in
            let error = error as NSError
            finished(nil, error)
        }
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if "picUrl" == key { // 图片数组
            picUrl = DetailPicUrl.dict2Model(value as! [[String: AnyObject]])
            return
        }
        super.setValue(value, forKey: key)
    }
}

class DetailPicUrl: BasicModel {
    var pic_title: String?
    var id: Int = 0
    var url: String?
    
    // 字典数组转换为模型数组
    class func dict2Model(_ list: [[String: AnyObject]]) -> [DetailPicUrl] {
        var models = [DetailPicUrl]()
        for dict in list {
            models.append(DetailPicUrl(dict:dict))
        }
        return models
    }
}
