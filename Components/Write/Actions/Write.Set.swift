////
////  Write.Set.swift
////  Quill (iOS)
////
////  Created by PEXAVC on 7/21/23.
////
//
//import Foundation
//import SwiftUI
//import Granite
//import GraniteUI
//
//extension Write {
//    func setPostURL() {
//        let lastState: String = state.postURL
//        var value: String = ""
//        let bindingString = Binding<String>.init(get: {
//            return value
//        }, set: { newValue in
//            value = newValue
//        })
//        modal.presentSheet {
//            GraniteSheetView(title: "TITLE_SET_URL", height: 140) {
//                VStack(spacing: 0) {
//                    //TODO: localize
//                    TextField("URL", text: bindingString)
//                        .textFieldStyle(.plain)
//                        .frame(height: 40)
//                        .padding(.horizontal, .layer4)
//                        .font(.title3.bold())
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .foregroundColor(Color.alternateBackground.opacity(0.3))
//                        )
//                        .frame(minWidth: Device.isMacOS ? 400 : nil)
//
//                    HStack(spacing: .layer2) {
//                        Spacer()
//
//                        Button {
//                            GraniteHaptic.light.invoke()
//                            _state.postURL.wrappedValue = lastState
//                            modal.dismissSheet()
//                        } label: {
//                            Text("MISC_CANCEL")
//                                .font(.headline)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                        .padding(.trailing, .layer2)
//
//                        Button {
//                            GraniteHaptic.light.invoke()
//                            _state.postURL.wrappedValue = ""
//                            modal.dismissSheet()
//                        } label: {
//                            Text("MISC_REMOVE")
//                                .font(.headline)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                        .padding(.trailing, .layer2)
//
//                        Button {
//                            GraniteHaptic.light.invoke()
//                            _state.postURL.wrappedValue = value
//                            modal.dismissSheet()
//                        } label: {
//                            Text("MISC_DONE")
//                                .font(.headline)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//
//                        Spacer()
//                    }
//                    .padding(.top, .layer4)
//                }
//            }
//        }
//    }
//}
