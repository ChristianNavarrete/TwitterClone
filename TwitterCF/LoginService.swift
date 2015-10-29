//
//  DeviceTwitterAccount.swift
//  TwitterCF
//
//  Created by HoodsDream on 10/27/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
    
    //used for accessing the social accounts stored on the device
    class func loginTwitter(completionHandler: (errorDescription: String?, account: ACAccount?) -> ()) {
        
        
        //grabs the actual account
        let accountStore = ACAccountStore()
        
        //grabbing the account type so the we can put that into the ACAccountStore.requestAccessToAccountsWithType
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        //executing the .requestAccessToAccountsWithType request, includes CompletionHandler to handle success or error
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion:  { (success, error) -> Void in
            
            if let _ = error {
                //*** Why do we use this completion hander here, why not use a regular return error string???????
                completionHandler(errorDescription: "Request to access account error", account: nil); return
            }
            
            if success {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                 
                //*** Why dont we just return the account here????
                completionHandler(errorDescription: nil, account: account); return
                    
                }
                
                //Default goes to no devices were found message and nill ACAccount return
                completionHandler(errorDescription: "ERROR: No twitter accounts were found on device.", account: nil); return
                
            }
            
            
        })
    
    }
    
    
    
    
    
    
}



        
        
        

    
    
    
