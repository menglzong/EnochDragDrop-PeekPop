//
//  EnochPasteImageView.swift
//  EnochDrapDropDemo
//
//  Created by meng on 2017/11/1.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochPasteImageView: UIImageView {
    
    override func paste(itemProviders: [NSItemProvider]) {
        for dragItem in itemProviders {
            if dragItem.canLoadObject(ofClass: UIImage.self) {
                dragItem.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    if image != nil {
                        DispatchQueue.main.async {
                            self.image = (image as! UIImage)
                        }
                    }
                })
            }
        }
    }

}
