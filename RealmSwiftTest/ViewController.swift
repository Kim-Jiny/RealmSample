//
//  ViewController.swift
//  RealmSwiftTest
//
//  Created by Jiny on 2023/11/02.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  @IBOutlet weak var userInput: UITextField!
  @IBOutlet weak var returnTableView: UITableView!
  var readData:RootModelObject?
  let realmManager = RealmManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setDelegate()
  }
  
  func setDelegate() {
    returnTableView.delegate = self
    returnTableView.dataSource = self
  }
  
  func getDatetoString() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let stringDate = dateFormatter.string(from: date)
    return stringDate
  }

  @IBAction func saveBtt(_ sender: Any) {
    if let title = userInput.text {
      realmManager.writeRootModelObject(forKey: getDatetoString(), tasks: [SomeModelObject(title: title)])
      userInput.text = ""
    }
  }
  
  @IBAction func readBtt(_ sender: Any) {
    readData = realmManager.getRootModelObject(forKey: getDatetoString())
    returnTableView.reloadData()
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return readData?.tasks.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard (readData?.tasks.count ?? 0) > indexPath.row else { return UITableViewCell() }
    if let task = readData?.tasks[indexPath.row] {
      let cell = UITableViewCell()
      let lb = UILabel()
      lb.text = task.title
      cell.contentView.addSubview(lb)
      lb.frame = cell.contentView.bounds
      return cell
    }else {
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard (readData?.tasks.count ?? 0) > indexPath.row else { return }
    if let task = readData?.tasks[indexPath.row] {
      realmManager.deleteSomeModelObjectFromRootModel(rootKeyId: getDatetoString(), someModelId: task.id)
    }
  }
}
