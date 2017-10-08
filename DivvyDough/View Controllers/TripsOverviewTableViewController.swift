//
//  TripsOverviewTableViewController.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit
import libDivvyDough

class TripsOverviewTableViewController: UITableViewController {

    var trips = [Trip]()

    var pastTrips = [Trip]()

    var selectedTrip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        tableView.register(UINib(nibName: "TripsOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "TripsOverviewTableViewCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlDidChangeValue), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.deselectSelectedRow(animated: animated)

        if trips.isEmpty {
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
            return trips.count
        default:
            return pastTrips.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Past Trips"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripsOverviewTableViewCell", for: indexPath) as! TripsOverviewTableViewCell

        // Configure the cell...
        switch indexPath.section {
        case 0:
            configure(cell: cell, for: trips[indexPath.row])
        default:
            configure(cell: cell, for: pastTrips[indexPath.row])
        }

        return cell
    }

    func configure(cell: TripsOverviewTableViewCell, for trip: Trip) {
        cell.tripNameLabel.text = trip.name
        cell.groupMembersLabel.text = "With \(trip.leader)\(trip.memberNames.count > 1 ? " & \(trip.memberNames.count - 1) others" : "")"
        cell.dateRangeLabel.text = "\(trip.startDate) – \(trip.endDate)"
        cell.balanceLabel.text = trip.balance > 0 ? trip.balance.asDollars : ""
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return trips.isEmpty ? "No trips." : ""
        default:
            return pastTrips.isEmpty ? "No past trips." : ""
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedTrip = trips[indexPath.row]
        default:
            selectedTrip = pastTrips[indexPath.row]
        }
        performSegue(withIdentifier: "ShowTripDetails", sender: self)
    }

    @objc func refreshControlDidChangeValue() {
        getAllTrips(currentUserId: currentUserId) { [unowned self] trips, pastTrips, error in
            guard error == nil else {
                DispatchQueue.main.async { [unowned self] in
                    self.presentAlert(message: "Unable to fetch trips!")
                    self.refreshControl?.endRefreshing()
                }
                return
            }
            if let trips = trips {
                self.trips = trips
            }
            if let pastTrips = pastTrips {
                self.pastTrips = pastTrips
            }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
