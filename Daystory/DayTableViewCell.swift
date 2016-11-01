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
            titleLabel.attributedText = event?.title?.attributedStr
            yearLabel.text = event?.year
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
        // 1.添加控件
        contentView.addSubview(pointImgView)
        contentView.addSubview(timelineImgView)
        contentView.addSubview(yearLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineLabel)
        // 2.部局控件
        let _ = pointImgView.sd_layout()
            .leftSpaceToView(contentView, 10)?
            .topSpaceToView(contentView, 15)?
            .widthIs(12)?
            .heightIs(12)
        let _ = timelineImgView.sd_layout()
            .centerXEqualToView(pointImgView)?
            .topSpaceToView(contentView, 0)?
            .widthIs(2)?
            .bottomSpaceToView(contentView, 0)
        let _ = yearLabel.sd_layout()
            .leftSpaceToView(pointImgView, 10)?
            .topEqualToView(pointImgView)?
            .widthIs(55)?
            .heightIs(12)
        let _ = titleLabel.sd_layout()
            .leftSpaceToView(yearLabel, 0)?
            .topEqualToView(pointImgView)?
            .rightSpaceToView(contentView, 10)?
            .autoHeightRatio(0)
        let _ = lineLabel.sd_layout()
            .leftEqualToView(titleLabel)?
            .topSpaceToView(titleLabel, 15)?
            .rightEqualToView(contentView)?
            .heightIs(1)
        titleLabel.setMaxNumberOfLinesToShow(0)
    }
    
    /// 返回 cell 行高
    ///
    /// - parameter model: model数据
    ///
    /// - returns: 行高
    func rowHight(model: QueryEvent) -> CGFloat {
        event = model
        self.layoutIfNeeded()
        return lineLabel.frame.maxY
    }
    
    // MARK: - 懒加载
    /// 标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.isAttributedContent = true
        return label
    }()
    /// 年份
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.contentMode = UIViewContentMode.center
        return label
    }()
    /// 圆点
    lazy var pointImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 6
        imgV.image = #imageLiteral(resourceName: "red")
        return imgV
    }()
    /// 左侧导览线
    lazy var timelineImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = #imageLiteral(resourceName: "red")
        return imgV
    }()
    /// 分隔线
    lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
}
