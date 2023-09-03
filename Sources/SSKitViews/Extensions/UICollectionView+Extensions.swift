//
//  UICollectionView+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UICollectionView {
    
    func scrollToBottom(_ animated: Bool = true) {
        let numberOfRows = self.numberOfItems(inSection: self.numberOfSections - 1)
        if numberOfRows > 0 {
            self.scrollToItem(at: IndexPath(item: numberOfRows - 1, section: self.numberOfSections - 1), at: .bottom, animated: animated)
        }
    }
    
    func scrolledToBottom() -> Bool {
        return self.contentOffset.y >= (self.contentSize.height - self.bounds.size.height)
    }
    
    func register(_ cellName: String) {
        self.register(UINib(nibName: cellName, bundle: .main), forCellWithReuseIdentifier: cellName)
    }
    
}
