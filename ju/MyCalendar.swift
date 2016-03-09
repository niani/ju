//
//  myCalendar.swift
//  test
//
//  Created by niani on 1/27/16.
//  Copyright © 2016 niani. All rights reserved.
//

import EventKit

class MyCalendar{
    
    //获取日历信息
    func getCalendarInfos() -> AnyObject{
        
        let eventStore:EKEventStore = EKEventStore()
        // 获取所有的事件（前后90天）
        let startDate = NSDate().dateByAddingTimeInterval(-3600*24*90)
        let endDate = NSDate().dateByAddingTimeInterval(3600*24*90)
        let predicate2 = eventStore.predicateForEventsWithStartDate(startDate,
            endDate: endDate, calendars: nil)
        
        print("查询范围 开始:\(startDate) 结束:\(endDate)")
        let eV = eventStore.eventsMatchingPredicate(predicate2) as [EKEvent]!
        for i in eV{
            print(i.eventIdentifier)
            let t = eventStore.eventWithIdentifier(i.eventIdentifier)! as EKEvent
            print(t.title)
        }
        
        
        
        //FBF5BDA0-0E6A-4F93-8C79-2B3D1677E3EC
        return eV
    }
    
   
    
    
    func test1()->AnyObject{
        let eventStore:EKEventStore = EKEventStore()
        
//        eventStore.requestAccessToEntityType(.Event, completion: {
//            granted, error in
//            if (granted) && (error == nil) {
//                print("granted \(granted)")
//                print("error  \(error)")
//             
//            }
//        })
        
        // 新建一个事件
        let event:EKEvent = EKEvent(eventStore: eventStore)
        event.title = "新增一个测试事件"
        event.startDate = NSDate()
        event.endDate = NSDate()
        event.notes = "这个是备注"
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do{
            try eventStore.saveEvent(event, span: .ThisEvent)
            print("Saved Event")
        }catch{}
        
        // 获取所有的事件（前后90天）
        let startDate=NSDate().dateByAddingTimeInterval(-3600*24*90)
        let endDate=NSDate().dateByAddingTimeInterval(3600*24*90)
        let predicate2 = eventStore.predicateForEventsWithStartDate(startDate,
            endDate: endDate, calendars: nil)
        
        print("查询范围 开始:\(startDate) 结束:\(endDate)")
        let eV = eventStore.eventsMatchingPredicate(predicate2) as [EKEvent]!
        
        //if eV != nil {
        for i in eV {
            print("标题  \(i.title)" )
            print("开始时间: \(i.startDate)" )
            print("结束时间: \(i.endDate)" )
        }
        //}
        return eV
    }
}
