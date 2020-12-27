//
//  A24Subject+TableView.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit
import SkeletonView

//MARK:- pull to refresh
extension A24SubjectDetailsViewController {
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    }
}

//MARK:- SkeletonTableViewDataSource
extension A24SubjectDetailsViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return A24ChapterCell.defaultReuseIdentifier
    }
    
}

extension A24SubjectDetailsViewController: SkeletonTableViewDelegate {
    // for header and footer details
}

//MARK:- TableViewDataSource
extension A24SubjectDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chapterList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.chapterList[indexPath.row].isLocked {
            if self.chapterList[indexPath.row].isOpen {
                return 80 + CGFloat(85 * (self.chapterList[indexPath.row].topicList?.count ?? 1))
            }
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: A24ChapterCell.defaultReuseIdentifier) as? A24ChapterCell else {
            return UITableViewCell()
        }
        
        cell.statusContainerView.isUserInteractionEnabled = true
        let tapOnStatusView = UITapGestureRecognizer(target: self, action: #selector(self.handleStatusViewTap(_:)))
        cell.statusContainerView.tag = indexPath.row
        cell.statusContainerView.addGestureRecognizer(tapOnStatusView)
        cell.cellSetupWith(data: self.chapterList[indexPath.row])
        cell.connectorView.isHidden = self.chapterList.count == indexPath.row+1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        debugPrint("selected index : ", indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.isShowAnimation {
            let rotationtransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
            cell.layer.transform = rotationtransform
            cell.alpha = 0.0
            
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }
        }
    }
    
    @objc func handleStatusViewTap(_ sender: UITapGestureRecognizer? = nil) {
        debugPrint("Clicked", sender?.view?.tag ?? 0)
        let index = sender?.view?.tag ?? 0
        self.isShowAnimation = false
        self.chapterList[index].updateOpen()
        self.detailsTableView.reloadData()
    }
    
}

//MARK:- header Expand-collaps view
extension A24SubjectDetailsViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Always update the previous values
        defer {
            self.previousScrollViewHeight = scrollView.contentSize.height
            self.previousScrollOffset = scrollView.contentOffset.y
        }
        let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
        let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)
        
        guard heightDiff == 0 else { return }
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateHeader(scrollView) {
            // Calculate new header height
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }
            // Header needs to animate
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
        }
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.detailsTableView.contentOffset = CGPoint(x: self.detailsTableView.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        self.chapterContainerLabel.alpha = percentage
        self.chpterLineImageView.alpha = percentage
        self.eBookContainerView.alpha = percentage

    }
    
    
}
