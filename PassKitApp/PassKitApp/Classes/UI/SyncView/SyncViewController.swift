//
//  SyncViewController.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/10/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        activity.startAnimating()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateData:", name:NOTIFICATION_SYNC_COMPLETE, object: nil)

        SyncManager.sharedManager.start()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(notification: NSNotification){
        //Action take on Notification
        activity.stopAnimating()
        self.performSegueWithIdentifier("showMenu", sender: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
