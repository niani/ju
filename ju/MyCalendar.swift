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
        return eV
    }
    
    //新增日历信息
    func addCalendarInfos(calendarInfo: EKEvent){
        
        let eventStore:EKEventStore = EKEventStore()
        let event:EKEvent = EKEvent(eventStore: eventStore)
        event.title = calendarInfo.title
        event.startDate = calendarInfo.startDate
        event.endDate = calendarInfo.endDate
        event.notes = calendarInfo.notes
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do{
            try eventStore.saveEvent(event, span: .ThisEvent)
            print("Saved Event")
        }catch{}
    }
}
