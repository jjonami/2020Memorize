//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/15.
//

/**
 [MVVM]
 Model : "The Truth"
 1. UI Independent
 2. Data + Logic
 
 (데이터는 항상 model에서 view로 이동)
 
 View : read-only
 1. Reflects the Model ]
 2. Stateless -> 모든 state는 model에 있다
 3. Declared
 4. Reactive : Model 이 변경 될 때마다 자동은로 View를 업데이트
 
 ViewModel : glue -> bindding the  view to the model
 1. Interpreter for the data
  - notices changes in the model
  - publishes 'something changed'
 2. ViewModel을 view와 직접 대화하지 않음
 -> model이 변경되면 변경된 내용을 게시
 -> view가 해당 게시물을 subscribe
 -> 변경된게 있으면 view가 ViewModel에 변화에 대한 요청후 view에 반영, model에 전달되는 것은 없다
 3.Processes Intent (사용자의 의도)
 */

import SwiftUI

struct EmojiMemoryGameView: View {
    //@ObservedObject : property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes
    //{EmojiMemoryGame} ObserverableObject에서 objectWillChange.send()를 호출할 때마다 변경 사항을 다시 그린다
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: conerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else{
                RoundedRectangle(cornerRadius: conerRadius).fill()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let conerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

/**
[Layout]
1. Container View "offer" space to the Views inside them
2. Views then choose what size they want to be
3. Container Views then position the Views inside of them

[Container Views]
 - stacks(HStack, VStack) : divide up the space offered to them amongst their subviews
 - Spacder(minLength: CGFloat), Divider()
 - GeometryReader : SwiftUI 에서 View가 포함된 부모뷰(컨테이너)의 크기를 기준으로 View의 frame 조절
 */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
