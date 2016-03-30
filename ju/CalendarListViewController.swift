//
//  CalendarListViewController.swift
//  ju
//
//  Created by niani on 2/24/16.
//  Copyright © 2016 niani. All rights reserved.
//

import UIKit
import EventKit

class CalendarListViewController: UIViewController{
    
    @IBOutlet weak var CalendarTableView: UITableView!
    @IBOutlet weak var CalendarTableViewNavigationItem: UINavigationItem!
    
    var calendarDatas = [EKEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendarsNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        checkCalendarAuthorizationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //init calendarsNavigationBar
    func initCalendarsNavigationBar(){
        CalendarTableViewNavigationItem.title = "事件列表"
        //创建左边按钮
        CalendarTableViewNavigationItem.leftBarButtonItem = self.editButtonItem()
        //创建右边按钮
        let rightBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "addInfo")
        //设置导航项右边的按钮
        CalendarTableViewNavigationItem.setRightBarButtonItem(rightBtn, animated: true)
    }
    
    //左侧编辑事件
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(!CalendarTableView.editing, animated: animated)
        CalendarTableView.setEditing(!CalendarTableView.editing, animated: true)
    }
    
    //跳转新增
    func addInfo(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("addView") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //检查日历权限
    func checkCalendarAuthorizationStatus(){
        let calendarSataus = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        switch (calendarSataus) {
        case EKAuthorizationStatus.NotDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.Authorized:
            // Things are in line with being able to show the calendars in the table view
            //跳转到加载页面
            loadCalendars()
        case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
            // We need to help them give us permission
            needAuthorization()
        }
    }
    
    //请求日历权限
    func requestAccessToCalendar(){
        let eventStore = EKEventStore()
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            (accessGranted: Bool, error: NSError?) in
            if accessGranted == true {
                //跳转到加载页面
                self.loadCalendars()
            }else{
                //跳转到权限请求界面
                self.needAuthorization()
            }
        })
    }
    
    //跳转到权限请求界面
    func needAuthorization(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AuthorizedView") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //加载日历信息
    func loadCalendars(){
        let calendars = MyCalendar()
        let eV = calendars.getCalendarInfos() as! [EKEvent]
        calendarDatas.removeAll()
        for i in eV {
            //print("标题  \(i.title)" )
            //print("开始时间: \(i.startDate)" )
            //print("结束时间: \(i.endDate)" )
            calendarDatas.append(i)
        }
        CalendarTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("calendarCell", forIndexPath: indexPath)
        let label = cell.viewWithTag(2) as! UILabel
        label.text = calendarDatas[indexPath.row].title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(calendarDatas[indexPath.row].title)")
        let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("detailView") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            calendarDatas.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
