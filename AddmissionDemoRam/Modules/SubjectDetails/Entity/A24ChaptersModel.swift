//
//  A24ChaptersModel.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

struct A24ChaptersModel {
    
    let chapter:String
    let topic:String
    let topicList:[A24TopicModel]?
    let details:String
    var isLocked:Bool
    var isOpen:Bool
    
    init(chapter:String, topic:String, topicList:[A24TopicModel], details:String, isLocked:Bool, isOpen:Bool) {
        self.chapter = chapter
        self.topic = topic
        self.topicList = topicList
        self.details = details
        self.isLocked = isLocked
        self.isOpen = isOpen
    }
    
    mutating func updateOpen() {
        self.isOpen = !self.isOpen
    }
    
}



struct A24TopicModel {
    let title:String
    let details:String
    let completedPer:Int
    
    init(title:String, detail:String, complete:Int) {
        self.title = title
        self.details = detail
        self.completedPer = complete
    }
    
}
