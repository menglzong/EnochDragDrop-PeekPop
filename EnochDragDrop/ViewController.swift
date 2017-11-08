//
//  ViewController.swift
//  EnochDragDrop
//
//  Created by meng on 2017/11/7.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let array = ["DragVew", "DragCollectionView", "DragTableView"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Drag & Drop"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(EnochViewController.init(), animated: true)
        case 1:
            self.navigationController?.pushViewController(EnochCollectionViewController.init(), animated: true)
        case 2:
            self.navigationController?.pushViewController(EnochTableViewController.init(), animated: true)
        default:
            self.navigationController?.pushViewController(EnochCollectionViewController.init(), animated: true)
        }
    }
}

