//
//  AuthorizedViewController.swift
//  ju
//
//  Created by niani on 1/29/16.
//  Copyright © 2016 niani. All rights reserved.
//

import UIKit

class AuthorizedViewController: UIViewController {
    
    //请求权限
    @IBAction func settingBtn(sender: AnyObject) {
        //打开设置页面
        let openSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(openSettingsUrl!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
