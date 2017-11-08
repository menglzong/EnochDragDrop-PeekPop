//
//  EnochTableViewController.swift
//  EnochDragDrop
//
//  Created by meng on 2017/11/7.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class EnochTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView - Drag & Drop"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: tableView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.register(EnochImageTableCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        
        table.dragInteractionEnabled = true
        table.dragDelegate = self
        table.dropDelegate = self
        
        return table
    }()
    
    lazy public var dataSource: [UIImage] = {
        var array = [UIImage]()
        for i in 0...50 {
            let image = UIImage(named: "thumb" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    lazy var dragIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
}

extension EnochTableViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.tableView.indexPathForRow(at: location)
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

extension EnochTableViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.dragIndexPath = indexPath
        let image = self.dataSource[indexPath.row]
        let provider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let indexPath = coordinator.destinationIndexPath
        let dragItem = coordinator.items.first?.dragItem
        let image = self.dataSource[self.dragIndexPath.item]
        
        tableView.performBatchUpdates({
            self.dataSource.remove(at: self.dragIndexPath.item)
            self.dataSource.insert(image, at: (indexPath?.item)!)
            tableView.moveRow(at: self.dragIndexPath, to: indexPath!)
        }, completion: nil)
        
        coordinator.drop(dragItem!, toRowAt: indexPath!)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    
}

extension EnochTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EnochImageTableCell
        cell.picView.image = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let preview = EnochPreviewViewController()
        preview.image = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(preview, animated: true)
    }
    
}
