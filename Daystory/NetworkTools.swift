//
//  NetworkTools.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/12.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let AppKey = "a1d85a8953046eac0960e8c15b8a47a8"
    
    static let tools:NetworkTools = {
        let url = URL(string: "http://v.juhe.cn/todayOnhistory/")
        let t = NetworkTools(baseURL: url )
        // 设置 AFN 能够接收的数据类型
        t.responseSerializer.acceptableContentTypes = (NSSet(objects:"application/json", "text/json", "text/javascript", "text/plain", "text/html")) as? Set<String>
        return t
    }()
    
    class func shareNetworkTools() -> NetworkTools {
        return tools
    }
}
