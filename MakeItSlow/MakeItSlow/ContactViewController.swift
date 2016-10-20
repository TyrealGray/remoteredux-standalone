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
    
    //address Book对象，用来获取电话簿句柄
    var addressBook:ABAddressBookRef?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定义一个错误标记对象，判断是否成功
        var error:Unmanaged<CFErrorRef>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        
        //发出授权信息
        let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
        if (sysAddressBookStatus == ABAuthorizationStatus.NotDetermined) {
            print("requesting access...")
            //addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    //获取并遍历所有联系人记录
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
            //获取并遍历所有联系人记录
            self.readRecords();
        }
    }
    
    //获取并遍历所有联系人记录
    func readRecords(){
        let sysContacts:NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook)
            .takeRetainedValue() as NSArray
        
        for contact in sysContacts {
            //获取姓
            let lastName = ABRecordCopyValue(contact, kABPersonLastNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            print("姓：\(lastName)")
            
            //获取名
            let firstName = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            print("名：\(firstName)")
            

            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
