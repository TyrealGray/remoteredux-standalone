//
//  ContactListTableViewController.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/24/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit
import AddressBook

class ContactListTableViewController: UITableViewController {
    
    var contactsData:[ContactItem] = []
    
    var addressBook:ABAddressBookRef?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initContactData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactsData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactData", forIndexPath: indexPath)
        
        let item = contactsData[indexPath.row] as ContactItem
        cell.textLabel?.text = item.firstName
        cell.detailTextLabel?.text = item.lastName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func initContactData(){
        var error:Unmanaged<CFErrorRef>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        
        
        let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
        if (sysAddressBookStatus == ABAuthorizationStatus.NotDetermined) {
            //addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    
                    self.readRecords();
                }
                else {
                    print("error")
                }
            })
        }
        else if (sysAddressBookStatus == ABAuthorizationStatus.Denied ||
            sysAddressBookStatus == ABAuthorizationStatus.Restricted) {
            print("access denied")
        }
        else if (sysAddressBookStatus == ABAuthorizationStatus.Authorized) {
            print("access granted")
            
            self.readRecords();
        }
    }
    
    private func readRecords(){
        
        self.contactsData.removeAll()
        
        let sysContacts:NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook)
            .takeRetainedValue() as NSArray
        
        for contact in sysContacts {
            
            let lastName = ABRecordCopyValue(contact, kABPersonLastNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            
            let firstName = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            
            self.contactsData.append(ContactItem(firstName: firstName,lastName: lastName))
            
            
        }
    }

}
