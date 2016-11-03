//
//  DayDetailView.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/27.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SDAutoLayout

class DayDetailView: UIScrollView {
    
    var detail: QureyDetail? {
        didSet {
            titleLabel.text = detail?.title
            detailLabel.text = detail?.content
//            detailLabel.attributedText = detail?.content?.attributedStr
            self.layoutIfNeeded()
            contentSize = CGSize(width: 0, height: detailLabel.frame.maxY)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(lineLabel)
        addSubview(detailLabel)
        
        let _ = titleLabel.sd_layout()
            .leftSpaceToView(self, 10)?
            .topSpaceToView(self, 20)?
            .rightSpaceToView(self, 10)?
            .autoHeightRatio(0)
        titleLabel.setMaxNumberOfLinesToShow(0)
        
        let _ = lineLabel.sd_layout()
            .leftEqualToView(self)?
            .topSpaceToView(titleLabel, 20)?
            .rightEqualToView(self)?
            .heightIs(1)
        
        let _ = detailLabel.sd_layout()
            .leftSpaceToView(self, 10)?
            .topSpaceToView(lineLabel, 10)?
            .rightSpaceToView(self, 10)?
//            .heightIs(1000)
            .autoHeightRatio(0)
        detailLabel.setMaxNumberOfLinesToShow(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    /// 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    /// 分隔线
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    /// 内容
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
//        label.isAttributedContent = true
        return label
    }()
}
