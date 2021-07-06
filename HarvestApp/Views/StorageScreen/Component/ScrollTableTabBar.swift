//
//  ScrollTableTabBar.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 21/06/2021.
//

import SwiftUI

// Sử dụngg View Builders..
struct ScrollTableTabBar<Content: View>: UIViewRepresentable {
    //  lưu SwiftUI View
    var content: Content
    
    var rect : CGRect
    
    @Binding var offset: CGFloat
    
    var tabs: [Any]
    
    let scrollView = UIScrollView()
    
    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: ()->Content) {
        self.content = content()
        self.rect = rect
        self._offset = offset
        self.tabs = tabs
    }
    func makeCoordinator() -> Coordinator {
        return ScrollTableTabBar.Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UIScrollView {
        setUpScrollView()
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        return scrollView
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.delegate = nil
        UIView.animate(withDuration: 0.4) {
            uiView.contentOffset.x = offset
        } completion: { (status) in
            if status {
                uiView.delegate = context.coordinator
            }
        }
    }
    func setUpScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    func extractView() -> UIView {
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view!
    }
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollTableTabBar
        init(parent: ScrollTableTabBar) {
            self.parent = parent
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}

