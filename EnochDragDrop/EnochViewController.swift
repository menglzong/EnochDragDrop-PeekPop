//
//  EnochViewController.swift
//  EnochDrapDropDemo
//
//  Created by meng on 2017/11/1.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochViewController: UIViewController {
    
    private var dragImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIView - Drag & Drop"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.darkGray
        dragImageView.frame = CGRect(x: 100, y: 64, width: 150, height: 150)
        dragImageView.image = UIImage(named: "1024")
        dragImageView.isUserInteractionEnabled = true
        view.addSubview(dragImageView)
        //添加drap
        let dragInteratcion = UIDragInteraction(delegate: self)
        dragInteratcion.isEnabled = true
        dragImageView.addInteraction(dragInteratcion)
        dragImageView.addInteraction(UIDropInteraction(delegate: self as UIDropInteractionDelegate))
        
        let pasteImageView = EnochPasteImageView(frame: CGRect(x: 100, y: 264, width: 150, height: 150))
        pasteImageView.backgroundColor = UIColor.white
        pasteImageView.isUserInteractionEnabled = true
        view.addSubview(pasteImageView)
        pasteImageView.pasteConfiguration = UIPasteConfiguration(forAccepting: UIImage.self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EnochViewController: UIDragInteractionDelegate, UIDropInteractionDelegate{
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let dragImage = self.dragImageView.image
        let itemProvider = NSItemProvider.init(object: dragImage!)
        let dragItem = UIDragItem.init(itemProvider: itemProvider)
        return [dragItem]
    }
}

