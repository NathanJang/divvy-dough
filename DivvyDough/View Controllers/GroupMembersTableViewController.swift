//
//  GroupMembersTableViewController.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit
import libDivvyDough

class GroupMembersTableViewController: UITableViewController {

    var balances = [(String, Float)]()

    var selectedTrip: Trip!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlDidChangeValue), for: .valueChanged)

        selectedTrip = (navigationController?.viewControllers.first as? TripsOverviewTableViewController)?.selectedTrip!
    }

    override func viewWillAppear(_ animated: Bool) {
        if balances.isEmpty {
            refreshControl?.beginRefreshing()
            if #available(iOS 11.0, *) {
                self.tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.adjustedContentInset.top - refreshControl!.frame.height), animated: false)
            } else {
                // Fallback on earlier versions
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentOffset.y - refreshControl!.frame.height), animated: false)
            }
            refreshControlDidChangeValue()
        }
    }

    @objc func refreshControlDidChangeValue() {
        getLeaderBalances(tripId: selectedTrip.id) { [unowned self] balances, error in
            guard error == nil else {
                DispatchQueue.main.async { [unowned self] in
                    self.presentAlert(message: "Unable to fetch members.")
                    self.refreshControl?.endRefreshing()
                }
                return
            }
            self.balances = balances ?? []
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return balances.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell

        // Configure the cell...
        cell.nameLabel.text = "\(balances[indexPath.row].0)\(indexPath.row == 0 ? " (Leader 👑)" : "")"
        cell.balanceLabel.text = isLeader ? balances[indexPath.row].1.asDollars : ""

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return balances.isEmpty ? "No members to show." : ""
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
