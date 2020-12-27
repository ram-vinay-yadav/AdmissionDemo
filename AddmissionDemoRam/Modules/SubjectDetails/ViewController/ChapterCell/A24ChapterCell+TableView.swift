//
//  A24ChapterCell+TableView.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 26/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

//MARK:- TableViewDataSource
extension A24ChapterCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.chapterDetails?.isLocked ?? true {
            return 0
        } else {
            return self.chapterDetails?.topicList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: A24TopicCell.defaultReuseIdentifier) as? A24TopicCell else {
            return UITableViewCell()
        }
        
        let topic = self.chapterDetails?.topicList?[indexPath.row]
        cell.topicNameLabel.text = topic?.title
        cell.topicDetailsLabel.text = topic?.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        debugPrint("selected index : ", indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        debugPrint("willDisplay")
    }
    
}
