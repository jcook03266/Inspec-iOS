//
//  VerticalOnboardingCarouselModels.swift
//  Inspec
//
//  Created by Justin Cook on 11/5/22.
//

import SwiftUI

// MARK: - Main Carousel
class VOCViewModel: ObservableObject, Identifiable {
    let id: Int
    private var pages: [VOCPageViewModel] = []
        
    @Published var currentPage: Int // 1-indexed
    @ObservedObject var progressBar: PartitionedProgressBarViewModel
    
    var pageCount: Int {
        return pages.count
    }
    var isOnFirstPage: Bool {
        return currentPage == 1
    }
    var isOnLastPage: Bool {
        return currentPage == pages.count
    }
    
    init(id: Int,
         pages: [VOCPageViewModel] = [])
    {
        self.id = id
        self.pages = pages
        self.progressBar = PartitionedProgressBarViewModel(progressBarCount: pages.count,
                                                           id: 0)
        self.currentPage = pages.count >= 1 ? 1 : 0
        
        setPageProperties()
    }
    
    private func setPageProperties() {
        for page in pages {
            page.manager = self
            page.assignedProgressBar = getProgressBarFor(pageID: page.id)
        }
    }
    
    func getProgressBarFor(pageID: Int) -> ProgressBarModel{
        if let targetProgressBar = progressBar.getProgressBarModel(for: pageID) {
            return targetProgressBar
        }
        else {
            preconditionFailure("The given page ID: \(pageID) does not have an assigned progress bar, \(#function)")
        }
    }
    
    func goForward() {
        updateCurrentPage(with: currentPage + 1)
        progressBar.progressForward()
    }
    
    func goBackward() {
        updateCurrentPage(with: currentPage - 1)
        progressBar.progressBackward()
    }
    
    // Note: Adding or removing a page resets the carousel and the progress bar
    func addPages(pages: [VOCPageViewModel]) {
        for page in pages {
            self.addPage(page: page)
        }
    }

    func addPage(page: VOCPageViewModel) {
        guard !doesContainPage(page), isValidPageNumber(pageNumber: page.pageNumber) else { return }
        
        pages.append(page)
        
        progressBar.updateModels(using: pages.count)
        currentPage = 1
        
        setPageProperties()
    }
    
    func removePages(pages: [VOCPageViewModel]) {
        for page in pages {
            self.removePage(page: page)
        }
    }
    
    func removePage(page: VOCPageViewModel) {
        guard doesContainPage(page), isPageWithinBounds(page: page) else { return }
        
        pages.removeAll(where: {
            $0 === page
        })
        
        progressBar.updateModels(using: pages.count)
        currentPage = pages.count >= 1 ? 1 : 0
        
        setPageProperties()
    }
    
    func updateCurrentPage(with pageNumber: Int) {
        guard pageNumber <= pageCount && pageNumber >= 1 else { return }
        
        currentPage = pageNumber
    }
    
    private func doesContainPage(_ page: VOCPageViewModel) -> Bool {
        return pages.contains(where: {
            $0 === page
        })
    }
    
    private func isPageNumberWithinBounds(pageNumber: Int) -> Bool {
        return pageNumber >= 1 && pageNumber <= pageCount
    }
    
    private func isPageWithinBounds(page: VOCPageViewModel) -> Bool {
        return isPageNumberWithinBounds(pageNumber: page.pageNumber)
    }
    
    // The pages must have sequential numbers, so this ensures that the next page follows the previous page's number sequentially
    private func isValidPageNumber(pageNumber: Int) -> Bool {
        return pageNumber >= 1 && pageNumber <= pageCount + 1
    }
}


// MARK: - Carousel Pages
class VOCPageViewModel: ObservableObject, Identifiable {
    let id: Int,
        pageNumber: Int, // 1-indexed
        title: String,
        message: String,
        backgroundGraphics: any View //Background visuals to be applied to the view
    
    @ObservedObject var manager: VOCViewModel
    var assignedProgressBar: ProgressBarModel? = nil
    
    var isCurrentPage: Bool {
        return manager.currentPage == self.pageNumber
    }
    var isFirstPage: Bool {
        return self.pageNumber == 1
    }
    var isLastPage: Bool {
        return self.pageNumber == manager.pageCount
    }
    
    init(id: Int,
         manager: VOCViewModel,
         progressBar: ProgressBarModel? = nil,
         pageNumber: Int,
         title: String,
         message: String,
         backgroundGraphics: any View)
    {
        self.id = id
        self.manager = manager
        self.assignedProgressBar = progressBar
        self.pageNumber = pageNumber
        self.title = title
        self.message = message
        self.backgroundGraphics = backgroundGraphics
    }
    
}
