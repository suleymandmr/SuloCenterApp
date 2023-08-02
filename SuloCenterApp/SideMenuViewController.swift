//
//  SideMenuViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 2.08.2023.
//

import UIKit
import SideMenu
class SideMenuViewController: UITableViewController {

    
       let menuItems = ["First", "Second"]
       weak var delegate: SideMenuDelegate?

       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return menuItems.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
           cell.textLabel?.text = menuItems[indexPath.row]
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedItem = menuItems[indexPath.row]
           delegate?.didSelectMenuItem(title: selectedItem)
       }
   }

   protocol SideMenuDelegate: AnyObject {
       func didSelectMenuItem(title: String)
   }

