//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Ts SaM on 10/5/2023.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
  
  @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
    guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
          let registration = addRegistrationTableViewController.registration else { return }
    registrations.append(registration)
    tableView.reloadData()
  }
  
  var registrations: [Registration] = []
  var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return registrations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
    let registration = registrations[indexPath.row]
    cell.textLabel?.text = registration.firstName + " " + registration.lastName
    cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + ": " + registration.roomType.name
    return cell
  }

}
