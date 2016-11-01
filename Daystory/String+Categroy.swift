//
//  String+Categroy.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/27.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

extension String {
    /// String 转换带行间距的 NSAttributedString
    var attributedStr: NSAttributedString {
        let str: NSMutableAttributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        str.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, self.characters.count))
        return str
    }
}
