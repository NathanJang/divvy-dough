//
//  TripDetailsTableViewController.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit
import libDivvyDough

class TripDetailsTableViewController: UITableViewController {

    var selectedTrip: Trip!

    var transactions = [Trip.Transaction]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UINib(nibName: "TransactionOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionOverviewTableViewCell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Others", style: .plain, target: self, action: #selector(didTapDetailsButton))

        selectedTrip = (navigationController?.viewControllers.first as? TripsOverviewTableViewController)?.selectedTrip!

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlDidChangeValue), for: .valueChanged)

    }

    override func viewWillAppear(_ animated: Bool) {
        if transactions.isEmpty {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        default:
            return transactions.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.section {
        case 0:
            let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            userCell.balanceLabel.text = selectedTrip.balance.asDollars
            cell = userCell

        default:
            let transactionCell = tableView.dequeueReusableCell(withIdentifier: "TransactionOverviewTableViewCell", for: indexPath) as! TransactionOverviewTableViewCell
            configure(transactionCell: transactionCell, for: transactions[indexPath.row])
            cell = transactionCell
        }

        // Configure the cell...

        return cell!
    }

    func configure(transactionCell: TransactionOverviewTableViewCell, for transaction: Trip.Transaction) {
        transactionCell.transactionNameLabel.text = transaction.name
        transactionCell.transactionTimeLabel.text = transaction.timestamp
        transactionCell.transactionAmountLabel.text = transaction.amount.asDollars
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 1:
            return transactions.isEmpty ? "No transactions." : ""
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 66
        }
    }

    @objc func refreshControlDidChangeValue() {
        getTransactions(tripId: selectedTrip.id, userId: currentUserId) { [unowned self] transactions, error in
            guard error == nil else {
                DispatchQueue.main.async { [unowned self] in
                    self.presentAlert(message: "Unable to fetch transactions.")
                    self.refreshControl?.endRefreshing()
                }
                return
            }
            self.transactions = transactions ?? []
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
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

    @objc func didTapDetailsButton() {
        performSegue(withIdentifier: "ShowGroupMembers", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
