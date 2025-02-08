//
//  HTMLTextView.swift
//  CodeChallenge
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import SwiftUI
import WebKit

struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let fullHTML = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body { font-size: 18px; font-family: -apple-system; color: #333; margin: 0; padding: 10px; }
            a { color: blue; text-decoration: none; }
            img { max-width: 100%; height: auto; }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """

        webView.loadHTMLString(fullHTML, baseURL: nil)
    }
}
