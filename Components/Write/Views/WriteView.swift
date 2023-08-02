//
//  WriteView.swift
//  Quill (iOS)
//
//  Created by PEXAVC on 7/21/23.
//

import Foundation
import Granite
import GraniteUI
import SwiftUI
import MarkdownView

struct WriteView: View {
    var kind: Write.Kind
    
    @Binding var title: String
    @Binding var content: String
    
    var additionalPadding: CGFloat = 0
    
    @State var minimize: Bool = false
    
    @State var id: UUID = .init()
    
    
    var body: some View {
        VStack {
            switch kind {
            case .compact:
                verticalContent
                    .adaptsToKeyboard()
            case .full:
                horizontalContent
            }
        }
        .onAppear {
            id = .init()
        }
    }
}

extension WriteView {
    var horizontalContent: some View {
        VStack(spacing: 0) {
            
            TextField("Title", text: $title)
                .textFieldStyle(.plain)
                .frame(height: 30)
                .font(.title3.bold())
                .padding(.horizontal, .layer3)

            Divider()
                .padding(.top, .layer2)
            
            HStack(spacing: 0) {
                if #available(macOS 13.0, iOS 16.0, *) {
                    TextEditor(text: $content)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.foreground)
                        .background(.clear)
                        .font(.title3.bold())
                        .scrollContentBackground(Visibility.hidden)
                        .padding(.layer3)
                } else {
                    TextEditor(text: $content)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.foreground)
                        .background(.clear)
                        .font(.title3.bold())
                        .padding(.layer3)
                }
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        MarkdownView(text: $content)
                            .markdownViewRole(.editor)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.layer3)
            }
        }
    }
    var verticalContent: some View {
        VStack(spacing: 0) {
            TextField("Title", text: $title)
                .textFieldStyle(.plain)
                .frame(height: 30)
                .font(.title3.bold())
                .padding(.horizontal, .layer3 + additionalPadding)
            
            Divider()
                .padding(.vertical, .layer2)
            
            ScrollView {
                ZStack {
                    if minimize == false {
                        VStack(alignment: .leading, spacing: 0) {
                            MarkdownView(text: $content)
                                .markdownViewRole(.editor)
                        }
                    }
                    
                    if minimize {
                        VStack {
                            HStack {
                                Spacer()
                                
                                Button {
                                    GraniteHaptic.light.invoke()
                                    minimize = false
                                } label : {
                                    Image(systemName: "arrow.up.and.down.square.fill")
                                        .font(.title2)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.top, .layer1)
                            
                            Spacer()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: minimize ? 36 : nil)
            .padding(.horizontal, .layer3)
            
            Divider()
                .padding(.vertical, .layer2)
            
            
            if #available(macOS 13.0, iOS 16.0, *) {
                TextEditor(text: $content)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.foreground)
                    .background(.clear)
                    .font(.title3.bold())
                    .scrollContentBackground(Visibility.hidden)
                    .padding(.horizontal, .layer3 + additionalPadding)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            KeyboardToolbarView(minimize: $minimize)
                        }
                    }
                    .id(id)
            } else {
                NavigationView {
                    ZStack {
                        Color.background
                        
                        TextEditor(text: $content)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.foreground)
                            .background(.clear)
                            .font(.title3.bold())
                            .padding(.horizontal, .layer3 + additionalPadding)
                            .id(id)
                            .toolbar {
                                
                                ToolbarItemGroup(placement: .keyboard) {
                                    KeyboardToolbarView(minimize: $minimize)
                                }
                            }
                            .frame(maxHeight: .infinity)
                            .hideNavBar()
                        
                    }
                }
                .inlineNavTitle()
            }
        }
    }
}

extension View {
    func hideNavBar() -> some View {
        #if os(iOS)
        self.navigationBarHidden(true)
        #else
        return self
        #endif
    }
    
    func inlineNavTitle() -> some View {
        #if os(iOS)
        return navigationBarTitleDisplayMode(.inline)
        #else
        return self
        #endif
    }
}

struct KeyboardToolbarView: View {
    @Binding var minimize: Bool
    
    var body: some View {
        Group {
            Button {
                GraniteHaptic.light.invoke()
                
                #if os(iOS)
                hideKeyboard()
                #endif
            } label : {
                if #available(macOS 13.0, iOS 16.0, *) {
                    Image(systemName: "keyboard.chevron.compact.down.fill")
                        .font(.headline)
                } else {
                    Image(systemName: "chevron.down")
                        .font(.headline)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button {
                GraniteHaptic.light.invoke()
                minimize.toggle()
            } label : {
                if minimize {
                    Image(systemName: "arrow.up.and.down.square.fill")
                        .font(.headline)
                    
                } else {
                    Image(systemName: "minus.square.fill")
                        .font(.headline)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

