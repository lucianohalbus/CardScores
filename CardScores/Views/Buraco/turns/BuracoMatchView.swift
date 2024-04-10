//Created by Halbus Development

import SwiftUI
import PhotosUI
import UIKit

struct BuracoMatchView: View {
    var matchFB: BuracoFBViewModel
    @State private var presentAddNewMatchTurnView: Bool = false
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var buracoTurnVM = BuracoTurnsViewModel()
    @StateObject private var storageVM = StorageViewModel()
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var selectedImage: Image? = nil
    @State private var url: URL? = nil
    
    @State private var freshImage: Image? = nil
    @State private var presentSelectedImage: Bool = false
    @State private var deleteImage: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack {
            
                matchResumeViewHeader
                
                ScrollView {
                    if !buracoTurnVM.turns.isEmpty {
                        matchResumeViewList
                        
                        if presentSelectedImage {
                            
                            VStack(spacing: 0) {
                                if let freshImage {
                                    
                                    freshImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            VStack(spacing: 0) {
                                if var urlString = matchFB.imagePathUrl, let url = URL(string: urlString) {
                                    if !self.deleteImage {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(10)
                                            
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 150, height: 150)
                                        }
                                        
                                        Button("Delete Image") {
                                            storageVM.deleteProfileImage(path: matchFB.imagePath ?? "", matchId: matchFB.id)
                                            self.deleteImage = true
                                        }
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .onAppear(perform: {
                buracoTurnVM.getTurn()
                buracoListVM.scoreOne = matchFB.finalScoreOne
                buracoListVM.scoreTwo = matchFB.finalScoreTwo
                buracoListVM.gameOver = matchFB.gameOver
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        
                        ToolBarLogo()
                            .padding(.trailing, 20)
                        
                      
                        
                        if !buracoTurnVM.turns.isEmpty {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 25, height: 20)
                                .padding(.trailing, 20)
                                .foregroundStyle(Color.white)
                                .onTapGesture { self.shouldPresentActionScheet = true }
                                .sheet(isPresented: $shouldPresentImagePicker) {
                                    
                                    SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                                      image: self.$selectedImage,
                                                      isPresented: self.$shouldPresentImagePicker
                                    )
                                }
                                .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                                    ActionSheet(title: Text("Choose mode"),
                                                message: Text("Choose a mode to set your profile image"),
                                                buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = true
                                    }),
                                                          
                                                          ActionSheet.Button.default(Text("Photo Library"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = false
                                    }),
                                                          
                                                          ActionSheet.Button.cancel()])
                                }
                                .onChange(of: selectedImage) { newValue in
                                    if let newValue {
                                        
                                        let uiimage: UIImage = newValue.asUIImage()
                                        
                                        if let imageData = storageVM.resizeImage(image: uiimage, targetSize: CGSize(width: 800, height: 800)) {
                                            storageVM.saveMatchImage(userId: "\(buracoListVM.userId)", item: imageData, matchId: matchFB.id)
                                        }
                                        
                                        self.freshImage = Image(uiImage: uiimage)
                                    }
                                    
                                    self.presentSelectedImage.toggle()
                                }
                        }
                        
                        if !buracoListVM.gameOver {
                            
                            Button {
                                presentAddNewMatchTurnView.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                                    .bold()
                            }
                            .buttonStyle(.borderless)
                            .padding(.trailing, 20)
                            .tint(Color.white)
                            .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                                
                                AddNewMatchTurnView(matchFB: matchFB)
                                    .interactiveDismissDisabled()
                                    .onDisappear(perform: {
                                        buracoTurnVM.getTurn()
                                        buracoListVM.getMatches()
                                    })
                            })
                        }
                    }
                }
            }
        }
        .background(Color.cardColor)
    }
    
    @ViewBuilder
    private var matchResumeViewHeader: some View {
        VStack {
            VStack {
                Text(!buracoListVM.gameOver ? "Partida Em Andamento" : "Partida Encerrada")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text(matchFB.playerOne)
                    Text(matchFB.playerTwo)
                    Text(buracoListVM.scoreOne)
                        .font(.title3)
                        .foregroundStyle(Int(buracoListVM.scoreOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreOne) ?? 0 > Int(buracoListVM.scoreTwo) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(matchFB.playerThree)
                    Text(matchFB.playerFour)
                    Text(buracoListVM.scoreTwo)
                        .font(.title3)
                        .foregroundStyle(Int(buracoListVM.scoreTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreTwo) ?? 0 > Int(buracoListVM.scoreOne) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.cardBackgroundColor)
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var matchResumeViewList: some View {
        VStack(spacing: 5) {
            VStack {
                ForEach(buracoTurnVM.turns) { matchResume in
                    if matchResume.turnId == matchFB.id {
                        
                        HStack(spacing: 5) {
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnOne) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnOne) ?? 0 < 0 ? Color.red : Color.white)
                            }
                            .frame(width: 50, alignment: .leading)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.myTime.formatted(date: .abbreviated, time: .shortened))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 180, alignment: .center)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnTwo) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnTwo) ?? 0 < 0 ? Color.red : Color.white)
                            }
                            .frame(width: 50, alignment: .trailing)
                            
                        }
                        .font(.callout)
                        .padding(.horizontal, 15)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 10)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 2)
                    .stroke(Color.white, lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }
    
}
