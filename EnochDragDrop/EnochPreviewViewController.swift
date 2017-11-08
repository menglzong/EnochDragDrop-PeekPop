//
//  EnochPreviewViewController.swift
//  EnochDragDrop
//
//  Created by meng on 2017/11/7.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochPreviewViewController: UIViewController {
    
    public var image: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图片预览"
        view.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageView.image = image
        view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let action =  UIPreviewAction(title: "嘿哈", style: .default) { (action, preViewController) in
            print("11111111111")
        }
        return [action]
    }
}
