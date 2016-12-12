//
//  DayDetailView.swift
//  Daystory
//
//  Created by 王焕 on 2016/10/27.
//  Copyright © 2016年 王焕. All rights reserved.
//

import UIKit

import SDAutoLayout
import SDWebImage

//Swift 中定义协议需遵守NSObjectProtocol
protocol DayDetailViewDelegate: NSObjectProtocol {
    /// 图片浏览
    ///
    /// - Parameters:
    ///   - index: 显示 index
    ///   - urls: 图片 url 数组
    func imageClick(index: Int, urls: [URL])
}

class DayDetailView: UIScrollView {
    
    weak var detailDelegate: DayDetailViewDelegate?
    
    var detail: QureyDetail? {
        didSet {
            titleLabel.text = detail?.title
            detailLabel.attributedText = detail?.content?.attributedStr
            if detail!.picUrl!.count == 0 {
                imageBtn.setImage(nil, for: .normal)
                let _ = imageBtn.sd_resetLayout()
                .leftSpaceToView(self, 20)?
                .topSpaceToView(lineLabel, 20)?
                .rightSpaceToView(self, 20)?
                .heightIs(1)
            } else {
                activityIndicator.startAnimating()
                imageBtn.sd_setImage(with: detail!.picUrl!.first?.urlobj, for: .normal, completed: { (image, error, _, _) in
                    self.activityIndicator.stopAnimating()
                })
            }
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
        addSubview(imageBtn)
        addSubview(detailLabel)
        addSubview(activityIndicator)
        
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
        
        let _ = imageBtn.sd_layout()
            .leftSpaceToView(self, 20)?
            .topSpaceToView(lineLabel, 20)?
            .rightSpaceToView(self, 20)?
            .heightIs(160)
        
        let _ = activityIndicator.sd_layout()
            .centerXEqualToView(imageBtn)?
            .centerYEqualToView(imageBtn)
        
//        let _ = detailLabel.sd_layout()
//            .leftSpaceToView(self, 10)?
//            .topSpaceToView(lineLabel, 10)?
//            .rightSpaceToView(self, 10)?
//            .autoHeightRatio(0)
//        detailLabel.setMaxNumberOfLinesToShow(0)
        // SDAutoLayout autoHeightRatio 方法 会出现 cpu 点用过高
        detailLabel.xmg_AlignVertical(type: XMG_AlignType.bottomLeft, referView: imageBtn, size: nil, offset: CGPoint(x: 0, y: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    /// 图片点击
    private func imageBtnClick() {
        detailDelegate?.imageClick(index: 0, urls: detail!.urls!)
    }
    
    // MARK: - 懒加载
    /// 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
//        label.isAttributedContent = true
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 30 //限制最大宽度
        return label
    }()
    /// 图片按钮
    private lazy var imageBtn: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowOpacity = 0.80;
        btn.addTarget(self, action: #selector(DayDetailView.imageBtnClick), for: .touchUpInside)
        return btn
    }()
    /// 图片加载菊花
    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

}
