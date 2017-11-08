//
//  EnochImageCell.swift
//  EnochDragDrop
//
//  Created by meng on 2017/11/7.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochImageCell: UICollectionViewCell {
    
    public let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.frame = self.contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EnochImageTableCell: UITableViewCell {
    
    public let picView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(picView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        picView.frame = self.contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
