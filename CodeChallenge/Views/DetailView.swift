//
//  DetailView.swift
//  CodeChallenge
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let photo: FlickrPhoto

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: photo.media.m)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)
                
                Text(photo.title)
                    .font(.headline)
                    .accessibilityLabel(photo.title)

                Text(photo.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HTMLTextView(htmlContent: photo.description)
                    .frame(height: 500)
                    .accessibilityHidden(true)

                Text("Published: \(formattedDate(photo.published))")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Photo Details")
    }
    
    func formattedDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
