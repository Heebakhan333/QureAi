//
//  ListViewDataSource.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import Foundation
import UIKit

protocol ListViewDataSource: AnyObject {
    associatedtype Item
    var items: [Item] { get }
    func configureCell(_ cell: UITableViewCell, forItem item: Item, at indexPath: IndexPath)
    func configureCell(_ cell: UICollectionViewCell, forItem item: Item, at indexPath: IndexPath)
}

//To keep the methods optionals, added them in extension
//extension ListViewDataSource {
//   
//}
