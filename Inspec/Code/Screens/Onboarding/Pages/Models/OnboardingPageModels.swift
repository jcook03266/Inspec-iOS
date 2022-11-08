//
//  OnboardingPageModels.swift
//  Inspec
//
//  Created by Justin Cook on 11/5/22.
//

import SwiftUI

struct OnboardingPages {
    let pageManager: VOCViewModel
    
    // MARK: - View Layout parameters, grid based display in a scrollView
    static var gridItemLayout: [GridItem] = [GridItem(spacing: 0)]
    
    // MARK: - Pages
    var page_1: VOCPageViewModel {
        let id: Int = 0,
            pageNumber: Int = convertIDtoPageNumber(id: id),
            title: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_1_TITLE),
            message: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_1_MESSAGE),
            backgroundGraphics: AnyView = getBackgroundGraphicsView(for: .one)
        
        return VOCPageViewModel(id: id,
                                manager: pageManager,
                                pageNumber: pageNumber,
                                title: title,
                                message: message,
                                lottieAnimation: .person_at_computer,
                                backgroundGraphics: backgroundGraphics)
    }
    
    var page_2: VOCPageViewModel {
        let id: Int = 1,
            pageNumber: Int = convertIDtoPageNumber(id: id),
            title: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_2_TITLE),
            message: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_2_MESSAGE),
            backgroundGraphics: AnyView = getBackgroundGraphicsView(for: .two)
        
        return VOCPageViewModel(id: id,
                                manager: pageManager,
                                pageNumber: pageNumber,
                                title: title,
                                message: message,
                                lottieAnimation: .gpu_isometric,
                                backgroundGraphics: backgroundGraphics)
    }
    
    var page_3: VOCPageViewModel {
        let id: Int = 2,
            pageNumber: Int = convertIDtoPageNumber(id: id),
            title: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_3_TITLE),
            message: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_3_MESSAGE),
            backgroundGraphics: AnyView = getBackgroundGraphicsView(for: .three)
        
        return VOCPageViewModel(id: id,
                                manager: pageManager,
                                pageNumber: pageNumber,
                                title: title,
                                message: message,
                                lottieAnimation: .ai_assistant_bot,
                                backgroundGraphics: backgroundGraphics)
    }
    
    var page_4: VOCPageViewModel {
        let id: Int = 3,
            pageNumber: Int = convertIDtoPageNumber(id: id),
            title: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_4_TITLE),
            message: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_4_MESSAGE),
            backgroundGraphics: AnyView = getBackgroundGraphicsView(for: .four)
        
        return VOCPageViewModel(id: id,
                                manager: pageManager,
                                pageNumber: pageNumber,
                                title: title,
                                message: message,
                                lottieAnimation: .teamwork,
                                backgroundGraphics: backgroundGraphics)
    }
    
    // MARK: - Init
    init(pageManager: VOCViewModel) {
        self.pageManager = pageManager
    }
    
    // MARK: - Convenient functions
    private func convertIDtoPageNumber(id: Int) -> Int {
        return id + 1
    }
    
    private func convertPageNumbertoID(pageNumber: Int) -> Int {
        return pageNumber - 1
    }
    
    func getPageFor(page: OnboardingPages.pages) -> VOCPageViewModel {
        switch page {
        case .one:
            return page_1
        case .two:
            return page_2
        case .three:
            return page_3
        case .four:
            return page_4
        }
    }
    
    func getBackgroundGraphicsView(for page: OnboardingPages.pages) -> AnyView {
        switch page {
        case .one:
            return AnyView(OBP_1_BackgroundGraphicsView())
        case .two:
            return AnyView(OBP_2_BackgroundGraphicsView())
        case .three:
            return AnyView(OBP_3_BackgroundGraphicsView())
        case .four:
            return AnyView(OBP_4_BackgroundGraphicsView())
        }
    }
    
    func getAllPages() -> [VOCPageViewModel] {
        var pageModels: [VOCPageViewModel] = []
        
        for page in pages.allCases {
            pageModels.append(getPageFor(page: page))
        }
        
        return pageModels
    }
    
    enum pages: String, CaseIterable {
        case one,
        two,
        three,
        four
    }
}

/// Useful struct for scaling the background images of each page to fit the device's dimensions properly
struct OBGraphicsScaler {
    /// The device height to base the scaling of the graphics around
    var referenceDeviceHeight: CGFloat = 1000
    var aspectRatioOfCurrentDevice: CGFloat {
        return DeviceConstants.getDeviceSize().1 / referenceDeviceHeight
    }
    
    var idealImageSize: CGSize
    var idealImageOffset: CGPoint
    
    var realImageSize: CGSize {
        let widthConversion = convertToAspectRatio(idealImageSize.width)
        let heightConversion = convertToAspectRatio(idealImageSize.height)
        
        return CGSize(width: widthConversion,
                      height: heightConversion)
    }
    var realImageOffset: CGPoint {
        return CGPoint(x: convertToAspectRatio(idealImageOffset.x),
                       y: convertToAspectRatio(idealImageOffset.y))
    }
    
    private func convertToAspectRatio(_ num: CGFloat) -> CGFloat {
        return num * aspectRatioOfCurrentDevice
    }
}
