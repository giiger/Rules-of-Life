//
//  RuleMenuViewController.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/14/20.
//

import UIKit

class RuleMenuViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    
}

extension RuleMenuViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 256
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = String(format: "Rule %d", indexPath.row)
        return cell
    }
}

extension RuleMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RulesOfLife.shared.set(rule: Rule(mask: UInt8(indexPath.row)))
    }
}
