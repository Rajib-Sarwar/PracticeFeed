//
//  FeedTableViewController.swift
//  Prototype
//
//  Created by Chowdhury Md Rajib Sarwar on 12/9/24.
//

import UIKit

final class FeedViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FeedimageCell")!
    }
}
