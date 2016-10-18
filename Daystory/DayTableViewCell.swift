//
//  DayTableViewCell.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/17.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SDAutoLayout

class DayTableViewCell: UITableViewCell {

    var event: QueryEvent? {
        didSet {
            titleLabel.text = event?.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 初始化UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化UI
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        let _ = titleLabel.sd_layout().leftSpaceToView(contentView, 10)?.topSpaceToView(contentView, 10)?.rightSpaceToView(contentView, 10)?.bottomSpaceToView(contentView, 10)
    }
    
    // MARK: - 懒加载
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return label
    }()
}
