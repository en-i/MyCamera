//
//  ContentView.swift
//  MyCamera
//
//  Created by terada enishi on 2021/07/10.
//

import SwiftUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    
    @State var isShowSheet = false
    
    @State var isShowActivity = false
    
    @State var isPhotoLibrary = false
    
    @State var isShowAction = false
    var body: some View {
        VStack {
            Spacer()
            
            if let unwrapCaptureImage = captureImage{
                Image(uiImage: unwrapCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Button(action: {
                isShowAction = true
            }) {
                Text("カメラを起動する")
                    .frame( maxWidth: .infinity)
                    .frame(height: 50.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            
            .padding()
            .sheet(isPresented: $isShowSheet){
                if isPhotoLibrary{
                    PHPickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }else{
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }
            }
            
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                    message: Text("選択してください"),
                    buttons: [.default(Text("カメラ"),action: {
                        isPhotoLibrary = false
                        if UIImagePickerController.isSourceTypeAvailable(.camera){
                            isShowSheet = true
                        }else{
                            
                        }
                    }),
                    .default(Text("フォトライブラリー"),action: {
                        isPhotoLibrary = true
                        
                        isShowSheet = true
                    }),
                    .cancel()
                    ])
            }
            
            Button(action: {
                if let _ = captureImage{
                    isShowActivity = true
                }
            }) {
                Text("SNSに投稿する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                
                
            }
            .padding()
            .sheet(isPresented: $isShowActivity){
                ActivityView(shareItems: [captureImage!])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
