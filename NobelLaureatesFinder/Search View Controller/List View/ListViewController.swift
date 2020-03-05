//
//  ListViewController.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/4/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: [Destination] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
                
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let titleLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        titleLabel.text = "20 Nobel laureates\nclosest to your chosen year and location\nin ascending order"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.numberOfLines = 0
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
  
        cell.textLabel?.text = items[indexPath.item].nobelPrizeLaureate.name
        cell.detailTextLabel?.text = String(format: "%.0f", items[indexPath.item].nobelPrizeLaureate.year)

        return cell
    }
}
