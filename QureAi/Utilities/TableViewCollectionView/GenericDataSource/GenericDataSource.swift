//
//  GenericDataSource.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import UIKit

//class GenericListViewDataSource<Item, Cell: UITableViewCell, CollectionCell: UICollectionViewCell>: NSObject, UITableViewDataSource, UICollectionViewDataSource {
//    
//    weak var delegate: (any ListViewDataSource)?
//    
//    init(delegate: any ListViewDataSource) {
//        self.delegate = delegate
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return delegate?.items.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
//        if let item = delegate?.items[indexPath.row] {
//            delegate?.configureCell(cell, forItem: item, at: indexPath)
//        }
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDataSource
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return delegate?.items.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionCell.self), for: indexPath) as! CollectionCell
//        if let item = delegate?.items[indexPath.row] {
//            delegate?.configureCell(cell, forItem: item, at: indexPath)
//        }
//        return cell
//    }
//}
