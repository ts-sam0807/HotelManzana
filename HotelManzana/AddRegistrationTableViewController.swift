//
//  AddRegistrationTableTableViewController.swift
//  HotelManzana
//
//  Created by Ts SaM on 10/5/2023.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  
  @IBOutlet var checkInDateLabel: UILabel!
  @IBOutlet var checkInDatePicker: UIDatePicker!
  @IBOutlet var checkOutDateLabel: UILabel!
  @IBOutlet var checkOutDatePicker: UIDatePicker!
  
  @IBOutlet var numberOfAdultsLabel: UILabel!
  @IBOutlet var numberOfAdultsStepper: UIStepper!
  @IBOutlet var numberOfChildrenLabel: UILabel!
  @IBOutlet var numberOfChildrenStepper: UIStepper!
  
  @IBOutlet var wifiSwitch: UISwitch!
  @IBOutlet var roomTypeLabel: UILabel!
  
  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

  
  let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
  let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
  let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
  let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
  
  var isCheckInDatePickerVisible: Bool = false {
      didSet {
          checkInDatePicker.isHidden = !isCheckInDatePickerVisible
      }
  }
  var isCheckOutDatePickerVisible: Bool = false {
      didSet {
          checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
      }
  }
  
  var roomType: RoomType?
  var registration: Registration? {
    guard let roomType = roomType else { return nil }
    let firstName = firstNameTextField.text ?? ""
    let lastName = lastNameTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let checkInDate = checkInDatePicker.date
    let checkOutDate = checkOutDatePicker.date
    let numberOfAdults = Int(numberOfAdultsStepper.value)
    let numberOfChildren = Int(numberOfChildrenStepper.value)
    let hasWifi = wifiSwitch.isOn
    return Registration(
      firstName: firstName,
      lastName: lastName,
      emailAddress: email,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      numberOfAdults: numberOfAdults,
      numberOfChildren: numberOfChildren,
      wifi: hasWifi,
      roomType: roomType
    )
  }
  
  var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    return dateFormatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let midnightToday = Calendar.current.startOfDay(for: Date())
    checkInDatePicker.minimumDate = midnightToday
    checkInDatePicker.date = midnightToday
    
    updateDateViews()
    updateRoomType()
  }
  
  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case checkInDatePickerCellIndexPath where
      isCheckInDatePickerVisible == false:
      return 0
    case checkOutDatePickerCellIndexPath where
      isCheckOutDatePickerVisible == false:
      return 0
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
      isCheckInDatePickerVisible.toggle()
    } else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
      isCheckOutDatePickerVisible.toggle()
    } else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
      isCheckInDatePickerVisible.toggle()
      isCheckOutDatePickerVisible.toggle()
    } else {
      return
    }
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
    updateDateViews()
    updateNumberOfGuests()
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    updateNumberOfGuests()
  }
  
  @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
  }
  
  @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
    let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
    selectRoomTypeController?.delegate = self
    selectRoomTypeController?.roomType = roomType
    return selectRoomTypeController
  }
  
  
  func updateDateViews() {
    checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
    checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
    checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
  }
  
  func updateNumberOfGuests() {
    numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
    numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
  }
  
  func updateRoomType() {
    if let roomType = roomType {
      roomTypeLabel.text = roomType.name
    }else{
      roomTypeLabel.text = "Not Set"
    }
  }
  
  func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
    self.roomType = roomType
    updateRoomType()
  }
  
}
