//
//  UITableView+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UITableView {
    
    func scrollToBottom(_ animated: Bool = true) {
        let numberOfRows = self.numberOfRows(inSection: self.numberOfSections - 1)
        if numberOfRows > 0 {
            self.scrollToRow(at: IndexPath(row: numberOfRows - 1, section: self.numberOfSections - 1), at: .bottom, animated: animated)
        }
    }
    
    func scrolledToBottom() -> Bool {
        return self.contentOffset.y >= (self.contentSize.height - self.bounds.size.height)
    }
  
    func register(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: .main), forCellReuseIdentifier: identifier)
    }
    
}
