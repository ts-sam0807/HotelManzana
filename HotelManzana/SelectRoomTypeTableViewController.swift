//
//  SelectRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Ts SaM on 10/5/2023.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
  
  weak var delegate: SelectRoomTypeTableViewControllerDelegate?
  var roomType: RoomType?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RoomType.all.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
    let roomType = RoomType.all[indexPath.row]
    cell.textLabel?.text = roomType.name
    cell.detailTextLabel?.text = "$ \(roomType.price)"
    
    if roomType == self.roomType {
      cell.accessoryType = .checkmark
    }else{
      cell.accessoryType = .none
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let roomType = RoomType.all[indexPath.row]
    self.roomType = roomType
    delegate?.selectRoomTypeTableViewController(self, didSelect: roomType)
    tableView.reloadData()
  }
  
}

protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
  func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType)
}
