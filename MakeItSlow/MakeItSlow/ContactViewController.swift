//
//  ContactViewController.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/20/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//



import UIKit
import AddressBook
import AddressBookUI

class ContactViewController: UIViewController {
    
    //address Book
    var addressBook:ABAddressBookRef?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var error:Unmanaged<CFErrorRef>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        

        let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
        if (sysAddressBookStatus == ABAuthorizationStatus.NotDetermined) {
            print("requesting access...")
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
    

    func readRecords(){
        let sysContacts:NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook)
            .takeRetainedValue() as NSArray
        
        for contact in sysContacts {

            let lastName = ABRecordCopyValue(contact, kABPersonLastNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            print("lastname:")
            print(lastName)
            

            let firstName = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            print("firstname:")
            print(firstName)
            

            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
