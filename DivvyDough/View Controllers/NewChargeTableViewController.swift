//
//  NewChargeTableViewController.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-08.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit
import libDivvyDough

class NewChargeTableViewController: UITableViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var confirmationLabel: UILabel!

    var selectedTrip: Trip!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(didTapCancelButton)

        amountTextField.addTarget(self, action: #selector(amountTextFieldDidChange), for: .editingChanged)

        confirmationLabel.textColor = view.tintColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func didTapCancelButton() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func amountTextFieldDidChange() {
        if let text = amountTextField.text, let float = Float(text) {
            confirmationLabel.text = "Charge each person \((float / Float(selectedTrip.memberNames.count)).asDollars)"
        } else {
            confirmationLabel.text = "Charge each person $0.00"
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 1) {
            tableView.deselectRow(at: indexPath, animated: true)
            if let description = descriptionTextField.text, let amountString = amountTextField.text, let amount = Float(amountString) {
                leaderCharge(tripId: selectedTrip.id, description: description, amount: amount / Float(selectedTrip.memberNames.count)) { [unowned self] error in
                    guard error == nil else {
                        DispatchQueue.main.async { [unowned self] in
                            self.presentAlert(message: "Could not charge.")
                        }
                        return
                    }

                    DispatchQueue.main.async { [unowned self] in
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
