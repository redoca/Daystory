//
//  BasicModel.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/13.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

class BasicModel: NSObject {
    
    // 字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    // forUndefinedKey
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
