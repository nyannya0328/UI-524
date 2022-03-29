//
//  Home.swift
//  UI-524
//
//  Created by nyannyan0328 on 2022/03/29.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @State var expandCard : Bool = false
    @State var currentCard : Album?
    @State var showDetail : Bool = false
    @State var currentIndex : Int = -1
    
    @State var cardSize : CGSize = .zero
    @State var animtedDetailView : Bool = false
    @State var rotatedCard : Bool = false
    @State var showDtailContent : Bool = false
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title3)
                        
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        
                }

            }
            .overlay {
                
                Text("My Playlist")
                    .font(.title.weight(.ultraLight))
                    
            }
            .padding()
            .foregroundColor(.black)
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
                StackPlayerView(size: size)
                    .frame(width: size.width, height: size.height)
                
            }
            
            VStack(alignment:.leading,spacing:15){
                
                Text("Recent Played")
                    .font(.title2.weight(.semibold))
                    .padding(.leading,10)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing:15){
                        
                        ForEach(albums){alubum in
                            
                            Image(alubum.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 95, height: 95)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                        }
                        
                    }
                    
                    .padding([.horizontal,.bottom])
                    
                }
                
                
                
            }
            
            
        }
        .padding(.vertical,10)
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
        .background(Color("BG").ignoresSafeArea())
        .overlay {
            
            
            if let currentCard = currentCard,showDetail {
                
                
                ZStack{
                    
                    Color("BG").ignoresSafeArea()
                    
                    DetailView(currentCard: currentCard)
                    
                    
                }
            }
            
        }
    }
    @ViewBuilder
    func DetailView(currentCard : Album)->some View{
        
        
        VStack(spacing:0){
            
       
            
            Button {
                
                rotatedCard = false
                
                withAnimation {
                    animtedDetailView = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                        
                       
                        self.currentIndex = -1
                        self.currentCard = nil
                        showDetail = false
                        animtedDetailView = false
                        
                        
                       
                    }
                    
                    
                }
                
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding([.horizontal,.top])
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing:25){
                    
                    Image(currentCard.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cardSize.width, height: cardSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                      
                        .rotation3DEffect(.init(degrees: animtedDetailView && showDetail ? -180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .rotation3DEffect(.init(degrees: animtedDetailView && showDetail ? 180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .matchedGeometryEffect(id: currentCard.id, in: animation)
                        .padding(.top,50)
                    
                    
                    VStack{
                        
                        
                        Text(currentCard.albumName)
                            .font(.title)
                            .padding(.top,20)
                        
                        HStack(spacing:20){
                            
                            Button {
                                
                            } label: {
                                
                                Image(systemName: "shuffle")
                                    .font(.title2)
                            }

                            Button {
                                
                            } label: {
                                
                                Image(systemName: "pause.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 55, height: 55)
                                    .background{
                                        
                                        
                                        Circle()
                                            .fill(Color("Blue"))
                                        
                                        
                                    }
                                    
                            }

                            Button {
                                
                            } label: {
                                
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.title2)
                            }

                            
                            
                            
                            
                        }
                        .foregroundColor(.black)
                        .padding(.top,10)
                        
                        Text("UpComming Soon")
                            .font(.title3.bold())
                            .padding(.top,15)
                            .frame(maxWidth:.infinity,alignment: .leading)
                        
                        
                        ForEach(albums){album in
                            
                            AlbumCardView(album: album)
                            
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    .offset(y: showDtailContent ? 0 : 300)
                    .opacity(showDtailContent ? 1 : 0)
                    
                }
                
            }

            
        }
        .onAppear {
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                
                withAnimation(.easeInOut){
                    
                    showDtailContent = true
                    
                }
                
            }
        }
        
        
        
    }
    @ViewBuilder
    func AlbumCardView(album : Album)-> some View{
        
        
        HStack(spacing:15){
            
            
            Image(album.albumImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text(album.albumName)
                    .font(.body)
                
                HStack(spacing:12){
                    
                    Image(systemName: "headphones")
                        .font(.title3)
                    
                    Text("678.789.999")
                }
                .foregroundColor(.gray)
                
                
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            Button {
                
            } label: {
                
                Image(systemName: album.isLiked ? "suit.heart.fill" : "suit.heart")
                    .font(.title2)
                    .foregroundColor(album.isLiked ? .red : .gray)
            }
            
            
            Button {
                
            } label: {
                
                Image(systemName: "ellipsis")
                    .font(.callout)
                    .rotationEffect(.init(degrees: -90))
            }


            
            
            
        }
        .background(Color("BG"))
     
        
        
    }
    @ViewBuilder
    func StackPlayerView(size : CGSize)->some View{
        
        let offsetHight = size.height * 0.1
        
        
        ZStack{
            
            ForEach(stackAlbums.reversed()){alubum in
                
                let index = getIndex(album: alubum)
                let imageSize = (size.width - CGFloat(index * 20))
                
                Image(alubum.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize / 2, height: imageSize / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                    .rotation3DEffect(.init(degrees: expandCard && currentIndex != index  ? -10 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                    .rotation3DEffect(.init(degrees: showDetail && currentIndex == index && rotatedCard ? 360 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                
                
                    .matchedGeometryEffect(id: alubum.id, in: animation)
                    .offset(y: CGFloat(index) * -20)
                    .offset(y: expandCard ? -CGFloat(index) * offsetHight : 0)
                    .onTapGesture {
                        
                        
                        
                        if expandCard{
                            
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                                
                                cardSize = CGSize(width: imageSize / 2, height: imageSize / 2)
                                currentCard = alubum
                                currentIndex = index
                                showDetail = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    
                                    
                                    withAnimation(.spring()){
                                        
                                        animtedDetailView = true
                                    }
                                }
                                
                                
                              
                            }
                            
                            
                            
                        }
                        else{
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                                
                                
                                
                                expandCard = true
                            }
                            
                            
                        }
                    }
                    .offset(y: showDetail && currentIndex != index ? size.height * (currentIndex < index ? -1 : 1) : 0)
                    
                
            }
            
            
            
            
        }
        .offset(y: expandCard ? offsetHight * 2 : 0)
        .frame(width: size.width, height: size.height)
        .contentShape(Rectangle())
        .onTapGesture {
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                
                
                
                expandCard.toggle()
            }
        }
        
    }
    func getIndex(album : Album)->Int{
        
        return stackAlbums.firstIndex { currentAlbum in
            
            album.id == currentAlbum.id
        } ?? 0
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
