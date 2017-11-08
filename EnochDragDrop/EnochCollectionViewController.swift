//
//  EnochCollectionViewController.swift
//  EnochDrapDropDemo
//
//  Created by meng on 2017/11/7.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochCollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionView - Drag & Drop"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.collectionView)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/5
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 15, left: 12, bottom: 15, right: 12)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(EnochImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        //添加drag&drop
        collectionView.dragDelegate = self;
        collectionView.dropDelegate = self;
        collectionView.dragInteractionEnabled = true
        collectionView.reorderingCadence = .immediate
        
        return collectionView
    }()
    
    lazy public var dataSource: [UIImage] = {
        var array = [UIImage]()
        for i in 0...50 {
            let image = UIImage(named: "thumb" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    lazy var dragIndexPath: IndexPath = IndexPath(item: 0, section: 0)
}

extension EnochCollectionViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.dragIndexPath = indexPath
        let dragImage = self.dataSource[indexPath.item]
        let itemProvider = NSItemProvider.init(object: dragImage)
        let dragItem = UIDragItem.init(itemProvider: itemProvider)
        return [dragItem]
    }
    
    //刷新数据
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let indexPath = coordinator.destinationIndexPath
        let dragItem = coordinator.items.first?.dragItem
        let image = self.dataSource[self.dragIndexPath.item]
        
        collectionView.performBatchUpdates({
            self.dataSource.remove(at: self.dragIndexPath.item)
            self.dataSource.insert(image, at: (indexPath?.item)!)
            collectionView.moveItem(at: self.dragIndexPath, to: indexPath!)
        }, completion: nil)
        
        coordinator.drop(dragItem!, toItemAt: indexPath!)
    }
    
    //添加动画
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
}

extension EnochCollectionViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.collectionView.indexPathForItem(at: location)
        guard let _ = indexPath else {
            return nil
        }
        if (indexPath?.item)! < self.dataSource.count {
            let preview = EnochPreviewViewController()
            preview.image = self.dataSource[(indexPath?.item)!]
            return preview
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}

extension EnochCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EnochImageCell
        cell.imageView.image = self.dataSource[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let preview = EnochPreviewViewController()
        preview.image = self.dataSource[indexPath.item]
        self.navigationController?.pushViewController(preview, animated: true)
    }
    
}

