//
//  WebViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/31.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    
    // MARK: - Property
    
    var url: String
    var navigationTitle: String
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private var webView = WKWebView()
    
    // MARK: - Life Cycle
    
    init(url: String, title: String) {
        self.url = url
        self.navigationTitle = title
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.configureBottomLine()
            $0.configureCenterTitle(to: navigationTitle)
            $0.configureBackButtonAction(popViewControllerAction())
        }
        
        setWebViewURL()
    }
    
    private func setWebViewURL() {

        guard let url = URL(string: self.url)
        else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
