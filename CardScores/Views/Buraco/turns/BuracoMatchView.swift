//Created by Halbus Development

import SwiftUI
import PhotosUI
import UIKit

struct BuracoMatchView: View {
    @EnvironmentObject var buracoMatchVM: BuracoMatchViewModel
    @EnvironmentObject private var buracoTurnVM: BuracoTurnsViewModel
    @StateObject private var storageVM = StorageViewModel()
    
    @State var matchFB: BuracoFBViewModel
    @State private var presentAddNewMatchTurnView: Bool = false
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
                            if let urlString = matchFB.imagePathUrl, let url = URL(string: urlString) {
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
            .onDisappear {
                buracoMatchVM.getMatches()
            }
            .onChange(of: buracoMatchVM.isMatchRecreated) { newValue in
                if newValue {
                    self.matchFB = BuracoFBViewModel(matchFB: buracoMatchVM.createdItem)
                    buracoTurnVM.getTurn(matchId: matchFB.id)
                    buracoMatchVM.scoreOne = matchFB.finalScoreOne
                    buracoMatchVM.scoreTwo = matchFB.finalScoreTwo
                    buracoMatchVM.gameOver = matchFB.gameOver
                }
            }
            .onAppear(perform: {
                buracoTurnVM.getTurn(matchId: matchFB.id)
                buracoMatchVM.scoreOne = buracoMatchVM.createdItem.finalScoreOne
                buracoMatchVM.scoreTwo = buracoMatchVM.createdItem.finalScoreTwo
                buracoMatchVM.gameOver = buracoMatchVM.createdItem.gameOver
                
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
                                            storageVM.saveMatchImage(userId: "\(buracoMatchVM.userId)", item: imageData, matchId: matchFB.id)
                                        }
                                        
                                        self.freshImage = Image(uiImage: uiimage)
                                    }
                                    
                                    self.presentSelectedImage.toggle()
                                }
                        }
                        
                        if !buracoMatchVM.gameOver {
                            Button {
                                presentAddNewMatchTurnView.toggle()
                                
                            } label: {
                                Image(systemName: "plus.circle")
                                    .bold()
                            }
                            .buttonStyle(.borderless)
                            .tint(Color.white)
                            .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                                AddNewMatchTurnView(matchFB: matchFB)
                                    .interactiveDismissDisabled()
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
            Text(!buracoMatchVM.gameOver ? "Partida Em Andamento" : "Partida Encerrada")
                .font(.title3)
                .foregroundColor(.white)
            
            HStack {
                VStack (alignment: .leading) {
                    Text(matchFB.playerOne)
                    Text(matchFB.playerTwo)
                    Text(buracoMatchVM.scoreOne)
                        .font(.title3)
                        .foregroundStyle(Int(buracoMatchVM.scoreOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoMatchVM.scoreOne) ?? 0 > Int(buracoMatchVM.scoreTwo) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(matchFB.playerThree)
                    Text(matchFB.playerFour)
                    Text(buracoMatchVM.scoreTwo)
                        .font(.title3)
                        .foregroundStyle(Int(buracoMatchVM.scoreTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoMatchVM.scoreTwo) ?? 0 > Int(buracoMatchVM.scoreOne) ?? 0 ? .bold : .regular)
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
            
            if buracoTurnVM.turns.isEmpty {
                VStack {
                    Text("Clique \(Image(systemName: "plus.circle")) para adcionar os pontos de cada rodada.")
                        .foregroundStyle(.black)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(Color.mainButtonColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 2)
                        .stroke(Color.gray, lineWidth: 2)
                )
            } else {
                VStack {
                    ForEach(buracoTurnVM.turns) { matchResume in
                        HStack(spacing: 5) {
                            VStack {
                                Text("\(matchResume.scoresTurnOne)")
                                    .foregroundStyle(Int(matchResume.scoresTurnOne) ?? 0 < 0 ? Color.red : Color.black)
                            }
                            .frame(width: 50, alignment: .trailing)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.myTime.formatted(date: .abbreviated, time: .shortened))
                                    .foregroundStyle(.black)
                                    .font(.caption)
                            }
                            .frame(width: 180, alignment: .center)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(matchResume.scoresTurnTwo)")
                                    .foregroundStyle(Int(matchResume.scoresTurnTwo) ?? 0 < 0 ? Color.red : Color.black)
                            }
                            .frame(width: 50, alignment: .leading)
                            
                        }
                        .font(.callout)
                        .padding(.horizontal, 15)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(Color.mainButtonColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 2)
                        .stroke(Color.gray, lineWidth: 2)
                )
                
                if buracoMatchVM.gameOver {
                    Button {
                        buracoMatchVM.recreateMatch(matchFB: MatchFB(scoreToWin: matchFB.scoreToWin, playerOne: matchFB.playerOne, playerTwo: matchFB.playerTwo, playerThree: matchFB.playerThree, playerFour: matchFB.playerFour, finalScoreOne: "", finalScoreTwo: "", friendsId: matchFB.friendsId, myDate: Date(), registeredUser: matchFB.registeredUser, docId: "", gameOver: false))
                    } label: {
                        VStack {
                            Text("Recriar essa partida.")
                                .foregroundStyle(Color.mainButtonColor)
                                .font(.callout)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: 2)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    BuracoMatchView(matchFB: BuracoFBViewModel(matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [""], myDate: Date(), registeredUser: false, docId: "", gameOver: false)))
}
