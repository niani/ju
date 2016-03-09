//
//  AddCalendarInfoController.swift
//  ju
//
//  Created by niani on 2/17/16.
//  Copyright © 2016 niani. All rights reserved.
//

import UIKit

class AddCalendarInfoController: UIViewController, WXApiDelegate {

    @IBOutlet weak var addNavigationItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        initAddNavigationBar()
    }
    
    func initAddNavigationBar(){
        addNavigationItem.title = "新建事件"
        //创建右边按钮
        let rightBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save,
            target: self, action: "done")
        //创建左边按钮
        let leftBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: "cancel")
        //设置导航项右边的按钮
        addNavigationItem.setLeftBarButtonItem(leftBtn, animated: true)
        addNavigationItem.setRightBarButtonItem(rightBtn, animated: true)
    }
    
    func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
